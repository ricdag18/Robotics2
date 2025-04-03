clc; clear;

% =========================================================================
% DEFINIZIONE DEL VETTORE DI INGRESSO
% =========================================================================
% La funzione skew_sym() prende in ingresso un vettore 3D e restituisce 
% la matrice associata alla sua versione antisimmetrica (skew-symmetric).
% Questo tipo di matrice è utile nelle trasformazioni in algebra lineare e 
% nella rappresentazione del prodotto vettoriale.

v = [1; 2; 3];  % Definiamo un vettore colonna di esempio

% =========================================================================
% CHIAMATA ALLA FUNZIONE skew_sym()
% =========================================================================
% La funzione restituisce la matrice skew-symmetric di v
S = skew_sym(v);

% =========================================================================
% STAMPA DEI RISULTATI
% =========================================================================
disp('Vettore di input:');
disp(v);

disp('Matrice skew-symmetric associata:');
disp(S);

% =========================================================================
% VERIFICA DELLA PROPRIETÀ ANTISIMMETRICA
% =========================================================================
% La matrice skew-symmetric ha la proprietà: S' = -S
S_transpose = S';       % Trasposta della matrice
is_antisymmetric = isequal(S_transpose, -S);  % Controlla se S' = -S

disp('La matrice è effettivamente antisimmetrica?');
disp(is_antisymmetric);
