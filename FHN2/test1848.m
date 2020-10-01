close all
clear all
ii = 0;
k1 = -1.4;
f1 = if_fc(k1);

tic;
c = 0.0088;
k2 = -0.88;
ii = ii+1;
tspan = [0,50];
init = [0.1,0.1,-0.1,-0.1];

f2 = if_fc(k2);
PIFD(ii) = abs((f1-f2)/f1);
SCS(ii) = c;

[tt,XY] = ode45(@(t,y)di2(t,y,c,k1,k2),tspan,init);
p1 = hilbert(XY(:,1)); 
p2 = hilbert(XY(:,3));
% Hilbert transform.
tunit = tspan(2)/length(tt);
fs = 1/tunit;

data = real(p1)';
data = single(data);
% tic;
% data = gpuArray(data);
% toc;
% tic;
% data = gather(data);
% toc;

mp1 = meanperiod(data,fs);
% to get the mean period.
[pp1,lags] = xcorr(data,'unbiased');
tau0 = find(lags==0);
J1 = 0;
for tau = (tau0+1):length(pp1)
    if pp1(tau) <= pp1(tau0)*(1-1/exp(1))
        J1 = tau-tau0;
        break
    end
end

em = 2;
coe1(em-1) = G_P0(data,J1,em,25);
% lle(ii) = lyarosenstein_0(data,4,J1,mp1,fs,500);
toc;