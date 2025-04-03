clc; clear;
syms alfa bet gamm real  % Definizione delle variabili simboliche

% =========================================================================
% DEFINIZIONE DELLA SEQUENZA DI ROTAZIONE
% =========================================================================
sequence = ['X','Y','Z'];   % Sequenza scelta per le rotazioni

% =========================================================================
% CHIAMATA ALLA FUNZIONE get_euler_sym()
% =========================================================================
% Questa funzione restituisce la matrice di rotazione secondo la convenzione Euleriana.
fprintf('Calcolo della matrice di rotazione con angoli di Eulero per la sequenza "%s":\n', sequence);
R_euler = get_euler_sym(sequence);
disp('Matrice di rotazione Euleriana:');
disp(R_euler);

% =========================================================================
% CHIAMATA ALLA FUNZIONE get_rpy_sym()
% =========================================================================
% Questa funzione restituisce la matrice di rotazione secondo la convenzione RPY (Roll-Pitch-Yaw).
fprintf('\nCalcolo della matrice di rotazione con angoli RPY per la sequenza "%s":\n', sequence);
R_rpy = get_rpy_sym(sequence);
disp('Matrice di rotazione RPY:');
disp(R_rpy);
