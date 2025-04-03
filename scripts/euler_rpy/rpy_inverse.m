function [alpha, beta, gamma] = rpy_inverse(sequence, R, pos_or_neg_solution)
    % =========================================================================
    % Calcola gli angoli di Roll-Pitch-Yaw (RPY) a partire da una matrice di
    % rotazione 3x3, seguendo la sequenza specificata.
    %
    % [alpha, beta, gamma] = rpy_rotation_any(sequence, R, pos_or_neg_solution)
    %
    % INPUT:
    % - sequence: stringa di 3 caratteri che definisce l'ordine delle rotazioni
    %             (es. "xyz", "zyx", "yzx", etc.).
    %             Gli assi non possono essere uguali consecutivi.
    % - R:        matrice di rotazione 3x3 (deve essere numerica, non simbolica).
    % - pos_or_neg_solution: Specifica quale soluzione usare in caso di ambiguità
    %                        ("pos" per la soluzione positiva, "neg" per la negativa).
    %
    % OUTPUT:
    % - alpha: angolo della prima rotazione (Roll)
    % - beta:  angolo della seconda rotazione (Pitch)
    % - gamma: angolo della terza rotazione (Yaw)
    %
    % METODO:
    % 1. Calcola la matrice trasposta R_trans = R'
    % 2. Risolve il problema inverso per gli angoli di Eulero con:
    %       R_trans = R_{s1}(phi) * R_{s2}(theta) * R_{s3}(psi)
    % 3. Restituisce gli angoli RPY come:
    %       alpha = -phi, beta = -theta, gamma = -psi
    %
    % =========================================================================

    % =========================================================================
    % VERIFICA DELLA SEQUENZA DI ROTAZIONE
    % =========================================================================
    if strlength(sequence) ~= 3
        error('Errore: La sequenza di rotazione deve avere esattamente 3 caratteri.');
    end
    
    if sequence(1) == sequence(2) || sequence(2) == sequence(3)
        error('Errore: Due assi consecutivi non possono essere uguali nella sequenza.');
    end

    % =========================================================================
    % VERIFICA DELLA MATRICE DI ROTAZIONE
    % =========================================================================
    if ~ismatrix(R) || any(size(R) ~= [3, 3])
        error('Errore: R deve essere una matrice di rotazione 3x3.');
    end

    if ~isnumeric(R)
        error('Errore: R deve essere una matrice numerica, non simbolica.');
    end

    % =========================================================================
    % CALCOLO DELLA TRASPOSTA DELLA MATRICE DI ROTAZIONE
    % =========================================================================
    R_trans = R';  % Poiché in RPY: R = Rz * Ry * Rx, prendiamo la trasposta

    % =========================================================================
    % CHIAMATA ALLA FUNZIONE euler_rotation_inverse()
    % =========================================================================
    % La funzione euler_rotation_inverse calcola gli angoli (phi, theta, psi)
    % per la rotazione inversa della matrice R_trans.
    % Utilizziamo questi angoli per derivare gli angoli RPY.
    
    [phi, theta, psi] = euler_rotation_inverse(sequence, R_trans, pos_or_neg_solution);
    
    % =========================================================================
    % CONVERSIONE DEGLI ANGOLI DI EULERO IN ANGOLI RPY
    % =========================================================================
    alpha = -phi;   % Roll (prima rotazione)
    beta  = -theta; % Pitch (seconda rotazione)
    gamma = -psi;   % Yaw (terza rotazione)

    % =========================================================================
    % STAMPA DEI RISULTATI (OPZIONALE, DISABILITABILE)
    % =========================================================================
    disp("Angoli di Roll-Pitch-Yaw trovati (in radianti):");
    fprintf('Roll (α)   = %.4f rad\n', alpha);
    fprintf('Pitch (β)  = %.4f rad\n', beta);
    fprintf('Yaw (γ)    = %.4f rad\n', gamma);

end
