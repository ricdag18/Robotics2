clc; clear;

% =========================================================================
% DEFINIZIONE DELLA MATRICE SKEW-SYMMETRIC
% =========================================================================
% Una matrice skew-symmetric (antisimmetrica) ha la proprietà:
%     S^T = -S
% È costruita a partire da un vettore v = [vx; vy; vz] con la forma:
%  
%     S = [  0   -vz   vy
%            vz   0   -vx
%           -vy   vx    0 ]

S = [  0  -3   2;
       3   0  -1;
      -2   1   0];  % Matrice skew-symmetric di esempio

% =========================================================================
% VERIFICA SE LA MATRICE È SKEW-SYMMETRIC
% =========================================================================
if ~isequal(S', -S)
    error('Errore: La matrice non è skew-symmetric.');
end

% =========================================================================
% ESTRAZIONE DEL VETTORE ASSOCIATO
% =========================================================================
% Il vettore associato alla matrice skew-symmetric S è dato dagli elementi:
% vx = S(3,2), vy = S(1,3), vz = S(2,1)

v = [S(3,2); S(1,3); S(2,1)];  % Ricostruzione del vettore originale

% =========================================================================
% STAMPA DEI RISULTATI
% =========================================================================
disp('Matrice skew-symmetric di input:');
disp(S);

disp('Vettore associato:');
disp(v);
