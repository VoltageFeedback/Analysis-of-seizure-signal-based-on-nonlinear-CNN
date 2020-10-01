close all
clear all
% PIFD = dlmread('PIFD (2).txt');
% SCS = dlmread('SCS (2).txt');
PIFD = [0.2107,0.2416,0.2544,0.2107,0.2416,0.2544,0.2107,0.2416,0.2544];
SCS = [0.1,0.1,0.1,0.2,0.2,0.2,0.3,0.3,0.3];

% dc_rp1 = dlmread('dc_rp1 (2).txt');
lle_ip2 = dlmread('lle_ip2 (2).txt');
% lle_ip1 = dlmread('lle_ip1.txt');
% lle_p1 = [lle_rp1',lle_ip1'];
% lle_rp2 = dlmread('lle_rp2.txt');
% lle_ip2 = dlmread('lle_ip2.txt');
% lle_p2 = [lle_rp2',lle_ip2'];

% z = dc_rp1;
z = lle_ip2;

figure;
% subplot(2,1,1);
% scatter(SCS,PIFD,'filled','cdata',z);
% grid on;
% c = colorbar;
% % c.Label.String = 'Correlation dimension';
% c.Label.String = 'The first largest Lyapunove exponent';
% title('FHN oscillators 2');
% xlabel('Symmetric coupling strength');
% ylabel('Percentage intrinsic frequency difference');
% subplot(2,1,2);
scatter3(SCS,PIFD,z,'m');
grid on;
% title('the 1st time series');
title('the 2nd time series');
xlabel('SCS');
ylabel('PIFD');
% zlabel('Dc');
% zlabel('1st lambda max');
zlabel('2nd lambda max');