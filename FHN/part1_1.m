ii = 1;
for z = -1:0.01:-0.01
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

z = -1:0.01:-0.01;
plot(z,f);
