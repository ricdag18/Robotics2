function determinants = calculate_minor_determinants(input_matrix, minor_size)
    % Calcola i determinanti di tutti i minori quadrati di una matrice rettangolare simbolica.
    % Le espressioni dei determinanti vengono anche semplificate.
    %
    % Parametri:
    %   input_matrix - Matrice rettangolare simbolica di input
    %   minor_size   - Dimensione del minore quadrato da considerare
    %
    % Ritorna:
    %   determinants - Vettore simbolico contenente i determinanti di tutti i minori quadrati semplificati

    % Controllo della validità della matrice
    if isempty(input_matrix) || ~ismatrix(input_matrix)
        error('Devi inserire una matrice valida.');
    end
    
    % Dimensioni della matrice
    [rows, cols] = size(input_matrix);
    
    % Verifica della validità della dimensione del minore quadrato
    if minor_size > min(rows, cols)
        error('La dimensione del minore quadrato non può essere maggiore delle dimensioni della matrice.');
    end
    
    % Generazione di tutte le combinazioni di righe e colonne
    row_indices = nchoosek(1:rows, minor_size);
    col_indices = nchoosek(1:cols, minor_size);
    
    % Numero totale di minori quadrati
    num_minors = size(row_indices, 1) * size(col_indices, 1);
    determinants = sym(zeros(num_minors, 1)); % Vettore simbolico per i determinanti
    minor_count = 1; % Contatore dei minori
    
    % Calcolo dei determinanti dei minori quadrati
    for i = 1:size(row_indices, 1)
        for j = 1:size(col_indices, 1)
            % Estrai il minore quadrato
            minor_matrix = input_matrix(row_indices(i, :), col_indices(j, :));
            
            % Calcola il determinante simbolico e semplificalo
            determinants(minor_count) = simplify(det(minor_matrix));
            minor_count = minor_count + 1;
        end
    end
    
    % Stampa i risultati
    disp('Determinanti dei minori quadrati (semplificati):');
    disp(determinants);
end
