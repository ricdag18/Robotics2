% Inversa cinematica per un robot planare 3R
% Calcola gli angoli q1, q2, q3 dati i link e la posizione dell'end effector

% Parametri di input
l1 = 1.0;  % Lunghezza del primo link
l2 = 0.8;  % Lunghezza del secondo link
l3 = 0.5;  % Lunghezza del terzo link
px = 1.5;  % Posizione finale x
py = 0.7;  % Posizione finale y
phi = pi/4;  % Orientazione dell'end effector

% Chiamata alla funzione di inversa cinematica
solutions = inverse_kinematics_3R_planar(l1, l2, l3, px, py, phi);

% Stampa dei risultati
disp("Soluzioni per gli angoli:");
disp(solutions);
