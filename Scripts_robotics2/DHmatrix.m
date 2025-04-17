function matrix = DHmatrix(dh_row)
    alpha = dh_row(1);
    a     = dh_row(2);
    d     = dh_row(3);
    theta = dh_row(4);

    matrix = [cos(theta), -cos(alpha)*sin(theta),  sin(alpha)*sin(theta), a*cos(theta);
              sin(theta),  cos(alpha)*cos(theta), -sin(alpha)*cos(theta), a*sin(theta);
              0,           sin(alpha),             cos(alpha),            d;
              0,           0,                      0,                     1];
end
