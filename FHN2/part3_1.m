close all
clear all
k1 = -1.4;
f1 = if_fc(k1);
tic;
dc = [];
lle = [];
cc = [];
% k2 = -1.4:0.1:-1;
parfor c1 = 1:2
% for c1 = [1]
%     for b1 = 1:3
%         c = 0.0088;
        k2 = -0.98;
        c = c1*3/10;
        tspan = [0,100];
        init = [0.1,0.1,-0.1,-0.1];
        % initial condition.

%         [t,XY0] = ode45(@(t,y)di2(t,y,0,k1,k2),tspan,init);
%         tunit0 = tspan(2)/length(t);
%         f1 = intrin_f(XY0(:,1),tunit0);
%         f2 = intrin_f(XY0(:,3),tunit0);
%         % to get intrinsic frequency.
%         f2 = if_fc(k2(b1));
%         PIFD(c1) = abs((f1-f2)/f1);
%         SCS(c1) = c;
%         cc(b1,c1) = f2*c1*b1;

        [tt,XY] = ode45(@(t,y)di2(t,y,c,k1,k2),tspan,init);
        tt = tt(2:2:end,:);
        XY = XY(2:2:end,:);
        p1 = hilbert(XY(:,1)); 
        p2 = hilbert(XY(:,3));
        % Hilbert transform.
        tunit = tspan(2)/length(tt);
        fs = 1/tunit;

%         figure();
%         plot(tt,real(p1),'b-.');
%         figure();
%         plot(tt,imag(p1),'b-.');
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
        data = single(data);
%         data = gpuArray(data);
        
        mp1 = meanperiod(data,fs);
%         % to get the mean period.
%         [pp1,lags] = xcorr(data,'unbiased');
%         tau0 = find(lags==0);
%         J1 = 0;
%         for tau = (tau0+1):length(pp1)
%             if pp1(tau) <= pp1(tau0)*(1-1/exp(1))
%                 J1 = tau-tau0;
%                 break
%             end
%         end
%         % to get the time delay.
        
        pp1 = autocorr(data,50);
        J1 = 0;
        for tau = 1:length(pp1)
            if pp1(tau) <= pp1(1)*(1-1/exp(1))
                J1 = tau;
                break
            end
        end
        % to get the time delay.

        dmc = 2;
        if J1 ~= 0
            coe1 = [];
            for em = 2:10
                coe1(em-1) = G_P0(data,J1,em,25);
                if em > 2 && abs(coe1(em-1)-coe1(em-2))/coe1(em-2) <= 0.05
                    dmc = em-1;
                    break
                end
            end
        end
        dc(c1) = dmc;
%         to get the correlation dimension.
        
%         dc_rp = dlmread('dc_rp1.txt');
%         dmc = dc_rp(c+1);
%         lle = lyarosenstein_0(data,2,J1,mp1,fs,300);
%         lle(c1) = lyarosenstein_0(data,dmc,J1,mp1,fs,300);
        % to get the largest lyapunov exponent.
%     end
end
dlmwrite('dc_r1_0.3-0.6_0.98.txt',dc);
% dlmwrite('lle_r1_098.txt',lle);
toc;
% dc(find(dc~=0))
% lle(find(lle~=0))

% CC = dlmread('cc-.txt');

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