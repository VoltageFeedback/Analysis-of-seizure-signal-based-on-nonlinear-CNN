function d = lyarosenstein_0(x,m,tao,meanperiod,fs,maxiter) 
% d:divergence of nearest trajectoires
% x:signal
% tao:time delay
% m:embedding dimension

N = length(x);
M = N-(m-1)*tao;
Y = recons(x,m,tao);

for i = 1:M
    x0 = ones(M,1)*Y(i,:);
    distance = sqrt(sum((Y-x0).^2,2));
    for j = 1:M
        if abs(j-i)<=meanperiod
            distance(j)=1e10;
        end
    end
    [neardis(i),nearpos(i)]=min(distance);
    % to get the initial distance of ith row
end

for k = 1:maxiter
    maxind = M-k;
    dsum = 0;
    pnt = 0;
    for j = 1:M
        if j<=maxind && nearpos(j)<=maxind
            dist_k = sqrt(sum((Y(j+k,:)-Y(nearpos(j)+k,:)).^2,2));
             if dist_k~=0
                dsum = dsum+log(dist_k);
                pnt = pnt+1;
             end
        end
    end
    if pnt > 0
        d(k) = dsum/pnt;
    else
        d(k) = 0;
    end
    
end
figure;
plot(d);


%% LLE Calculation
tlinear = ceil(maxiter*0.2):ceil(maxiter*0.8);
F = polyfit(tlinear,d(tlinear),1);
lle = F(1,1)*fs


function Y = recons(x,m,tao)
% Phase space reconstruction
% x : time series 
% m : embedding dimension
% tao : time delay
% npoint : total number of reconstructed vectors
% Y : a M*m matrix

N = length(x);
M=N-(m-1)*tao;

Y = zeros(M,m); 

for i = 1:m
    Y(:,i) = x((1:M)+(i-1)*tao)';
end