clc; clear;

syms q1 q2 real

p_x = 1; 
p_y = 1.5; 
L1 = 1; 
L2 = 1; 
L3 = 1; 
phi = 1.5708; %cambia

p_wx = p_x - L3*cos(phi);
p_wy = p_y - L3*sin(phi);

cos_q2 = (p_wx^2 + p_wy^2 - L1^2 - L2^2) / (2*L1*L2);
sin_q2_plus = sqrt(1 - cos_q2^2);
sin_q2_neg = -sqrt(1 - cos_q2^2);

q2_plus = atan2(sin_q2_plus,cos_q2);
q2_neg = atan2(sin_q2_neg,cos_q2);

sin_q1_plus = (p_wy*(L1 + L2*cos_q2) - L2*sin_q2_plus*p_wx) / (p_wx^2 + p_wy^2);
sin_q1_neg = (p_wy*(L1 + L2*cos_q2) - L2*sin_q2_neg*p_wx) / (p_wx^2 + p_wy^2);

cos_q1_plus = (p_wx*(L1 + L2*cos_q2) + L2*sin_q2_plus*p_wy) / (p_wx^2 + p_wy^2);
cos_q1_neg = (p_wx*(L1 + L2*cos_q2) + L2*sin_q2_neg*p_wy) / (p_wx^2 + p_wy^2);

q1_plus = atan2(sin_q1_plus,cos_q1_plus);
q1_neg = atan2(sin_q1_neg,cos_q1_neg);

q3_plus = phi - q1_plus - q2_plus;
q3_neg = phi - q1_neg - q2_neg;

disp("First solution elbow down:");
q_first = [q1_plus; q2_plus; q3_plus];
disp(q_first);

disp("Second solution elbow up:");
q_second = [q1_neg; q2_neg; q3_neg];
disp(q_second);

% Visualization
figure;
subplot(1,2,1);
hold on;
title('Robot Configuration - Elbow Down');
xlabel('X');
ylabel('Y');
axis equal;
grid on;

% Position calculations for elbow down configuration
joint1_x = L1 * cos(q1_plus);
joint1_y = L1 * sin(q1_plus);
joint2_x = joint1_x + L2 * cos(q1_plus + q2_plus);
joint2_y = joint1_y + L2 * sin(q1_plus + q2_plus);
joint3_x = joint2_x + L3 * cos(q1_plus + q2_plus + q3_plus);
joint3_y = joint2_y + L3 * sin(q1_plus + q2_plus + q3_plus);

% Draw the robot
plot([0, joint1_x], [0, joint1_y], '-o');
plot([joint1_x, joint2_x], [joint1_y, joint2_y], '-o');
plot([joint2_x, joint3_x], [joint2_y, joint3_y], '-o');

subplot(1,2,2);
hold on;
title('Robot Configuration - Elbow Up');
xlabel('X');
ylabel('Y');
axis equal;
grid on;

% Position calculations for elbow up configuration
joint1_x = L1 * cos(q1_neg);
joint1_y = L1 * sin(q1_neg);
joint2_x = joint1_x + L2 * cos(q1_neg + q2_neg);
joint2_y = joint1_y + L2 * sin(q1_neg + q2_neg);
joint3_x = joint2_x + L3 * cos(q1_neg + q2_neg + q3_neg);
joint3_y = joint2_y + L3 * sin(q1_neg + q2_neg + q3_neg);

% Draw the robot
plot([0, joint1_x], [0, joint1_y], '-o');
plot([joint1_x, joint2_x], [joint1_y, joint2_y], '-o');
plot([joint2_x, joint3_x], [joint2_y, joint3_y], '-o');

