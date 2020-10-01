close all;
clear all;

k1 = -1.4;
lle = [];

dc_rp1 = dlmread('dc_r1_0.005-0.025_0.98.txt');
% 5 DCs.
dc_rp2 = dlmread('dc_r1_0.3-0.6_0.98.txt');
% 2 DCs.
dc_rp = [dc_rp1,dc_rp2];
cc = [0.005:0.005:0.025,0.3,0.6];

for c1 = 1:7
    c = cc(c1);
    k2 = -0.98;
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

    mp1 = meanperiod(data,fs);
    
    pp1 = autocorr(data,50);
    J1 = 0;
    for tau = 1:length(pp1)
        if pp1(tau) <= pp1(1)*(1-1/exp(1))
            J1 = tau;
            break
        end
    end
    dmc = dc_rp(c1);
    lle(c1) = lyarosenstein_0(data,dmc,J1,mp1,fs,200);
end

