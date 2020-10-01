function x_y_z = ldi(t,y)
% Lorenz system.
theta = 16;
R = 45.92;
b = 4; 
x_y_z = [theta*(y(2)-y(1));
 y(1)*(R-y(3))-y(2);
 y(1)*y(2)-b*y(3)];
% y(1) is x, y(2) is y, y(3) is z.