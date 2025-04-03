% ==================================================
% ESEMPIO DI UTILIZZO DELLA FUNZIONE initial_guess_newton.m
% ==================================================

clc; clear;  % Pulizia dell'ambiente di lavoro

% --- Parametri del robot ---
l1 = 0.5;   % Lunghezza del primo link
l2 = 0.4;   % Lunghezza del secondo link
px = 0.4;   % Coordinata X dell'end effector
py = -0.3;  % Coordinata Y dell'end effector

% --- Calcolo della cinematica inversa ---
% Formula diretta dalla funzione initial_guess_newton.m
cos_q2 = (px^2 + py^2 - l1^2 - l2^2) / (2 * l1 * l2);

% Controllo validità dei risultati (verifica se cos_q2 è nel range [-1, 1])
if abs(cos_q2) > 1
    disp("Errore: la posizione non è raggiungibile.");
else
    % Due possibili valori di sin_q2 per la soluzione Elbow Up e Elbow Down
    sin_q2_up = sqrt(1 - cos_q2^2);   % Gomito su
    sin_q2_down = -sqrt(1 - cos_q2^2); % Gomito giù

    % Calcolo delle due possibili soluzioni per q2
    q2_up = atan2(sin_q2_up, cos_q2);
    q2_down = atan2(sin_q2_down, cos_q2);

    % Calcolo di q1 corrispondente a ciascuna soluzione
    q1_up = atan2(py, px) - atan2(l2 * sin_q2_up, l1 + l2 * cos_q2);
    q1_down = atan2(py, px) - atan2(l2 * sin_q2_down, l1 + l2 * cos_q2);

    % Visualizzazione dei risultati in radianti
    disp("Risultati in radianti:");
    disp("Configurazione Elbow Up:");
    disp([q1_up; q2_up]);
    disp("Configurazione Elbow Down:");
    disp([q1_down; q2_down]);

    % Conversione in gradi per una migliore interpretazione
    q0_up = [q1_up; q2_up] * 180 / pi;
    q0_down = [q1_down; q2_down] * 180 / pi;

    % Visualizzazione dei risultati in gradi
    disp("Configurazione Elbow Up (gradi):");
    disp(q0_up);
    disp("Configurazione Elbow Down (gradi):");
    disp(q0_down);
end
