% test_general3DOF_coriolis.m
clear; clc;

% === 1. Definizione simbolica ===
syms q1 q2 q3 dq1 dq2 dq3 real
syms a1 a2 a3 a4 a5 a6 real

q = [q1; q2; q3];         % coordinate generalizzate
dq = [dq1; dq2; dq3];     % velocità dei giunti

% === 2. Matrice di inerzia M(q) ===
% Struttura generale con dipendenza da q2 e q3
M = [ a1 + 2*a2*q2 + a3*q2^2 + 2*a4*q2*sin(q3) + a5*sin(q3)^2,  0,              0;
      0,                                                      a3,  a4*cos(q3);
      0,                                              a4*cos(q3),         a6   ];

disp("M(q) =");
disp(M);

% === 3. Calcolo dei termini di Coriolis e centrifughi ===
[c, C] = inertia_matrix_to_coriolis(M, q, dq);

% === 4. Risultati ===
disp('==============================');
disp('Coriolis/centrifugal vector c(q, dq) =');
disp(simplify(c));

disp('==============================');
disp('Christoffel matrices (symbolic):');
for i = 1:3
    disp(['C', num2str(i), ' =']);
    disp(simplify(C{i}));
end



% === 3. Calcolo delle derivate parziali ===
dM_dq1 = diff(M, q1);
dM_dq2 = diff(M, q2);
dM_dq3 = diff(M, q3);

dM_tot = dM_dq1 + dM_dq2 + dM_dq3;

% === 4. Visualizzazione ===
disp('Derivata parziale dM/dq1 ='); disp(simplify(dM_dq1));
disp('Derivata parziale dM/dq2 ='); disp(simplify(dM_dq2));
disp('Derivata parziale dM/dq3 ='); disp(simplify(dM_dq3));


disp('Derivata totale della matrice M'); disp(simplify(dM_tot));



%% 1. Definizione variabili simboliche
syms q1 q2 q3 dq1 dq2 dq3 ddq1 ddq2 ddq3 real
syms a1 a2 a3 a4 a5 a6 real

s3 = sin(q3);
c3 = cos(q3);

q   = [q1; q2; q3];
dq  = [dq1; dq2; dq3];
ddq = [ddq1; ddq2; ddq3];

a = [a1; a2; a3; a4; a5; a6];  % Parametri dinamici

%% 2. Matrice di inerzia M(q)
M = [ a1 + 2*a2*q2 + a3*q2^2 + 2*a4*q2*s3 + a5*s3^2, 0, 0;
      0,                                            a3, a4*c3;
      0,                                            a4*c3, a6 ];

%% 3. Vettore c(q, dq)
c1 = 2*(a2 + a3*q2 + a4*s3)*dq1*dq2 + 2*(a4*q2 + a5*s3)*c3*dq1*dq3;
c2 = -(a2 + a3*q2 + a4*s3)*dq1^2 - a4*s3*dq3^2;
c3 = -(a4*q2 + a5*s3)*c3*dq1^2;
c = [c1; c2; c3];

%% 4. Calcolo del termine dinamico: tau = M(q)*ddq + c(q,dq)
tau = simplify(M*ddq + c);

%% 5. Costruzione della matrice di regressione Y(q,dq,ddq)
% Si vuole: tau = Y(q,dq,ddq) * a
% Per ciascun elemento di tau, calcoliamo la derivata rispetto ai parametri dinamici

Y = sym(zeros(3, 6)); % 3 righe (tau), 6 colonne (parametri)

for i = 1:6
    Y(:,i) = simplify(diff(tau, a(i)));
end

%% 6. Visualizza il risultato
disp('======================');
disp('Regressore Y(q,dq,ddq):');
disp(Y);

disp('Conferma: Y * a = tau ?');
disp(simplify(Y * a - tau));  % Deve essere zero!
