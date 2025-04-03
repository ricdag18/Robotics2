function q = gradient_method_robot(rd, q0, tol, max_iter, alpha)
    % =========================================================================
    % Metodo del gradiente per la cinematica inversa di un robot a due giunti
    % =========================================================================
    %
    % Questa funzione utilizza il metodo del gradiente per trovare le variabili 
    % di giunto (q1, q2) che permettono all'end-effector di raggiungere una 
    % posizione target (rd).
    %
    % PARAMETRI DI INPUT:
    % - rd: posizione target desiderata dell'end-effector [xd, yd]
    % - q0: stima iniziale delle variabili di giunto [q1, q2]
    % - tol: tolleranza per la convergenza (criterio di arresto)
    % - max_iter: numero massimo di iterazioni per evitare loop infiniti
    % - alpha: passo di aggiornamento (step size) per il metodo del gradiente
    %
    % OUTPUT:
    % - q: valori finali delle variabili di giunto [q1, q2] dopo la convergenza

    % Inizializzazione della variabile q con la stima iniziale q0
    q = q0;
    
    % ======================================================
    % Ciclo iterativo per la discesa del gradiente
    % ======================================================
    for iter = 1:max_iter
        % Calcola la posizione corrente dell'end-effector e il Jacobiano
        [rk, J_q] = robot_position_and_jacobian(q);
        
        % Calcola il passo di aggiornamento con il metodo del gradiente
        delta_q = alpha * J_q' * (rd - rk);
        
        % Aggiorna le variabili di giunto con il passo di aggiornamento
        q = q + delta_q;
        
        % Calcola l'errore come distanza tra la posizione attuale e quella target
        error = norm(rd - rk);
        
        % ================================================
        % Output di debug per monitorare la convergenza
        % ================================================
        fprintf('Iterazione %d:\n', iter);
        fprintf('  q1 = %f, q2 = %f\n', q(1), q(2));
        fprintf('  Errore = %f\n', error);
        fprintf('  Posizione corrente rk = [%f; %f]\n', rk(1), rk(2));
        
        % Controlla se l'errore è sotto la soglia di tolleranza
        if error < tol
            fprintf('Convergenza raggiunta in %d iterazioni.\n', iter);
            return;  % Termina la funzione se la convergenza è stata raggiunta
        end
    end

    % Se il metodo non ha converguto dopo max_iter iterazioni, mostra un avviso
    fprintf('Non è stata raggiunta la convergenza entro %d iterazioni.\n', max_iter);
end


function [r_q, J_q] = robot_position_and_jacobian(q)
    % =========================================================================
    % Funzione che calcola la posizione dell'end-effector e il Jacobiano
    % =========================================================================
    %
    % PARAMETRI DI INPUT:
    % - q: variabili di giunto [q1, q2]
    %
    % OUTPUT:
    % - r_q: posizione dell'end-effector [x, y]
    % - J_q: Jacobiano della cinematica diretta
    
    % Estrai gli angoli di giunto
    q1 = q(1);
    q2 = q(2);
    
    % =========================================================
    % Calcolo della cinematica diretta (posizione dell'end-effector)
    % =========================================================
    % La posizione dell'end-effector è calcolata in base ai giunti
    x = cos(q1)/5 - q2*sin(q1);  % Coordinata x dell'end-effector
    y = sin(q1)/5 + q2*cos(q1);  % Coordinata y dell'end-effector
    r_q = [x; y];  % Posizione attuale dell'end-effector
    
    % =========================================================
    % Calcolo del Jacobiano (J_q)
    % =========================================================
    % Il Jacobiano J(q) descrive come le variazioni di q influenzano (x, y)
    J11 = -sin(q1)/5 - q2*cos(q1);  % Derivata di x rispetto a q1
    J12 = -sin(q1);                 % Derivata di x rispetto a q2
    J21 = cos(q1)/5 - q2*sin(q1);   % Derivata di y rispetto a q1
    J22 = cos(q1);                  % Derivata di y rispetto a q2
    J_q = [J11, J12; 
           J21, J22];  % Matrice Jacobiana
end


% =========================================================================
% PARAMETRI PER IL METODO DEL GRADIENTE
% =========================================================================

rd = [-2; -3];     % Posizione target dell'end-effector [xd, yd]
q0 = [-1; 2];      % Stima iniziale degli angoli di giunto [q1, q2]
tol = 1e-3;        % Soglia di tolleranza per la convergenza
max_iter = 10;     % Numero massimo di iterazioni per il metodo del gradiente
alpha = 0.5;       % Step size per il metodo del gradiente

% =========================================================================
% ESECUZIONE DEL METODO DEL GRADIENTE
% =========================================================================
q = gradient_method_robot(rd, q0, tol, max_iter, alpha);

% =========================================================================
% STAMPA DEL RISULTATO FINALE
% =========================================================================
fprintf('Valori finali delle variabili di giunto:\n');
fprintf('q1 = %f\n', q(1));
fprintf('q2 = %f\n', q(2));
