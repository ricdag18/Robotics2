clc; clear;
syms s a b qA1 qA2 qB1 qB2 qA_dot1 qA_dot2 qB_dot1 qB_dot2 deltaq1 deltaq2 tau real

% =========================================================================
% 1️⃣ DEFINIZIONE DEL SISTEMA PER IL CALCOLO DEI COEFFICIENTI SIMBOLICI
% =========================================================================
% Matrice dei coefficienti
A = [1, 1; 
     3, 2];

% Vettore dei termini noti (separati per ciascuna componente)
c1 = [deltaq1 - qA_dot1; 
      qB_dot1 - qA_dot1];

c2 = [deltaq2 - qA_dot2; 
      qB_dot2 - qA_dot2];

% Risoluzione del sistema simbolico per ottenere i coefficienti a e b
sol1 = A \ c1;  % Coefficienti per la prima componente
sol2 = A \ c2;  % Coefficienti per la seconda componente

a_sym1 = sol1(1);  % Coefficiente a per la prima componente
b_sym1 = sol1(2);  % Coefficiente b per la prima componente
a_sym2 = sol2(1);  % Coefficiente a per la seconda componente
b_sym2 = sol2(2);  % Coefficiente b per la seconda componente

% =========================================================================
% 2️⃣ DEFINIZIONE DEL POLINOMIO CUBICO GENERALE
% =========================================================================
q_s1_sym = qA1 + qA_dot1 * s + a_sym1 * s^2 + b_sym1 * s^3;
q_s2_sym = qA2 + qA_dot2 * s + a_sym2 * s^2 + b_sym2 * s^3;

% =========================================================================
% 3️⃣ SOSTITUZIONE DEI VALORI NUMERICI
% =========================================================================
% Valori numerici di esempio
qA_val = [pi/2; pi];  % Posizione iniziale (vettore 2D)
qB_val = [0; 0];      % Posizione finale (vettore 2D)
qA_dot_val = [-2.5; 2.5];  % Velocità iniziale
qB_dot_val = [-0.3; -0.1]; % Velocità finale
deltaq_val = qB_val - qA_val;  % Delta posizione

% Sostituzione dei valori numerici nei coefficienti
a_num1 = double(vpa(subs(a_sym1, [qA1, qB1, qA_dot1, qB_dot1, deltaq1], ...
                     [qA_val(1), qB_val(1), qA_dot_val(1), qB_dot_val(1), deltaq_val(1)]), 4));
b_num1 = double(vpa(subs(b_sym1, [qA1, qB1, qA_dot1, qB_dot1, deltaq1], ...
                     [qA_val(1), qB_val(1), qA_dot_val(1), qB_dot_val(1), deltaq_val(1)]), 4));

a_num2 = double(vpa(subs(a_sym2, [qA2, qB2, qA_dot2, qB_dot2, deltaq2], ...
                     [qA_val(2), qB_val(2), qA_dot_val(2), qB_dot_val(2), deltaq_val(2)]), 4));
b_num2 = double(vpa(subs(b_sym2, [qA2, qB2, qA_dot2, qB_dot2, deltaq2], ...
                     [qA_val(2), qB_val(2), qA_dot_val(2), qB_dot_val(2), deltaq_val(2)]), 4));

% =========================================================================
% 4️⃣ CALCOLO DEL POLINOMIO NUMERICO
% =========================================================================
% Correzione dell'ordine dei coefficienti
q_s1_num = qA_val(1) + qA_dot_val(1) * s + b_num1 * s^2 + a_num1 * s^3;
q_s2_num = qA_val(2) + qA_dot_val(2) * s + b_num2 * s^2 + a_num2 * s^3;

% =========================================================================
% STAMPA RISULTATI SU RIGA DI COMANDO
% =========================================================================
disp('Coefficienti numerici (approssimati a 4 cifre decimali):');
fprintf('a1 = %.4f, b1 = %.4f\n', a_num1, b_num1);
fprintf('a2 = %.4f, b2 = %.4f\n', a_num2, b_num2);

disp('Polinomio numerico per la prima componente q_1(s):');
disp(vpa(q_s1_num, 4));

disp('Polinomio numerico per la seconda componente q_2(s):');
disp(vpa(q_s2_num, 4));

% =========================================================================
% 5️⃣ PLOT DELLE COMPONENTI: POSIZIONE, VELOCITÀ E ACCELERAZIONE
% =========================================================================

% Intervallo temporale normalizzato s ∈ [0,1]
s_vals = linspace(0, 1, 100);
t_vals = s_vals * 2;  % Supponiamo T = 2 secondi

