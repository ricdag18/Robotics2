syms q1 q2 a1 q3 l2 qd1 qd2 qd3 l1 a3 dc1 dc2 dc3 l3 real

% Numero di giunti
num_joints = 3;

% Matrice DH: [alpha, a, d, theta]
DH = [ 0, l1,  0,   q1;
      pi/2, 0,  l2,  q2;
       0,    l3, 0,    q3 ];

% Derivate delle coordinate generalizzate
qdots = [qd1; qd2; qd3];

% Masse (simboliche, se vuoi usare valori: m = [1; 2; 3]; ecc.)
syms m1 m2 m3 real
m = [m1; m2; m3];

% Centri di massa (ogni colonna è un ^ir_ci)
rc = [  -l1+dc1,     0,           -l3 + dc3;
       0,  -l2+dc2,       0;
        0,     0,          0 ];

% Nessun giunto è prismatico
prismatic_indices = [];

% Matrici d'inerzia baricentriche (simboliche o numeriche)
syms Ixx1 Iyy1 Izz1 Ixx2 Iyy2 Izz2 Ixx3 Iyy3 Izz3 real
I1 = diag([Ixx1, Iyy1, Izz1]);
I2 = diag([Ixx2, Iyy2, Izz2]);
I3 = diag([Ixx3, Iyy3, Izz3]);

% Concatenazione delle matrici in un’unica 3x(3*num_joints)
I = [I1, I2, I3];

% Chiamata alla funzione
[w, v, vc, T] = moving_frames_algorithm(num_joints, DH, qdots, m, rc, prismatic_indices, I);



g = [0,0;0,-m2*dc2*cos(q2)]
norm(g)


