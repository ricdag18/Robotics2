%% Dati del Robot
l1 = 0.5;  % Lunghezza link 1
l2 = 0.4;  % Lunghezza link 2
px = 0.4;  % Target x
py = -0.3; % Target y

%% Calcolo Cinematica Inversa
cos_q2 = (px^2 + py^2 - l1^2 - l2^2) / (2 * l1 * l2);
sin_q2_up = sqrt(1 - cos_q2^2);  % Elbow Up
sin_q2_down = -sqrt(1 - cos_q2^2); % Elbow Down

q2_up = atan2(sin_q2_up, cos_q2);
q2_down = atan2(sin_q2_down, cos_q2);

q1_up = atan2(py, px) - atan2(l2 * sin_q2_up, l1 + l2 * cos_q2);
q1_down = atan2(py, px) - atan2(l2 * sin_q2_down, l1 + l2 * cos_q2);

%%Risultato in Radianti
disp("Ris in radianti:");
disp([q1_up; q2_up]);
disp([q1_down; q2_down]);


%% Converti in Gradi
q0_up = [q1_up; q2_up] * 180 / pi;
q0_down = [q1_down; q2_down] * 180 / pi;

%% Mostra i Risultati
disp("Configurazione Elbow Up (gradi):");
disp(q0_up);
disp("Configurazione Elbow Down (gradi):");
disp(q0_down);
