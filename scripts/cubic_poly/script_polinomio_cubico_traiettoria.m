    clc; clear;

% =========================================================================
% DEFINIZIONE DEI PARAMETRI DELLA TRAIETTORIA
% =========================================================================
% Questi parametri definiscono il movimento di un giunto usando un polinomio cubico.
% Il polinomio soddisfa i vincoli di posizione e velocità iniziale e finale.

qin = -0.4636;    % Posizione iniziale del giunto [rad]
qfin = 2.0344;       % Posizione finale del giunto [rad]
vin = 0;   % Velocità iniziale [rad/s]
vfin = 0;       % Velocità finale [rad/s]
T = 3.8485;          % Tempo totale del movimento [s]
print_info = true;  % Mostra dettagli sui coefficienti e il calcolo della traiettoria

% =========================================================================
% CHIAMATA ALLA FUNZIONE cubic_poly_double_norm_compute_coeff()
% =========================================================================
% Questa funzione calcola i coefficienti del polinomio cubico normalizzato
% per descrivere la traiettoria del giunto.

[q_tau, coefficienti] = cubic_poly_double_norm_compute_coeff(qin, qfin, vin, vfin, T, print_info);

% =========================================================================
% DEFINIZIONE DEL VETTORE TEMPORALE
% =========================================================================
% Creiamo un vettore di tempi normalizzati τ, che va da 0 a 1.
tau = linspace(0, 1, 100);  % Tempo normalizzato
t = tau * T;  % Tempo reale in secondi (t = tau * T)

% =========================================================================
% CALCOLO DI POSIZIONE, VELOCITÀ E ACCELERAZIONE
% =========================================================================
% Calcoliamo la posizione q(t) usando i coefficienti ottenuti

q = coefficienti(1) * tau.^3 + coefficienti(2) * tau.^2 + coefficienti(3) * tau + coefficienti(4);

% Calcolo della velocità come derivata prima del polinomio
q_dot = (3 * coefficienti(1) * tau.^2 + 2 * coefficienti(2) * tau + coefficienti(3)) / T;

% Calcolo dell'accelerazione come derivata seconda del polinomio
q_ddot = (6 * coefficienti(1) * tau + 2 * coefficienti(2)) / T^2;

% =========================================================================
% PLOT DELLA TRAIETTORIA: POSIZIONE, VELOCITÀ E ACCELERAZIONE
% =========================================================================

figure;

% POSIZIONE
subplot(3,1,1);
plot(t, q, 'b', 'LineWidth', 2);
xlabel('Tempo (s)');
ylabel('Posizione q(t) [rad]');
title('Traiettoria Cubica del Giunto');
yticks([-pi/2 -pi/4 0 pi/4 pi/2]);
yticklabels({'-π/2', '-π/4', '0', 'π/4', 'π/2'});
grid on;
legend('Posizione');

% VELOCITÀ
subplot(3,1,2);
plot(t, q_dot, 'r', 'LineWidth', 2);
xlabel('Tempo (s)');
ylabel('Velocità q''(t) [rad/s]');
title('Velocità del Giunto');
grid on;
legend('Velocità');

% ACCELERAZIONE
subplot(3,1,3);
plot(t, q_ddot, 'g', 'LineWidth', 2);
xlabel('Tempo (s)');
ylabel('Accelerazione q''''(t) [rad/s²]');
title('Accelerazione del Giunto');
grid on;
legend('Accelerazione');

% =========================================================================
% FINE DELLO SCRIPT
% =========================================================================
    