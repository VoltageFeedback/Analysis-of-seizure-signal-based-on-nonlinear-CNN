close all
clear all
ii = 0;
k1 = -1.4;
f1 = if_fc(k1);
% for c = 0:0.0001:0.0100
% for k2 = -1.08:0.01:-0.88
%         3*21 loops
        c = 0.0088;
        k2 = -0.96;
        ii = ii+1;
        tspan = [0,1000];
        init = [0.1,0.1,-0.1,-0.1];
        % initial condition.

%         f1 = intrin_f(XY0(:,1),tunit0);
%         f2 = intrin_f(XY0(:,3),tunit0);
        % to get intrinsic frequency.
%         f2 = if_fc(k2);
%         PIFD(ii) = abs((f1-f2)/f1);
%         SCS(ii) = c;
% 
        [tt,XY] = ode45(@(t,y)di2(t,y,c,k1,k2),tspan,init);
        p1 = hilbert(XY(:,1)); 
        p2 = hilbert(XY(:,3));
%         % Hilbert transform.
        tunit = tspan(2)/length(tt);
        fs = 1/tunit;
        
%         figure;
%         plot(tt,XY(:,1),'b-');

%         figure;
%         subplot(2,1,1);
%         plot(tt,XY(:,1),'b-',tt,XY(:,3),'r-');
%         xlabel('time');
%         legend('x1','x2');
%         % x1 line is blue, x2 line is red.
%         subplot(2,1,2);            
%         plot(real(p1),imag(p1),'b-.',real(p2),imag(p2),'r-.');
%         xlabel('x(t)');
%         ylabel('y(t)');
%         legend('oscillator_1','oscillator_2');

        data = real(p1)';
        mp1 = meanperiod(data,fs);
        % to get the mean period.
        pp1 = autocorr(data,50);
%         pp1 = xcorr(data,'unbiased');
%         J1 = 0;
%         for i = 2:length(pp1)
%             if pp1(i) <= pp1(1)*(1-1/exp(1))
%                 J1 = i;
%                 break
%             end
%         end
%         % to get the time delay.
% 
%         m1 = 2;
%         if J1 ~= 0
%             for em = 2:7
%                 coe1 = G_P0(data,J1,em,150);
%                 if abs(coe1-1)<=0.05
%                     m1 = em;
%                     break
%                 end
%             end
%         end
%         dc(ii) = m1;
%         % to get the correlation dimension.
% 
%         lle(ii) = lyarosenstein_0(data,m1,J1,mp1,fs,150);
%         % to get the largest lyapunov exponent.
% end
% end

% dlmwrite('dc.txt', dc);
% dlmwrite('lle.txt', lle);

% figure(1);
% scatter3(SCS,PIFD,dc(:,1)','filled');
% title('Two bidirectionally coupled FitzHugh-Nagumo oscillators');
% xlabel('Symmetric coupling strength');
% ylabel('Percentage intrinsic frequency difference');
% zlabel('Largest lyapunov exponent');
% figure(2);
% scatter3(SCS,PIFD,lle(:,1)','filled');
% title('Two bidirectionally coupled FitzHugh-Nagumo oscillators');
% xlabel('Symmetric coupling strength');
% ylabel('Percentage intrinsic frequency difference');
% zlabel('Correlation dimension');
%    