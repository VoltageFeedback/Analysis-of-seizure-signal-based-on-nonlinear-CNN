close all
clear all
ii = 0;
k1 = -1.4;
f1 = -0.0772*k1^2-0.1342*k1+0.0488;
for c = 0.1:0.1:0.3
    for k2 = -1.09:0.1:-0.87
%         k1 = -0.23;
%         k2 = -0.75;
%         c = 0.3;
        ii = ii+1;
        tspan = [0,100];
        init = [0.1,0.1,-0.1,-0.1];
        % initial condition.

%         [t,XY0] = ode45(@(t,y)di2(t,y,0,k1,k2),tspan,init);
%         tunit0 = tspan(2)/length(t);
%         f1 = intrin_f(XY0(:,1),tunit0);
%         f2 = intrin_f(XY0(:,3),tunit0);
%         % to get intrinsic frequency.
        f2 = -0.0772*k2^2-0.1342*k2+0.0488;
        PIFD(ii) = abs((f1-f2)/f1);
        SCS(ii) = c;

        [tt,XY] = ode45(@(t,y)di2(t,y,c,k1,k2),tspan,init);
        p1 = hilbert(XY(:,1)); 
        p2 = hilbert(XY(:,3));
        % Hilbert transform.
        tunit = tspan(2)/length(tt);
        fs = 1/tunit;

%             figure;
%             subplot(2,1,1);
%             plot(tt,XY(:,1),'b-',tt,XY(:,3),'r-');
%             xlabel('time');
%             legend('x1','x2');
%             % x1 line is blue, x2 line is red.
%             subplot(2,1,2);            
%             plot(real(p1),imag(p1),'b-.',real(p2),imag(p2),'r-.');
%             xlabel('x(t)');
%             ylabel('y(t)');
%             legend('oscillator_1','oscillator_2');

        data = imag(p2)';
        mp1 = meanperiod(data,fs);
        % to get the mean period.
        pp1 = autocorr(data,50);
        J1 = 1;
        for tau = 2:length(pp1)
            if pp1(tau) <= pp1(1)*(1-1/exp(1))
                J1 = tau;
                break
            end
        end
        % to get the time delay.

%         m1 = 2;
%         if J1 ~= 0
%             for em = 2:5
%                 coe1(em-1) = G_P0(data,J1,em,20);
%                 if em > 2 && abs(coe1(em-1)-coe1(em-2))/coe1(em-2) <= 0.1
%                     m1 = em-1;
%                     break
%                 end
%             end
%         end
%         dc(ii) = m1;
%         % to get the correlation dimension.
        
        dc_rp = dlmread('dc_rp2.txt');
        m1 = dc_rp(ii);
        lle(ii) = lyarosenstein_0(data,m1,J1,mp1,fs,150);
        % to get the largest lyapunov exponent.
    end
end

% dlmwrite('PIFD',PIFD);
% dlmwrite('SCS',SCS);
dlmwrite('lle_ip2.txt',lle);
% dlmwrite('dc_rp2.txt',dc);

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