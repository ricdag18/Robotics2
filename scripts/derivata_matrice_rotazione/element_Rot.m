function R = element_Rot(axis, angle)
    % Generates the elementary rotation matrix for a given axis and angle
    switch axis
        case 'x'
            R = [1, 0, 0;
                 0, cos(angle), -sin(angle);
                 0, sin(angle), cos(angle)];
        case 'y'
            R = [cos(angle), 0, sin(angle);
                 0, 1, 0;
                -sin(angle), 0, cos(angle)];
        case 'z'
            R = [cos(angle), -sin(angle), 0;
                 sin(angle), cos(angle), 0;
                 0, 0, 1];
        otherwise
            error('Invalid axis. Use ''x'', ''y'', or ''z''.');
    end
end