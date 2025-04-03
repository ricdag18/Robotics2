% Inversa cinematica per un robot planare RRP
% Calcola i valori dei giunti q1 (rotazionale), q2 (rotazionale) e q3 (prismatico)

% Parametri di input
L1 = 1.5;  % Lunghezza del primo link
x = 1.8;  % Posizione finale x
y = 0.9;  % Posizione finale y
phi = pi/3;  % Angolo dell'end effector (somma di q1 e q2)
pos_neg = "pos";  % Soluzione positiva o negativa

% Chiamata alla funzione di inversa cinematica
[q1, q2, q3] = inverse_kinematics_RRP_planar(L1, x, y, phi, pos_neg);

% Stampa dei risultati
disp("Valori dei giunti:");
disp(["q1:", q1, "q2:", q2, "q3:", q3]);
