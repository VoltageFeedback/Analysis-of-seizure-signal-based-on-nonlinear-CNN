function coe1 = G_P(data,tau,m,ss)
% the function is used to calculate correlation dimention with G-P algorithm
%    
% data: the time series                       
% tau: the time delay                        
% min_m: the least embedded dimention m       
% max_m: the largest embedded dimention m     
% ss: the stepsize of r                       

N = length(data);
% N: the length of the time series           ??????


Y = reconstitution(data,m,tau);
% to reconstitute state space.
M = N-(m-1)*tau;
for i = 1:M-1
    for j = i+1:M
        d(i,j) = max(abs(Y(i,:)-Y(j,:)));
        % to calculate the distance of each two points in state space
    end
end
max_d = max(max(d));%the max distance of all points   
d(1,1) = max_d;
min_d = min(min(d));%the min distance of all points   
delt = (max_d-min_d)/ss;%the stepsize of r            
for k = 1:ss
    r = min_d+k*delt;
    C(k) = correlation_integral(Y,M,r);
    ln_C(k) = log(C(k));
    ln_r(k) = log(r);
end
coe = polyfit(ln_r,ln_C,1);
coe1 = coe(1);

