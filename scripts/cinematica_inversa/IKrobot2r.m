clc; clear;

% Parametri del robot 2R
L1 = 2; % Lunghezza del primo segmento
L2 = 1; % Lunghezza del secondo segmento

% Posizione target dell'end-effector
x = 0; % Coordinata X del target
y = 1; % Coordinata Y del target

% Calcolo della distanza normalizzata D
D = (x^2 + y^2 - L1^2 - L2^2) / (2 * L1 * L2);

% Controllo della raggiungibilità del punto
if abs(D) > 1
    error('Il punto target è fuori dalla portata del robot.');
end

% Calcolo delle soluzioni per theta2
theta2_prima_soluzione = atan2(sqrt(1 - D^2), D);
theta2_seconda_soluzione = atan2(-sqrt(1 - D^2), D);

% Calcolo delle soluzioni per theta1
k1 = L1 + L2 * cos(theta2_prima_soluzione);
k2 = L2 * sin(theta2_prima_soluzione);
theta1_prima_soluzione = atan2(y, x) - atan2(k2, k1);

k1 = L1 + L2 * cos(theta2_seconda_soluzione);
k2 = L2 * sin(theta2_seconda_soluzione);
theta1_seconda_soluzione = atan2(y, x) - atan2(k2, k1);

% Mostra i valori delle due soluzioni
fprintf('Prima Soluzione:\n');
fprintf('q1 = %.4f rad (%.2f°)\n', theta1_prima_soluzione, rad2deg(theta1_prima_soluzione));
fprintf('q2 = %.4f rad (%.2f°)\n\n', theta2_prima_soluzione, rad2deg(theta2_prima_soluzione));

fprintf('Seconda Soluzione:\n');
fprintf('q1 = %.4f rad (%.2f°)\n', theta1_seconda_soluzione, rad2deg(theta1_seconda_soluzione));
fprintf('q2 = %.4f rad (%.2f°)\n', theta2_seconda_soluzione, rad2deg(theta2_seconda_soluzione));

% Grafica
figure;
hold on;
axis equal;
grid on;
title('Posizione del Robot 2R');
xlabel('X [m]');
ylabel('Y [m]');

% Calcolo delle posizioni dei giunti per il plot
% Prima soluzione
x1_prima = L1 * cos(theta1_prima_soluzione);
y1_prima = L1 * sin(theta1_prima_soluzione);
x2_prima = x1_prima + L2 * cos(theta1_prima_soluzione + theta2_prima_soluzione);
y2_prima = y1_prima + L2 * sin(theta1_prima_soluzione + theta2_prima_soluzione);

% Seconda soluzione
x1_seconda = L1 * cos(theta1_seconda_soluzione);
y1_seconda = L1 * sin(theta1_seconda_soluzione);
x2_seconda = x1_seconda + L2 * cos(theta1_seconda_soluzione + theta2_seconda_soluzione);
y2_seconda = y1_seconda + L2 * sin(theta1_seconda_soluzione + theta2_seconda_soluzione);

% Disegno del robot per entrambe le configurazioni
plot([0, x1_prima, x2_prima], [0, y1_prima, y2_prima], '-o', 'DisplayName', 'Prima Soluzione');
plot([0, x1_seconda, x2_seconda], [0, y1_seconda, y2_seconda], '-o', 'DisplayName', 'Seconda Soluzione');
legend show;
