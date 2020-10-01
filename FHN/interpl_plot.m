% close all;
% clear all;
% A = wgn(5,100,10);
% a = [1:5]; % m elements.
% b = [1:100]; % n elements.
% c = A'; % a n*m matrix.
% figure();
% % s = surf(a,b,c,'FaceAlpha',1);
% % s.EdgeColor = 'none';
% 
% pcolor(a,b,c); % x axis is a, y axis is b.
% colormap jet;
% shading interp;
% colorbar;

A = [1,2,3,2,1,3,5,3];
ind4 = find(diff(A)>0)
