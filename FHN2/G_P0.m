function coe1 = G_P0(data,tau,m,ss)
% the function is used to calculate correlation dimention with G-P algorithm

% data:the time series                       
% tau: the time delay                        
% min_m:the least embedded dimention m       
% max_m:the largest embedded dimention m     
% ss:the stepsize of r 

N = length(data);

Y=reconstitution0(data,m,tau);
% reconstitute state space.
M=N-(m-1)*tau;
% the number of points in state space.
d = zeros(M-1,M);
for i=1:M-1
    for j=i+1:M
        d(i,j)=max(abs(Y(:,i)-Y(:,j)));
        %calculate the distance of each two points in state space.
    end                                  
end
max_d=max(max(d));
% the max distance of all points.
d(1,1)=max_d;
min_d=min(min(d));
% the min distance of all points.
delt=(max_d-min_d)/ss;
% the stepsize of r.
ln_C = [];
ln_r = [];
parfor k=1:ss
    r=min_d+k*delt;
    C(k)=correlation_integral0(Y,M,r);%calculate the correlation integral
    ln_C(k)=log(C(k));%lnC(r)
    ln_r(k)=log(r);%lnr
end
% figure();
% plot(ln_r,ln_C);
coe = polyfit(ln_r(ceil(13*ss/36):ceil(19*ss/36)),ln_C(ceil(13*ss/36):ceil(19*ss/36)),1);
coe1 = coe(1);

