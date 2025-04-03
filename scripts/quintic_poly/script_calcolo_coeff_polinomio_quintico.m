clc; clear;

% =========================================================================
% DEFINIZIONE DEI PARAMETRI DELLA TRAIETTORIA
% =========================================================================
% Questo script calcola la traiettoria di un giunto utilizzando un polinomio
% quintico normalizzato. Il movimento è definito tra due punti con vincoli 
% su posizione, velocità e accelerazione.

qin = -pi/4;    % Posizione iniziale [rad]
qfin = 0;       % Posizione finale [rad]
vin = 2.8289;   % Velocità iniziale [rad/s]
vfin = 0;       % Velocità finale [rad/s]
ain = 0;        % Accelerazione iniziale [rad/s^2]
afin = 0;       % Accelerazione finale [rad/s^2]
T = 2;          % Tempo totale del movimento [s]
print_info = true;  % Visualizza informazioni dettagliate durante il calcolo

% =========================================================================
% CHIAMATA ALLA FUNZIONE quintic_poly_double_norm_compute_coeff()
% =========================================================================
% Questa funzione calcola i coefficienti del polinomio quintico normalizzato
% che descrive la traiettoria del giunto.

[q_tau, coefficienti] = quintic_poly_double_norm_compute_coeff(qin, qfin, vin, vfin, ain, afin, T, print_info);

% =========================================================================
% DEFINIZIONE DEL VETTORE TEMPORALE
% =========================================================================
% Creiamo un vettore di tempi normalizzati τ, che va da 0 a 1.
tau = linspace(0, 1, 100);  % Tempo normalizzato
t = tau * T;  % Tempo reale in secondi (sostituisce tau con t*T)

% =========================================================================
% CALCOLO DI POSIZIONE, VELOCITÀ E ACCELERAZIONE
% =========================================================================
% La posizione q(t) viene calcolata sostituendo i coefficienti del polinomio
% quintico ottenuti dalla funzione.

q = coefficienti(1)*tau.^5 + coefficienti(2)*tau.^4 + coefficienti(3)*tau.^3 + ...
    coefficienti(4)*tau.^2 + coefficienti(5)*tau + coefficienti(6);

% Calcolo della velocità come derivata prima del polinomio
q_dot = (5 * coefficienti(1) * tau.^4 + 4 * coefficienti(2) * tau.^3 + ...
         3 * coefficienti(3) * tau.^2 + 2 * coefficienti(4) * tau + coefficienti(5)) / T;

% Calcolo dell'accelerazione come derivata seconda del polinomio
q_ddot = (20 * coefficienti(1) * tau.^3 + 12 * coefficienti(2) * tau.^2 + ...
          6 * coefficienti(3) * tau + 2 * coefficienti(4)) / T^2;

% =========================================================================
% PLOT DELLA TRAIETTORIA: POSIZIONE, VELOCITÀ E ACCELERAZIONE
% =========================================================================

figure;

% POSIZIONE
subplot(3,1,1);
plot(t, q, 'b', 'LineWidth', 2);
xlabel('Tempo (s)');
ylabel('Posizione q(t) [rad]');
title('Traiettoria Quintica del Giunto');
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
