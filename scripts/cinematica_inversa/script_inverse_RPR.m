% Inversa cinematica per un robot planare RPR
% Calcola i valori dei giunti q1 (rotazionale), q2 (prismatico) e q3 (rotazionale)

% Parametri di input
l2 = 1.0;  % Lunghezza del secondo link
x = 1.3;  % Posizione finale x
y = 0.7;  % Posizione finale y
alpha = pi/6;  % Angolo dell'end effector
pos_neg = "pos";  % Soluzione positiva o negativa

% Chiamata alla funzione di inversa cinematica
joint_values = inverse_kinematics_RPR_planar(l2, x, y, alpha, pos_neg);

% Stampa dei risultati
disp("Valori dei giunti:");
disp(joint_values);
