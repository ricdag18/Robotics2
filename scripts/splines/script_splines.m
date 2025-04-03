% test_splines.m
clc; clear; close all;

%% Dati di input
tvals = [1,2, 3,4];    % ad esempio, 3 nodi temporali
qvals = [45,90,-45,45];    % ad esempio, i corrispondenti valori delle posizioni
  % Valori di posizione ai nodi
v1 = 0;                     % Velocità iniziale
vn = 0;                     % Velocità finale
normalize = true;           % Normalizzazione (true per default)

%% Chiamata alla funzione splines
% Assicurati che la funzione splines sia salvata in 'splines.m'
coeffs = splines(tvals, qvals, v1, vn, normalize);

%% Visualizzazione dei coefficienti calcolati
disp('Coefficienti delle spline cubiche:');
disp(coeffs);

%% Plot delle spline cubiche (funzione)
figure;
hold on;
grid on;
title('Spline Cubiche');
xlabel('Tempo');
ylabel('Posizione');

% Dati originali
plot(tvals, qvals, 'o', 'MarkerSize', 8, 'LineWidth', 1.5, 'DisplayName', 'Dati Originali');

% Numero di spline (segmenti)
N = length(tvals) - 1;
for i = 1:N
    % Estrazione dei coefficienti per il segmento i-esimo:
    a0 = coeffs(i, 1);
    a1 = coeffs(i, 2);
    a2 = coeffs(i, 3);
    a3 = coeffs(i, 4);
    
    % Intervallo di tempo per la spline i-esima:
    t_start = tvals(i);
    t_end = tvals(i+1);
    t_spline = linspace(t_start, t_end, 100); % 100 punti per il grafico
    
    % Parametro locale (tau) e calcolo della spline:
    h = t_spline - t_start; 
    q_spline = a0 + a1 * h + a2 * h.^2 + a3 * h.^3;
    
    % Disegna la spline
    plot(t_spline, q_spline, 'LineWidth', 1.5, 'DisplayName', sprintf('Spline %d', i));
end
legend;
hold off;

%% Plot della prima derivata (velocità) delle spline
figure;
hold on;
grid on;
title('Prima derivata delle spline cubiche');
xlabel('Tempo');
ylabel('Derivata Prima');
for i = 1:N
    % Estrazione dei coefficienti per il segmento i-esimo:
    a0 = coeffs(i, 1);
    a1 = coeffs(i, 2);
    a2 = coeffs(i, 3);
    a3 = coeffs(i, 4);
    
    % Intervallo di tempo per la spline i-esima:
    t_start = tvals(i);
    t_end = tvals(i+1);
    t_spline = linspace(t_start, t_end, 100);
    
    % Calcolo della prima derivata:
    % S'(t) = a1 + 2*a2*(t - t_start) + 3*a3*(t - t_start)^2
    h = t_spline - t_start;
    dq_spline = a1 + 2*a2*h + 3*a3*h.^2;
    
    % Disegna la derivata prima
    plot(t_spline, dq_spline, 'LineWidth', 1.5, 'DisplayName', sprintf('Spline %d', i));
end
legend;
hold off;

%% Plot della seconda derivata (accelerazione) delle spline
figure;
hold on;
grid on;
title('Seconda derivata delle spline cubiche');
xlabel('Tempo');
ylabel('Derivata Seconda');
for i = 1:N
    % Estrazione dei coefficienti per il segmento i-esimo:
    a0 = coeffs(i, 1);
    a1 = coeffs(i, 2);
    a2 = coeffs(i, 3);
    a3 = coeffs(i, 4);
    
    % Intervallo di tempo per la spline i-esima:
    t_start = tvals(i);
    t_end = tvals(i+1);
    t_spline = linspace(t_start, t_end, 100);
    
    % Calcolo della seconda derivata:
    % S''(t) = 2*a2 + 6*a3*(t - t_start)
    h = t_spline - t_start;
    ddq_spline = 2*a2 + 6*a3*h;
    
    % Disegna la derivata seconda
    plot(t_spline, ddq_spline, 'LineWidth', 1.5, 'DisplayName', sprintf('Spline %d', i));
end
legend;
hold off;















