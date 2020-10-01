close all;
clear all;

ii = 0;
R = [];
k1 = -1.4;
f1 = if_fc(k1);
tic;
for c = 0:0.01:1
    ii = ii+1;
    SCS(ii) = c;
    iii = 0;
    for k2 = k1:0.01:-0.88
        iii = iii+1;
        tspan = [0,100];
        init = [0.1,0.1,0.1,0.1];
        % initial condition.

%         [t,XY0] = ode45(@(t,y)di2(t,y,0,k1,k2),tspan,init);
%         tunit0 = tspan(2)/length(t);
%         f1 = intrin_f(XY0(:,1),tunit0);
%         f2 = intrin_f(XY0(:,3),tunit0);
        f2 = if_fc(k2);
        PIFD(iii) = abs((f1-f2)/f1);
        

        [tt,XY] = ode45(@(t,y)di2(t,y,c,k1,k2),tspan,init);
        p1 = hilbert(XY(:,1)); 
        p2 = hilbert(XY(:,3));
        % Hilbert transform.

        %figure;
        %plot3(tt,YY(:,1),YY(:,2),'b-',tt,YY(:,3),YY(:,4),'k-.');
        theta1 = atan(imag(p1)./real(p1));
        theta2 = atan(imag(p2)./real(p2));
        R0 = exp(i*(theta1-theta2));
%         R1 = sqrt(real(R0).^2+imag(R0).^2);
        R1 = mean(R0);
        R(ii,iii) = norm(R1);
        % normalization.

    end    
end
toc;

% PIFD(end)

% atan(1)
% 45/360*2*pi

% figure;
% scatter3(SCS,PIFD,R,'filled');
% title('Two bidirectionally coupled FitzHugh-Nagumo oscillators');
% xlabel('Symmetric coupling strength');
% ylabel('Percentage intrinsic frequency difference');
% zlabel('Phase coherence index');

a = SCS; % m elements.
b = PIFD; % n elements.
c = R'; % a n*m matrix.
figure();

pcolor(a,b,c);
colormap jet;
shading interp;
colorbar;

title('Two bidirectionally coupled FitzHugh-Nagumo oscillators');
xlabel('Symmetric coupling strength');
ylabel('Percentage intrinsic frequency difference');
zlabel('Phase coherence index');

% figure(2);
% subplot(2,1,1);
% scatter(SCS,R,'filled');
% xlabel('Symmetric coupling strength');
% ylabel('Phase coherence index');
% subplot(2,1,2);
% scatter(PIFD,R,'filled');
% xlabel('Percentage intrinsic frequency difference');
% ylabel('Phase coherence index');