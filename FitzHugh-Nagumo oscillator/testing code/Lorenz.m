close all
clear all
tspan = [0,100];
init = [0.1,0.1,0.1];
% initial condition.

[t,XYZ] = ode45(@(t,y)ldi(t,y),tspan,init);


N = 5000;
tunit0 = tspan(2)/length(t);
fs = 1/tunit0;
XYZ1 = XYZ(1:N,1);
mp1 = meanperiod(XYZ1,fs);

d = lyarosenstein_0(XYZ1,1,11,mp1,fs,300);


