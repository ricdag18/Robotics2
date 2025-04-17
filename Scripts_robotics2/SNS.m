%===========================================================
%                SNS Function (Revised)
%===========================================================
function [new_values, old_values]= SNS_revised(task_in, J_array, constraint_min_in, constraint_max_in, velocity_initial_condition_in)
    % Implements Saturation in the Null Space (SNS) algorithm for velocity or acceleration control
    % Handles joint limits by saturating the most violating joint and projecting
    % the remaining task into the null space.
    % PARAMETERS:
    %   - task_in: Desired task velocity or acceleration [task_dim x 1]
    %   - J_array: Cell array containing Jacobian(s):
    %       - {J}     : For velocity control [task_dim x n_joint]
    %       - {J, dJ} : For acceleration control, dJ is [task_dim x n_joint]
    %   - constraint_min_in: Lower joint limits (velocity/acceleration) [n_joint x 1]
    %   - constraint_max_in: Upper joint limits (velocity/acceleration) [n_joint x 1]
    %   - velocity_initial_condition_in: Joint velocities [n_joint x 1]. Required ONLY for acceleration control. Pass zeros o [] per velocity control.
    % RETURNS:
    %   - new_values: Joint velocities/accelerations respecting limits [n_joint x 1]
    %   - old_values: Unconstrained joint velocities/accelerations [n_joint x 1]
    % --- Input Validation and Initialization ---
    if ~iscell(J_array)
        error('SNS: J_array must be a cell array, e.g., {J} or {J, dJ}.');
    end
    J = J_array{1};
    if isempty(J)
         error('SNS: Input Jacobian J is empty.');
    end
    [task_dim, n_joint] = size(J);
    if length(constraint_min_in) ~= n_joint || length(constraint_max_in) ~= n_joint
        error('SNS: Dimension mismatch between constraints and Jacobian columns.');
    end
    task = reshape(task_in, task_dim, 1);
    constraint_min = reshape(constraint_min_in, n_joint, 1);
    constraint_max = reshape(constraint_max_in, n_joint, 1);
    % Use NaN as a better indicator for unassigned values
    new_values = NaN(n_joint, 1);
    % --- Determine Task Type (Velocity or Acceleration) ---
    if isscalar(J_array)
        disp("---- SNS for velocity ----")
        type_task = 'v';
        dJ = zeros(task_dim, n_joint); % Placeholder, not used
        velocity_initial_condition = zeros(n_joint, 1); % Placeholder, not used
    elseif length(J_array) == 2
        disp("---- SNS for acceleration ----")
        type_task = 'a';
        dJ = J_array{2};
        if isempty(velocity_initial_condition_in) || length(velocity_initial_condition_in) ~= n_joint
             error('SNS: velocity_initial_condition required for acceleration and must have length n_joint.');
        end
        velocity_initial_condition = reshape(velocity_initial_condition_in, n_joint, 1);
        if size(dJ, 1) ~= task_dim || size(dJ, 2) ~= n_joint
            error('SNS: dJ dimensions mismatch.');
        end
    else
        error("SNS: J_array must contain {J} or {J, dJ}");
    end
    % --- Calculate Initial Unconstrained Solution ---
    try
        if type_task == 'v'
            old_values = pinv(J) * task;
        elseif type_task == 'a'
            old_values = pinv(J) * (task - dJ * velocity_initial_condition);
        end
        old_values = reshape(old_values, n_joint, 1); % Ensure column
        disp("Initial unconstrained solution:");
        disp(old_values');
    catch ME
        warning('SNS: Failed to calculate initial unconstrained solution: %s', ME.message);
        % Decide how to proceed: error out, or return NaNs/zeros?
        old_values = NaN(n_joint, 1); % Indicate failure
        new_values = NaN(n_joint, 1);
        return; % Exit if initial calculation fails
    end
    % --- Prepare Variables for Iterative Reduction ---
    active_joints = (1:n_joint)'; % Column vector of ORIGINAL indices currently active
    J_reduced = J;
    constraint_min_reduced = constraint_min;
    constraint_max_reduced = constraint_max;
    dJ_reduced = dJ; % Copy even for velocity case (simplifies code)
    velocity_initial_condition_reduced = velocity_initial_condition; % Copy even for velocity case
    task_reduced = task;
    tolerance = 1e-9; % Tolerance for checking violations and rank
    % --- Iterative Saturation Loop ---
    for i = 1:n_joint % Loop maximum n_joint times
        fprintf("==========> SNS Iteration: %d\n", i);
        num_remaining_joints = length(active_joints);
        if num_remaining_joints == 0
            disp("SNS: No remaining joints.");
            if norm(task_reduced) > tolerance % Check if task is fully achieved
                 warning('SNS: Task residual remaining with no active joints: %s', mat2str(task_reduced'));
            end
            break; % Exit loop if no joints left
        end
        fprintf("Active joints (original indices): %s\n", mat2str(active_joints'));
        fprintf("Current Task Residual: %s\n", mat2str(task_reduced'));
        % --- Calculate Solution for Remaining Joints ---
        current_solution_reduced = zeros(num_remaining_joints, 1); % Default to zero if calculation fails
        calculation_successful = false;
        if num_remaining_joints > 0 % Only calculate if joints remain
            try
                % Check rank before pinv
                if rank(J_reduced, tolerance) < min(size(J_reduced))
                   warning('SNS: Reduced Jacobian is rank deficient (Rank=%d, Size=[%d %d]). Using pseudoinverse, results may be approximate or non-unique.', rank(J_reduced, tolerance), size(J_reduced,1), size(J_reduced,2));
                   % Optional: Handle rank deficiency more specifically if needed (e.g., return error, use damped least squares)
                end
                
                % Visualizza la pseudoinversa della jacobiana ridotta
                disp("Pseudoinversa della jacobiana ridotta:");
                disp(pinv(J_reduced, tolerance));
                
                if type_task == 'v'
                    current_solution_reduced = pinv(J_reduced, tolerance) * task_reduced;
                elseif type_task == 'a'
                    % Check dimensions for matrix multiplication
                    if size(dJ_reduced, 2) ~= num_remaining_joints || size(velocity_initial_condition_reduced, 1) ~= num_remaining_joints
                       error('SNS Internal Error: Dimension mismatch during acceleration calculation. dJ:%dx%d, v:%dx1, expected %d columns/elements',...
                             size(dJ_reduced,1), size(dJ_reduced,2), size(velocity_initial_condition_reduced,1), num_remaining_joints);
                    end
                    task_accel_part = task_reduced - dJ_reduced * velocity_initial_condition_reduced;
                    current_solution_reduced = pinv(J_reduced, tolerance) * task_accel_part;
                end
                calculation_successful = true;
            catch ME
                warning('SNS: Error calculating solution for reduced system: %s', ME.message);
                % Keep current_solution_reduced as zeros and proceed.
                % Saturation will be based on comparing 0 to limits.
                % Alternatively, could break here: break;
            end
        else % num_remaining_joints == 0 (Should have been caught earlier, but as safety check)
             disp("SNS: No joints left to control task residual.");
             if norm(task_reduced) > tolerance
                 warning('SNS: Task residual remaining with no active joints: %s', mat2str(task_reduced'));
             end
             calculation_successful = true; % No calculation needed
             break; % Exit loop
        end
        if calculation_successful
             fprintf("Solution for active joints %s: \n", mat2str(active_joints'));
             disp(current_solution_reduced');
        end
        % --- Check Violations for Active Joints ---
        violations_max = current_solution_reduced - constraint_max_reduced;
        violations_min = current_solution_reduced - constraint_min_reduced;
        % Apply tolerance: Treat very small violations as non-violations
        violations_max(violations_max < tolerance) = 0;
        violations_min(violations_min > -tolerance) = 0;
        [max_violation_val, idx_rel_max] = max(violations_max);
        [min_violation_val, idx_rel_min] = min(violations_min); % Most negative value
        fprintf("Max violation: %.4g (rel idx %d), Min violation: %.4g (rel idx %d)\n", ...
                max_violation_val, idx_rel_max, min_violation_val, idx_rel_min);
        % --- Check if Termination Condition Met (No Violations) ---
        if max_violation_val <= tolerance && min_violation_val >= -tolerance
            disp("SNS: No significant violations remaining.")
            % Assign final results to the non-saturated joints
            for k = 1:num_remaining_joints
                original_idx = active_joints(k);
                if isnan(new_values(original_idx)) % Check if not already saturated
                   new_values(original_idx) = current_solution_reduced(k);
                   fprintf("Assigning final value %.4f to joint %d\n", current_solution_reduced(k), original_idx);
                else
                   % This case should ideally not happen if logic is correct,
                   % but good for debugging.
                   fprintf("Joint %d was already saturated to %.4f, not overwriting.\n", original_idx, new_values(original_idx));
                end
            end
            break; % Finished successfully
        end
        % --- Identify Most Violating Joint (relative index) ---
        idx_rel = -1; % Initialize
        violated_limit = NaN;
        % Compare absolute violation magnitudes
        if max_violation_val >= abs(min_violation_val)
            idx_rel = idx_rel_max;
            violated_limit = constraint_max_reduced(idx_rel);
            fprintf("--- Max violation is dominant (Joint rel_idx=%d).\n", idx_rel);
        else
            idx_rel = idx_rel_min;
            violated_limit = constraint_min_reduced(idx_rel);
            fprintf("--- Min violation is dominant (Joint rel_idx=%d).\n", idx_rel);
        end
        % --- Get Original Index of the Violating Joint ---
        idx_orig = active_joints(idx_rel);
        fprintf("--- Saturating Joint %d (Original Index) / %d (Relative Index). Desired: %.4f, Limit: %.4f\n", ...
                idx_orig, idx_rel, current_solution_reduced(idx_rel), violated_limit);
        % --- Saturate Joint in the Final Result Vector ---
        new_values(idx_orig) = violated_limit;
        % --- Update the Reduced Task ---
        saturated_value = new_values(idx_orig);
        selected_J_col = J_reduced(:, idx_rel);
        if type_task == 'v'
            task_reduced = task_reduced - selected_J_col * saturated_value;
        elseif type_task == 'a'
            % Need dJ and velocity corresponding to this joint (use reduced vectors)
             selected_dJ_col = dJ_reduced(:, idx_rel);
             selected_vel = velocity_initial_condition_reduced(idx_rel); % Velocity of the joint being saturated
             task_reduced = task_reduced - selected_J_col * saturated_value - selected_dJ_col * selected_vel;
             % Remove from acceleration specific reduced vectors
             dJ_reduced(:, idx_rel) = [];
             velocity_initial_condition_reduced(idx_rel) = [];
        end
        fprintf("--- Task residual after saturating joint %d: %s\n", mat2str(task_reduced'));
        % --- Remove the Saturated Joint from the Reduced Problem ---
        J_reduced(:, idx_rel) = [];
        constraint_max_reduced(idx_rel) = [];
        constraint_min_reduced(idx_rel) = [];
        active_joints(idx_rel) = []; % CRITICAL: Update the list of active original indices
        fprintf("--- Remaining active joints (original indices): %s\n", mat2str(active_joints'));
        fprintf("-----------------------------------------\n");
    end % End main saturation loop
    % --- Finalization ---
    % Check if loop completed all iterations without converging
    if i == n_joint && ~(max_violation_val <= tolerance && min_violation_val >= -tolerance) && num_remaining_joints > 0
        warning('SNS: Algorithm completed max iterations without converging (violations found in last step). Check task feasibility or tolerances.');
         % Optional: Assign last calculated solution to remaining NaN joints?
         % Assigning 0 is safer if convergence failed.
    end
    % Fill any remaining NaN values (joints never saturated and loop exited early/unsuccessfully)
    nan_indices = find(isnan(new_values));
    if ~isempty(nan_indices)
        warning('SNS: %d joints were not assigned a value (NaN). Setting to 0.', length(nan_indices));
        fprintf('Unassigned joints (original indices): %s\n', mat2str(nan_indices'));
        new_values(nan_indices) = 0; % Set unassigned joints to 0
    end
    new_values = reshape(new_values, n_joint, 1); % Ensure column output
    disp("---- SNS Finished ----")
    disp("Final constrained solution (new_values):");
    disp(new_values');
end % End function SNS_revised
%===========================================================