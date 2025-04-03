function R = get_rpy_sym(seq)
    % get_rpy_sym Restituisce la matrice di rotazione simbolica RPY
    % per la sequenza specificata, considerando l'ordine inverso rispetto a Euler
    %
    % USO:
    % R = get_rpy_sym('xyz');  % Per rotazione RPY con ordine ZYX
    %
    % INPUT:
    % seq: stringa che specifica la sequenza di rotazioni (es. 'xyz', 'zyx')
    %      Nota: la sequenza specifica l'ordine degli angoli, la rotazione
    %      effettiva avverrà in ordine inverso
    %
    % OUTPUT:
    % R: matrice di rotazione simbolica 3x3 in funzione di (alfa, beta, gamma)

    % Definiamo gli angoli simbolici
    syms alf bet gamm real

    % Controllo sulla lunghezza della sequenza
    if strlength(seq) ~= 3
        error('La sequenza deve avere 3 caratteri, es. "xyz", "zyx"...');
    end

    % Controllo che non ci siano assi consecutivi identici
    for k = 1:2
        if seq(k) == seq(k+1)
            error('Sequenza non valida: contiene due assi consecutivi uguali: "%s"', seq);
        end
    end

    % Invertiamo l'ordine della sequenza per RPY
    seq_inv = seq(end:-1:1);

    % Costruiamo la matrice come prodotto nell'ordine inverso
    R1 = rotSym(seq_inv(1), gamm);
    R2 = rotSym(seq_inv(2), bet);
    R3 = rotSym(seq_inv(3), alf);

    % Moltiplichiamo nell'ordine corretto per RPY
    R = R1 * R2 * R3;
    
    % Semplifichiamo la matrice risultante
    R = simplify(R);
    
    % Mostriamo informazioni sulla rotazione
    fprintf('Rotazione RPY con sequenza %s\n', seq);
    fprintf('Ordine effettivo delle rotazioni: %s\n', seq_inv);
    fprintf('R = R_%s(gamma) * R_%s(beta) * R_%s(alfa)\n\n', ...
            seq_inv(1), seq_inv(2), seq_inv(3));
            
    % Mostriamo la matrice risultante
    fprintf('Matrice di rotazione risultante:\n');
    disp(R);
end

function R = rotSym(axis, angle)
    % Funzione di supporto per creare le matrici di rotazione elementari
    switch lower(axis)
        case 'x'
            R = [1, 0, 0; 
                 0, cos(angle), -sin(angle); 
                 0, sin(angle), cos(angle)];
        case 'y'
            R = [cos(angle), 0, sin(angle); 
                 0, 1, 0; 
                 -sin(angle), 0, cos(angle)];
        case 'z'
            R = [cos(angle), -sin(angle), 0; 
                 sin(angle), cos(angle), 0; 
                 0, 0, 1];
        otherwise
            error('Asse non valido. Deve essere x, y o z.');
    end
end