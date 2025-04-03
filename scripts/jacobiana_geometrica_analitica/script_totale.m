clc; clear;
syms q1 q2 q3 q4 a1 a2 a3 a4 d1 d2 d3 d4

% =========================================================================
% CALCOLO DELLE MATRICI DI TRASFORMAZIONE USANDO LA PARAMETRIZZAZIONE DH
% =========================================================================
% Questo codice utilizza la parametrizzazione Denavit-Hartenberg (DH) per 
% calcolare la cinematica diretta di un manipolatore a 4 giunti.
% - Si definisce la tabella DH con i parametri dei giunti.
% - Si costruiscono le matrici di trasformazione omogenea per ogni giunto.
% - Si calcola la matrice di trasformazione totale dall'origine all'end-effector.

% =========================================================================
% Definizione della matrice simbolica DH
% =========================================================================
DH = DHMatrix();  % Matrice di trasformazione simbolica secondo il modello DH

% =========================================================================
% Definizione della tabella DH per il robot
% =========================================================================
% Ogni riga rappresenta i parametri [alpha, a, d, theta] per ciascun giunto.
DH_table = [pi/2,  0,  d1,  q1;
            0,  a2,  0,  q2;
           0,  a3,  0,  q3;];

% Numero di giunti del robot
n_joints = size(DH_table, 1);

% =========================================================================
% Sostituzione dei parametri DH nella matrice di trasformazione
% =========================================================================
% Per ogni giunto, si costruisce la matrice di trasformazione omogenea A{i}
A = cell(1, n_joints);
for i = 1:n_joints
    A{i} = subs(DH, {'alfa', 'a', 'd', 'theta'}, DH_table(i, :));
end

% =========================================================================
% Visualizzazione delle matrici di trasformazione per ogni giunto
% =========================================================================
disp('Matrice DH per ogni giunto:');
for i = 1:n_joints
    fprintf('Giunto %d:\n', i);
    disp(A{i});
end

% =========================================================================
% Calcolo della matrice di trasformazione totale (dalla base all'end-effector)
% =========================================================================
T = eye(4); % Inizializza la matrice totale come identità
for i = 1:n_joints
    T = T * A{i};  % Moltiplica ogni trasformazione consecutiva
end

disp('Matrice di trasformazione totale (Base all''end-effector):');
disp(vpa(T, 3)); % Visualizza la matrice con precisione di 3 cifre decimali

% =========================================================================
% Calcolo delle matrici Jacobiane
% =========================================================================
% Si definiscono le variabili dei giunti
variables = [q1, q2, q3];

% Jacobiano lineare: descrive la velocità dell'end-effector rispetto ai giunti
JL = DH_to_JL(DH_table, variables);

% =========================================================================
% ATTENZIONE: Chiamata alla funzione DH_to_JA()
% =========================================================================
% Il Jacobiano angolare (JA) deve essere calcolato specificando l'indice
% dei giunti PRISMATICI. 
% - Il secondo argomento della funzione [2] indica che il **terzo giunto** 
%   è di tipo prismatico.
% - Se ci sono più giunti prismatici, è necessario fornire un vettore con 
%   tutti gli indici, es. [2, 4] se i giunti 3 e 5 sono prismatici.
JA = DH_to_JA(DH_table, []); 
% =========================================================================
% Costruzione della matrice Jacobiana estesa (JLA)
% =========================================================================
JLA = [JL; JA];

% =========================================================================
% Stampa dei risultati finali
% =========================================================================
disp('Matrice Jacobiana combinata (JLA):');
disp(JLA);

disp('Dimensioni di JLA:');
disp(size(JLA));  % Mostra la dimensione della matrice Jacobiana



minor_size = 3;

% Chiamata della funzione
determinants = calculate_minor_determinants(JLA, minor_size);
simplify(determinants)
