function x1_y1_x2_y2 = di2(t,y,c,k1,k2)
alpha = 3;
a = 0.7;
b = 0.8;
w_2 = 1; 
x1_y1_x2_y2 = [alpha*(y(2)+y(1)-(y(1)^3/3)+k1+c*y(3));
 (-1/alpha)*(w_2*y(1)-a+b*y(2));
 alpha*(y(4)+y(3)-(y(3)^3/3)+k2+c*y(1));
 (-1/alpha)*(w_2*y(3)-a+b*y(4))];
% y(1) is x1, y(2) is y1; y(3) is x2, y(4) is y2.