function x_y_z = rdi(t,y)
% Rossler system.
a = 0.15;
b = 0.2;
c = 10; 
x_y_z = [-y(2)-y(1);
 y(1)+a*y(2);
 b+y(3)*(y(1)-c)];
% y(1) is x, y(2) is y, y(3) is z.