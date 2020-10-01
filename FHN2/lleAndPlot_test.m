close all;
clear all;

k1 = -1.4;
f1 = if_fc(k1);
scs = [0.005:0.005:0.500];
% scs = [0.001:0.001:0.080];
k22 = -1.4:0.1:-1;
f2 = if_fc(k22);
pifd = abs((f1-f2)/f1);

lle = [];

dc_rp1 = dlmread('dc_r1_0.005-0.005-0.500_1.4-0.1-1.txt');
% 5*100.
% dc_rp1 = dlmread('dc_r1_0.001-0.001-0.080_1.4-0.1-1.txt');
% 5*80.
% mp1 = dlmread('mp1_r1_0.005-0.005-0.500_1.4-0.1-1.txt');
% J1 = dlmread('J1_r1_0.005-0.005-0.500_1.4-0.1-1.txt');
mp1 = dlmread('mp1_r1_0.001-0.001-0.080_1.4-0.1-1.txt');
J1 = dlmread('J1_r1_0.001-0.001-0.080_1.4-0.1-1.txt');
% 
% % kk = 5;
% % c1 = 4;
% % J1(5,4)
tic;
for c1 = 80
    for kk = 1
        c = scs(c1);
        k2 = k22(kk);
        tspan = [0,100];
        init = [0.1,0.1,-0.1,-0.1];
        [tt,XY] = ode45(@(t,y)di2(t,y,c,k1,k2),tspan,init);
        tt = tt(2:2:end,:);
        XY = XY(2:2:end,:);
        p1 = hilbert(XY(:,1)); 
        p2 = hilbert(XY(:,3));
        tunit = tspan(2)/length(tt);
        fs = 1/tunit;
        data = real(p1)';
        data = single(data);

        figure();
        plot(tt,real(p1),'b');
        lle(kk,c1) = lyarosenstein_0(data,dc_rp1(kk,c1),J1(kk,c1),mp1(kk,c1),fs,300);
    end
end
toc;

% lle(6,:) = lle(5,:);

% a = scs; % m elements.
% b = pifd; % n elements.
% c = dc_rp1; % a n*m matrix.
% figure();
% 
% pcolor(a,b,c);
% colormap jet;
% shading interp;
% % temp1 = dlmread('caxis_rp1.txt');
% % caxis(temp1);
% colorbar;
% % dlmwrite('caxis_rp1.txt',caxis);
% % title('The first Lyapunov exponent of the first time series');
% % title('The second Lyapunov exponent of the first time series');
% title('The correlation dimension of the first time series');
% % title('The correlation dimension of the second time series');
% xlabel('Symmetric coupling strength');
% ylabel('Percentage intrinsic frequency difference');
% % hold on;
% % line([0.08,0.08],[0,pifd(end)],'Color','black','LineWidth',2);
% % hold off;
% % set(gca, 'ylim', [0, 0.25]);