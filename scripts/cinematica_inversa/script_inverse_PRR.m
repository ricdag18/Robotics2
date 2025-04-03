% Inversa cinematica per un robot planare PRR
% Calcola i valori dei giunti q1 (prismatico), q2 e q3 (rotazionali)

% Parametri di input
L = 1.2;  % Lunghezza del primo link
x = 1.5;  % Posizione finale x
y = 0.8;  % Posizione finale y
alpha = pi/4;  % Angolo dell'end effector
pos_neg = "neg";  % Soluzione positiva o negativa

% Chiamata alla funzione di inversa cinematica
joint_values = inverse_kinematics_PRR_planar(L, x, y, alpha, pos_neg);

% Stampa dei risultati
disp("Valori dei giunti:");
disp(joint_values);
