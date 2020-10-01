close all
clear all
PIFD = dlmread('PIFD.txt');
SCS = dlmread('SCS.txt');

% dc_rp2 = dlmread('dc_rp2.txt');
lle_rp1 = dlmread('lle_rp1.txt');
lle_ip1 = dlmread('lle_ip1.txt');
lle_p1 = [lle_rp1',lle_ip1'];
lle_rp2 = dlmread('lle_rp2.txt');
lle_ip2 = dlmread('lle_ip2.txt');
lle_p2 = [lle_rp2',lle_ip2'];

% z = lle_rp2;

% figure;
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
% scatter3(SCS,PIFD,z,'filled');
% grid on;
% title('FHN oscillators 2');
% xlabel('Symmetric coupling strength');
% ylabel('Percentage intrinsic frequency difference');
% % zlabel('Correlation dimension');
% zlabel('the first largest Lyapunove exponent');