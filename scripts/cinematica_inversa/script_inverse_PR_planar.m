% Inversa cinematica per un robot planare PR
% Calcola i valori dei giunti q1 (prismatico) e q2 (rotazionale)

% Parametri di input
l2 = 1.0;  % Lunghezza del secondo link
x = 1.5;  % Posizione finale x
y = 0.5;  % Posizione finale y
pos_neg = "pos";  % Soluzione positiva o negativa

% Chiamata alla funzione di inversa cinematica
joint_values = inverse_kinematics_PR_planar(l2, x, y, pos_neg);

% Stampa dei risultati
disp("Valori dei giunti:");
disp(joint_values);
