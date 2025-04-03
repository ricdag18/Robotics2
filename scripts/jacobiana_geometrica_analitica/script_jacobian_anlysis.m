clc; clear;
syms q1 q2 q3 real  % Definizione delle variabili simboliche

% =========================================================================
% DEFINIZIONE DI UNA MATRICE JACOBIANA SIMBOLICA
% =========================================================================
% Questa è una matrice Jacobiana simbolica di un sistema robotico 3R planare.
% Può essere modificata per adattarsi a sistemi diversi.

J = [ -2*sin(q1) - sin(q1 + q2),  -sin(q1 + q2),  0;
       2*cos(q1) + cos(q1 + q2),   cos(q1 + q2),  0;
       0, 0, 1];

% =========================================================================
% DEFINIZIONE DELLE VARIABILI DI DERIVAZIONE
% =========================================================================
% Specifica le variabili simboliche rispetto alle quali è stato derivato il Jacobiano.
% Non includere costanti o parametri fissi.

variables = [q1, q2, q3];

% =========================================================================
% CHIAMATA ALLA FUNZIONE jacobian_analysis()
% =========================================================================
% Questa funzione esegue un'analisi completa della matrice Jacobiana:
% - Determinante
% - Condizioni di singolarità
% - Rango
% - Spazio nullo (nullspace)
% - Range

jacobian_analysis(J, variables);

