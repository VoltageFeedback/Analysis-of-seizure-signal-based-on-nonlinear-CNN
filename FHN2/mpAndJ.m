close all;
clear all;

k1 = -1.4;
f1 = if_fc(k1);
% scs = [0.005:0.005:0.500];
scs = [0.001:0.001:0.080];
k22 = -1.4:0.1:-1;
f2 = if_fc(k22);
pifd = abs((f1-f2)/f1);

lle = [];
mp1 = [];
J1 = [];

tic;
parfor c1 = 1:80
    for kk = 1:5
        c = scs(c1);
        k2 = k22(kk);
        tspan = [0,100];
        init = [0.1,0.1,-0.1,-0.1];
        [tt,XY] = ode45(@(t,y)di2(t,y,c,k1,k2),tspan,init);
        tt = tt(2:2:end,:);
        XY = XY(2:2:end,:);
        p1 = hilbert(XY(:,1)); 
        p2 = hilbert(XY(:,3));

    %     figure();
    %     plot(tt,real(p1),'b');

        tunit = tspan(2)/length(tt);
        fs = 1/tunit;

        data = real(p1)';
        data = single(data);

        mp1(kk,c1) = meanperiod(data,fs);

%         [pp1,lags] = xcorr(data,'unbiased');
%         tau0 = find(lags==0);
%         for tau = (tau0+1):length(pp1)
%             if pp1(tau) <= pp1(tau0)*(1-1/exp(1))
%                 J1(kk,c1) = tau-tau0;
%                 break
%             end
%         end

        pp1 = autocorr(data,50);
        for tau = 1:length(pp1)
            if pp1(tau) <= pp1(1)*(1-1/exp(1))
                J1(kk,c1) = tau;
                break
            end
        end
        
%         dmc = dc_rp1(kk,c1);
%         lle(kk,c1) = lyarosenstein_0(data,dmc,J1,mp1,fs,200);
    end
end
dlmwrite('mp1_r1_0.001-0.001-0.080_1.4-0.1-1.txt',mp1);
dlmwrite('J1_r1_0.001-0.001-0.080_1.4-0.1-1.txt',J1);
toc;