% Calcolo di posizione, velocità e accelerazione per la prima componente
q_s1_vals = double(subs(q_s1_num, s, s_vals));
q_s1_dot_vals = double(subs(diff(q_s1_num, s), s, s_vals)) / 2;  % d(q)/ds * (1/T)
q_s1_ddot_vals = double(subs(diff(q_s1_num, s, 2), s, s_vals)) / 4;  % d²(q)/ds² * (1/T²)

% Calcolo di posizione, velocità e accelerazione per la seconda componente
q_s2_vals = double(subs(q_s2_num, s, s_vals));
q_s2_dot_vals = double(subs(diff(q_s2_num, s), s, s_vals)) / 2;
q_s2_ddot_vals = double(subs(diff(q_s2_num, s, 2), s, s_vals)) / 4;

figure;

% Posizione
subplot(3,2,1);
plot(t_vals, q_s1_vals, 'b', 'LineWidth', 2);
xlabel('Tempo (s)');
ylabel('q_1(t) [rad]');
title('Posizione - Componente 1');
grid on;

subplot(3,2,2);
plot(t_vals, q_s2_vals, 'b', 'LineWidth', 2);
xlabel('Tempo (s)');
ylabel('q_2(t) [rad]');
title('Posizione - Componente 2');
grid on;

% Velocità
subplot(3,2,3);
plot(t_vals, q_s1_dot_vals, 'r', 'LineWidth', 2);
xlabel('Tempo (s)');
ylabel('q''_1(t) [rad/s]');
title('Velocità - Componente 1');
grid on;

subplot(3,2,4);
plot(t_vals, q_s2_dot_vals, 'r', 'LineWidth', 2);
xlabel('Tempo (s)');
ylabel('q''_2(t) [rad/s]');
title('Velocità - Componente 2');
grid on;

% Accelerazione
subplot(3,2,5);
plot(t_vals, q_s1_ddot_vals, 'g', 'LineWidth', 2);
xlabel('Tempo (s)');
ylabel('q''''_1(t) [rad/s²]');
title('Accelerazione - Componente 1');
grid on;

subplot(3,2,6);
plot(t_vals, q_s2_ddot_vals, 'g', 'LineWidth', 2);
xlabel('Tempo (s)');
ylabel('q''''_2(t) [rad/s²]');
title('Accelerazione - Componente 2');
grid on;



% =========================================================================
% 5️⃣ SOSTITUZIONE DI s CON UNA LEGGE TEMPORALE
% =========================================================================
s_tau = 3*tau^2 - 2*tau^3;  % Legge temporale s(τ)

q_s1_tau = subs(q_s1_num, s, s_tau);
q_s2_tau = subs(q_s2_num, s, s_tau);

disp('Polinomio q_1(τ) con sostituzione di s(τ):');
disp(vpa(q_s1_tau, 4));

disp('Polinomio q_2(τ) con sostituzione di s(τ):');
disp(vpa(q_s2_tau, 4));

% =========================================================================
% 6️⃣ PLOT DEI PATH ORIGINALI
% =========================================================================
s_vals = linspace(0, 1, 100);
t_vals = s_vals * 2;  % Supponiamo T = 2 secondi

q_s1_vals = double(subs(q_s1_num, s, s_vals));
q_s2_vals = double(subs(q_s2_num, s, s_vals));

figure;
subplot(1,2,1);
plot(q_s1_vals, q_s2_vals, 'k', 'LineWidth', 2);
xlabel('q_1');
ylabel('q_2');
title('Percorso del movimento');
grid on;
axis equal;

% =========================================================================
% 7️⃣ PLOT DELLA TRAIETTORIA CON LA LEGGE TEMPORALE
% =========================================================================
tau_vals = linspace(0, 1, 100);
t_tau_vals = tau_vals * 2;  % Supponiamo T = 2 secondi

q_s1_tau_vals = double(subs(q_s1_tau, tau, tau_vals));
q_s2_tau_vals = double(subs(q_s2_tau, tau, tau_vals));

subplot(1,2,2);
plot(t_tau_vals, q_s1_tau_vals, 'b', 'LineWidth', 2);
hold on;
plot(t_tau_vals, q_s2_tau_vals, 'r', 'LineWidth', 2);
xlabel('Tempo (s)');
ylabel('q(t) [rad]');
title('Traiettoria con s(τ)');
legend('q_1(t)', 'q_2(t)');
grid on;
hold off;