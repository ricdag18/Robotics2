clc; clear;
syms theta_x theta_y theta_z real  % Definizione delle variabili simboliche

% =========================================================================
% DEFINIZIONE DELLA MATRICE DI ROTAZIONE
% =========================================================================
% Definiamo gli angoli di rotazione per Roll (α), Pitch (β) e Yaw (γ).
alpha_val = pi/6;  % Roll: 30 gradi
beta_val  = pi/4;  % Pitch: 45 gradi
gamma_val = pi/3;  % Yaw: 60 gradi

% Costruzione delle matrici di rotazione elementari
R = [0.5, -0.7071, 0.500;
      0.7071, 0, -0.7071;
      0.5,  0.7071,  0.5];


  % Matrice di rotazione complessiva

% =========================================================================
% DEFINIZIONE DELLA SEQUENZA DI ROTAZIONE E SCELTA DELLA SOLUZIONE
% =========================================================================
sequence =  ['Y','X','Z'];   % Sequenza di rotazione scelta (RPY standard)
pos_or_neg_solution = "pos";  % Specificare 'pos' o 'neg' per la soluzione

% =========================================================================
% CHIAMATA ALLA FUNZIONE rpy_rotation_any()
% =========================================================================
% Questa funzione calcola gli angoli di Roll-Pitch-Yaw a partire dalla matrice R.

[alpha, beta, gamma] = rpy_inverse(sequence, R, pos_or_neg_solution);

% =========================================================================
% STAMPA DEI RISULTATI
% =========================================================================
disp("Angoli di Roll-Pitch-Yaw trovati (in radianti):");
fprintf('Roll (α)   = %.4f rad\n', alpha);
fprintf('Pitch (β)  = %.4f rad\n', beta);
fprintf('Yaw (γ)    = %.4f rad\n', gamma);

% =========================================================================
% CONVERSIONE IN GRADI PER MAGGIORE CHIAREZZA
% =========================================================================
alpha_deg = rad2deg(alpha);
beta_deg = rad2deg(beta);
gamma_deg = rad2deg(gamma);

disp("Angoli di Roll-Pitch-Yaw trovati (in gradi):");
fprintf('Roll (α)   = %.2f°\n', alpha_deg);
fprintf('Pitch (β)  = %.2f°\n', beta_deg);
fprintf('Yaw (γ)    = %.2f°\n', gamma_deg);
