close all;
clear all;
ii = 0;
k1 = -3;
co = [-0.130519551797491,-1.74926024981833,-2.17102482938019];
f1 = co(1)*k1^2+co(2)*k1+co(3);
for c = 0.02:0.02:1
    for k2 = -3:0.01:-2.5
        ii = ii+1;
        tspan = [0,100];
        init = [0.1,0.1,0.1,0.1];
        % initial condition.

%         [t,XY0] = ode45(@(t,y)di2(t,y,0,k1,k2),tspan,init);
%         tunit0 = tspan(2)/length(t);
%         f1 = intrin_f(XY0(:,1),tunit0);
%         f2 = intrin_f(XY0(:,3),tunit0);
        f2 = co(1)*k2^2+co(2)*k2+co(3);
        PIFD(ii) = abs((f1-f2)/f1);
        SCS(ii) = c;

        [tt,XY] = ode45(@(t,y)di2(t,y,c,k1,k2),tspan,init);
        p1 = hilbert(XY(:,1)); 
        p2 = hilbert(XY(:,3));
        % Hilbert transform.

        %figure;
        %plot3(tt,YY(:,1),YY(:,2),'b-',tt,YY(:,3),YY(:,4),'k-.');
        theta1 = atan(imag(p1)./real(p1));
        theta2 = atan(imag(p2)./real(p2));
        R0 = exp(i*(theta1-theta2));
        R1 = sqrt(real(R0).^2+imag(R0).^2);
        L = length(R1);
        R(ii) = sum(R1)/L;
        % normalization.

    end    
end

PIFD(end);

figure;
scatter3(SCS,PIFD,R,'filled');
xlabel('C');
ylabel('PIFD');
zlabel('R');
figure(2);
scatter(SCS,R,'filled');
xlabel('C');
ylabel('R');
figure(3);
scatter(PIFD,R,'filled');
xlabel('PIFD');
ylabel('R');

% PIFDi = round(PIFD*1000);
% pm = max(PIFDi);
% SCSi = round(SCS*100);
% cm = max(SCSi);
% Rm = zeros(pm,cm);
% for mm = 1:length(PIFDi)
%     Rm(PIFDi(mm),SCSi(mm)) = R(mm);
% end
% figure;
% [X,Y] = meshgrid(0.01:1,0.0001:0.0255);
% % [c h] = contourf(Rm);
% h = pcolor(Rm);
% grid on;
% colorbar;
% set(h, 'LineStyle','none');
% xlabel('C');
% ylabel('PIFD');
