% Inversa cinematica per un robot spaziale 3R
% Calcola gli angoli q1, q2, q3 dati i link e la posizione dell'end effector nello spazio

% Parametri di input
L = 1.2;  % Lunghezza del primo link
M = 0.9;  % Offset verticale del secondo link
N = 0.5;  % Lunghezza del terzo link
p = [1.0; 0.8; 0.6];  % Posizione finale [px, py, pz]
pos_neg = "pos";  % Soluzione positiva o negativa

% Chiamata alla funzione di inversa cinematica
angles = inverse_kinematics_3R_spatial(L, M, N, p, pos_neg);

% Stampa dei risultati
disp("Angoli q1, q2, q3:");
disp(angles);
