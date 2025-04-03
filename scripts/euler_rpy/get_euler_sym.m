function R = get_euler_sym(seq)
    % get_euler_sym  Restituisce la matrice di rotazione simbolica 
    % corrispondente alla sequenza 'seq', ad es. 'zyx', 'xyx', ecc.
    %
    % USO:
    %   R = get_euler_sym('zyx');
    %
    % OUTPUT:
    %   R: matrice di rotazione simbolica 3x3 in funzione di (phi, theta, psi)

    % Definiamo gli angoli simbolici
    syms alfa bet gamm real
    
    % Controllo rapido: la sequenza deve essere di lunghezza 3
    if strlength(seq) ~= 3
        error('La sequenza deve avere 3 caratteri, es. "xyz", "zyx", "xyx"...');
    end
    
    % Controllo che non abbia assi consecutivi identici (es. 'xx' 'yy' 'zz')
    for k = 1:2
        if seq(k) == seq(k+1)
            error('Sequenza non valida: contiene due assi consecutivi uguali: "%s"', seq);
        end
    end
    
    % Costruisco la matrice come prodotto
    R1 = rotSym(seq(1), alfa);
    R2 = rotSym(seq(2), bet);
    R3 = rotSym(seq(3), gamm);
    
    R = R1 * R2 * R3;
end

function R = rotSym(axis, angle)
    switch lower(axis)
        case 'x'
            R = [1, 0, 0; 0, cos(angle), -sin(angle); 0, sin(angle), cos(angle)];
        case 'y'
            R = [cos(angle), 0, sin(angle); 0, 1, 0; -sin(angle), 0, cos(angle)];
        case 'z'
            R = [cos(angle), -sin(angle), 0; sin(angle), cos(angle), 0; 0, 0, 1];
        otherwise
            error('Asse non valido. Deve essere x, y o z.');
    end
end


