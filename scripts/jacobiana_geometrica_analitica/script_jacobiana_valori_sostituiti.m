% =========================================================================
% CALCOLO DELLA MATRICE JACOBIANA DI UN VETTORE DI FUNZIONI
% =========================================================================
% Questo script calcola la matrice Jacobiana di un vettore di funzioni simboliche 
% rispetto a un insieme di variabili simboliche. Inoltre, calcola il determinante,
% il rango e il nucleo (null space) della Jacobiana.
%
% FUNZIONALITÀ:
% - Definisce il vettore simbolico delle funzioni f.
% - Definisce manualmente le variabili rispetto a cui derivare.
% - Calcola la matrice Jacobiana J.
% - Calcola determinante, rango e nucleo della Jacobiana.
% - Sostituisce valori specifici nelle variabili per ottenere J numerico.
% =========================================================================

% =========================================================================
% ASSICURATI DI AVERE IL SYMBOLIC MATH TOOLBOX INSTALLATO
% =========================================================================
clc; clear;  % Pulizia dell'ambiente di lavoro

% =========================================================================
% DEFINIZIONE DELLE VARIABILI SIMBOLICHE
% =========================================================================
% Qui puoi modificare o aggiungere altre variabili secondo necessità.
syms q1 q2 q3

% =========================================================================
% DEFINIZIONE DEL VETTORE DELLE FUNZIONI SIMBOLICHE
% =========================================================================
% Il vettore delle funzioni f è definito in termini delle variabili simboliche.
% Modifica f per rappresentare il tuo sistema.
f = [2*cos(q1) + cos(q1 + q2); 
     2*sin(q1) + sin(q1 + q2)];  % Equazioni di un braccio robotico planare 2R

% =========================================================================
% DEFINIZIONE DELLE VARIABILI RISPETTO A CUI DERIVARE
% =========================================================================
% Specifica manualmente le variabili rispetto alle quali calcolare le derivate parziali.
vars = [q1, q2];

% =========================================================================
% CALCOLO DELLA MATRICE JACOBIANA
% =========================================================================
% Ogni elemento J(i,j) rappresenta la derivata parziale di f(i) rispetto a vars(j).
J = jacobian(f, vars);

% =========================================================================
% VISUALIZZAZIONE DELLA MATRICE JACOBIANA
% =========================================================================
disp('La matrice Jacobiana è:');
disp(J);

% =========================================================================
% CALCOLO DI DET(J), RANGO E NULLO DELLA JACOBIANA
% =========================================================================
% Determinante della Jacobiana
J_det = det(J);
disp('Determinante della Jacobiana:');
disp(J_det);

% Rango della Jacobiana
J_rank = rank(J);
disp('Rango della Jacobiana:');
disp(J_rank);

% Nullo della Jacobiana (spazio nullo, vettori che soddisfano J*x = 0)
J_null = null(J);
disp('Spazio nullo della Jacobiana:');
disp(J_null);

% =========================================================================
% SOSTITUZIONE DI VALORI SPECIFICI NELLA MATRICE JACOBIANA
% =========================================================================
% Definisci i valori numerici da sostituire nelle variabili (es. q1 = 0, q2 = 0)
valori = [pi/2, pi];  % Cambia questi valori secondo necessità

% Sostituisci i valori nelle variabili della Jacobiana
J_sostituito = subs(J, vars, valori);

% Visualizza la matrice Jacobiana dopo la sostituzione
disp('Matrice Jacobiana dopo la sostituzione dei valori:');
disp(J_sostituito);

% =========================================================================
% CONVERSIONE DELLA MATRICE JACOBIANA IN FORMA NUMERICA
% =========================================================================
% Converte la matrice simbolica in una matrice numerica (double)
J_numeric = double(J_sostituito);

% Visualizza la matrice Jacobiana numerica
disp('Matrice Jacobiana numerica:');
disp(J_numeric);


syms a b deltaq qin_dot qfin_dot

A = [1,1;3,2;]
x =[a;b]
c = [deltaq-qin_dot;qfin_dot-qin_dot]

x = A\c