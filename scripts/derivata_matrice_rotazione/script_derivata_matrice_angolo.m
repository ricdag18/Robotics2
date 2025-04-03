
clc; clear;

syms alpha beta gamma
axes = ['Y', 'Z', 'Y'];
angles=[alpha,beta,gamma];




T = T_phi_EULER(axes, angles);
disp(T)



% Sostituzione dei valori numerici
alpha_val = pi/4;  % Esempio: α = 45°
beta_val = pi/6;   % Esempio: β = 30°

T_numeric = subs(T, [alpha, beta], [alpha_val, beta_val]);

disp('Matrice T con valori sostituiti:')
disp(T_numeric)

% Se vuoi il risultato come numeri decimali invece di simboli:
T_numeric_double = double(T_numeric);
disp('Matrice T in formato numerico:')
disp(T_numeric_double)