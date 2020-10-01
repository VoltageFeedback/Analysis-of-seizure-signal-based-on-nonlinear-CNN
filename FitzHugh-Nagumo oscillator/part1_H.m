clear all
close all
ii = 1;
for z = -5:0.01:0
    %z = -0.7;
    %it starts to oscillate between -0.5 and -0.6.
    tspan = [0,100];
    x0_y0 = [0.1,0.1];
    % initial condition
    [t,XY] = ode45(@(t,y)di(t,y,z),tspan,x0_y0);
    % [t,y] = ode45(odefun,tspan,y0), where tspan = [t0 tf], 
    % integrates the system of differential equations y'=f(t,y) 
    % from t0 to tf with initial conditions y0.

    tunit = tspan(2)/length(t);
    f1 = intrin_f(XY(:,1),tunit);
    f(ii) = f1;
    ii = ii+1;
end

z = -5:0.01:0;
figure;
plot(z,f);
hold on
scatter(z,f);
xlabel('Stimulus k');
ylabel('Intrinsic frequency');

% [f1,ind1] = min(f);
% % f1 = 0.0781, ind1 = 60;
% k1 = -2+ind1*0.01;
% % k1 should be fixed at -1.4.
% ind2 = (-0.5+2)/0.01;
% % ind2 = 150.
% 
% ff = f(150:175);
% [f4,ind4] = min(ff);
% 
% z(167);
% 
% zn = z(60:167);
% fn = f(60:167);
% coe = polyfit(zn,fn,2);
% ffunc = coe(1)*zn.^2+coe(2)*zn+coe(3);
% figure(2);
% plot(zn,ffunc);
% hold on
% xlabel('k');
% ylabel('f');
% [f2,ind3] = max(ffunc);
% k2_u = zn(ind3);
% % the upper bound of k2 should be -0.87.
% scatter(zn(1,1),ffunc(1,1),'filled');
% scatter(zn(1,ind3),ffunc(1,ind3),'filled');