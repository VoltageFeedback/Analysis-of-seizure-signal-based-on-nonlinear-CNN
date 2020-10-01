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

    %plot3(t,YY(:,1),YY(:,2));
    [V,In] = findpeaks(XY(:,1));
    % returns a vector with the local maxima (peaks) 
    %of the input signal vector, data, and the indices at which the peaks occur.
    
    l = length(In);
    sum = 0;
    for i = 1:l-1
        sum = sum+In(i+1)-In(i);
    end
    d2(ii) = sum/(l-1);
    % to average all differences.
    T = (d2(ii))*tspan(2)/length(t);
    % the interval between two peaks is period.
    f(ii) = 1/T;
    ii = ii+1;
end

z = -5:0.01:0;
figure;
plot(z,f);
hold on
scatter(z,f);
xlabel('Stimulus k');
ylabel('Intrinsic frequency');

[f1,ind1] = min(f);
% f1 = 0.0774, ind1 = 60;
k1 = -3;
k2 = -2.5;
[i1,j1] = find(z==k1);
[i2,j2] = find(z==k2);

zn = z(j1:j2);
fn = f(j1:j2);
coe = polyfit(zn,fn,2);
ffunc = coe(1)*zn.^2+coe(2)*zn+coe(3);

figure(2);
plot(zn,ffunc);
hold on
xlabel('Stimulus k');
ylabel('Intrinsic frequency');
% [f2,ind3] = max(ffunc);
% k2_u = zn(ind3);
% % the upper bound of k2 should be -0.88.
% scatter(zn(1,1),ffunc(1,1),'filled');
% scatter(zn(1,ind3),ffunc(1,ind3),'filled');
% zn(34);
