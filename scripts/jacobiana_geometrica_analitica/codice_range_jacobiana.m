clc; clear; close all;
syms a2 a3 s1 s2 c1 c2

% Definizione della matrice originale J
J = [
    -c2 * s1 * (a2 + a3), -c1 * s2 * (a2 + a3), -a3 * c1 * s2;
    -c1 * c2 * (a2 + a3), -s1 * s2 * (a2 + a3), -a3 * s1 * s2;
    0, c2 * (a2 + a3), a3 * c2
];

% Mostra la matrice originale
disp('Matrice J:');
disp(J);

% Calcola la matrice RREF simbolica
R = simplify(rref(J));

disp('Matrice in forma RREF:');
disp(R);

% Identifica correttamente le colonne pivot
pivot_cols = [];
[rows, cols] = size(R);

for i = 1:rows
    for j = 1:cols
        if R(i,j) ~= 0  % Il primo valore non nullo di ogni riga è un pivot
            if ~ismember(j, pivot_cols)  % Evita ripetizioni
                pivot_cols = [pivot_cols, j];
            end
            break; % Passa alla prossima riga dopo aver trovato il pivot
        end
    end
end

disp('Colonne pivot (indici):');
disp(pivot_cols);

% Estrai la base del range space (spazio colonna)
range_basis = J(:, pivot_cols);

disp('Base del range space:');
disp(range_basis);
