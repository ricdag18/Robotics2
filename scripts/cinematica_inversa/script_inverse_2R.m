% Inversa cinematica per un robot planare 2R
% Calcola gli angoli q1 e q2 dati la lunghezza dei link e la posizione finale dell'end effector

% Parametri di input
l1 = 1.0;  % Lunghezza del primo link
l2 = 0.8;  % Lunghezza del secondo link
px = 1.2;  % Posizione finale x
py = 0.5;  % Posizione finale y
pos_neg = "pos";  % Specifica se usare la soluzione positiva o negativa

% Chiamata alla funzione di inversa cinematica
angles = inverse_kinematics_2R_planar(l1, l2, px, py, pos_neg);

% Stampa dei risultati
disp("Angoli q1 e q2:");
disp(angles);
