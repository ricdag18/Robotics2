clc; clear;

% =========================================================================
% DEFINIZIONE DELLA MATRICE DI ROTAZIONE
% =========================================================================
% Definiamo una matrice di rotazione di esempio.
% Questa matrice può rappresentare una rotazione arbitraria nello spazio.

% Costruzione della matrice di rotazione R 
R = [sqrt(2)/2, sqrt(2)/2, 0;
     sqrt(2)/2,  sqrt(2)/2, 0;
      0,            0,            1];


% =========================================================================
% DEFINIZIONE DELLA SEQUENZA DI ROTAZIONE E SCELTA DELLA SOLUZIONE
% =========================================================================
sequence = ['X','Y','Z']; % Sequenza di rotazione Euleriana scelta
pos_or_neg_solution = "pos";  % Specificare 'pos' o 'neg' per la soluzione

% =========================================================================
% CHIAMATA ALLA FUNZIONE euler_rotation_inverse()
% =========================================================================
% Questa funzione scompone la matrice di rotazione R negli angoli di Eulero
% secondo la sequenza specificata.

[phi, theta, psi] = euler_rotation_inverse(sequence, R, pos_or_neg_solution);

% =========================================================================
% STAMPA DEI RISULTATI
% =========================================================================
disp("Angoli di Eulero trovati (in radianti):");
fprintf('phi (1° rotazione)   = %.4f rad\n', phi);
fprintf('theta (2° rotazione) = %.4f rad\n', theta);
fprintf('psi (3° rotazione)   = %.4f rad\n', psi);

% Conversione in gradi per una migliore interpretazione
phi_deg = rad2deg(phi);
theta_deg = rad2deg(theta);
psi_deg = rad2deg(psi);

disp("Angoli di Eulero trovati (in gradi):");
fprintf('phi (1° rotazione)   = %.2f°\n', phi_deg);
fprintf('theta (2° rotazione) = %.2f°\n', theta_deg);
fprintf('psi (3° rotazione)   = %.2f°\n', psi_deg);
