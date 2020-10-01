function x_y = di(t,y,z)
alpha = 3;
a = 0.7;
b = 0.8;
w_2 = 1; 
x_y = [alpha*(y(2)+y(1)-(y(1)^3/3)+z);
 (-1/alpha)*(w_2*y(1)-a+b*y(2))];
%y(1) is x in proj, y(2) is y in proj.