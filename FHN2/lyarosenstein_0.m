function lle = lyarosenstein_0(x,m,tao,meanperiod,fs,maxiter) 
% d:divergence of nearest trajectoires
% x:signal
% tao:time delay
% m:embedding dimension

N = length(x);
M = N-(m-1)*tao;
Y = recons(x,m,tao);
% size(Y) is M*m.

parfor i = 1:M
    x0 = ones(M,1)*Y(i,:);
    % size(x0) is M*1.
    distance = sqrt(sum((Y-x0).^2,2));
    for j = 1:M
        if abs(j-i)<=meanperiod
            distance(j)=1e10;
        end
    end
    [neardis(i),nearpos(i)] = min(distance);
    % to get the initial distance of ith row
end

parfor k = 1:maxiter
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

t = 1:maxiter;
d = d(t);
% c = polyfit(t,d(t),4);
% l = c(1)*t.^4+c(2)*t.^3+c(3)*t.^2+c(4)*t.^1+c(5);

% figure();
% plot(t,d,'b');
% hold on
% line([1,maxiter],[mean(d),mean(d)],'Color','red');
% hold off

% d = d(1:maxiter);
% % length(diff(d,2))
% figure();
% plot(1:maxiter,d,'b',1:(maxiter-1),diff(d,1),'r',1:(maxiter-2),diff(d,2),'g');
% find(diff(d(1:50),1)>=0)
% diff(d(101:150),1)

%% LLE Calculation
% tlinear = ceil(maxiter*0.5):ceil(maxiter*0.8);
ind0 = find(d);
d = d(ind0);
lnth = length(d);
type = 0;
ll1 = ceil(lnth/4);
ll2 = ceil(lnth/10);

if sum(d(1:ll1)<mean(d))<ll2 
    ind1 = find(d<mean(d));
    aa = max((ind1(1)+ll2), ceil(lnth*2/3));
    if sum((d(aa):d(lnth))>mean(d))<(lnth-aa)/10
        if ind1(1)<ceil(lnth/20)
            type = 3;
        else
            type = 1; % non-periodical.
            F = polyfit(1:ind1(1),d(1:ind1(1)),1);
        end
    else
        type = 3;
    end
elseif sum(d(1:ll1)>mean(d))<ll2
    ind1 = find(d>mean(d));
    if sum((d(ind1(1)+ll2):d(lnth))<mean(d))<ll2
        % from the first value above mean, still 1/4 values are larger than
        % mean.
        type = 2; % periodical.
        lnth2 = length(ind1);
        co1 = [0];
        for iii = 1:(lnth2-ll2)
            i22 = ind1(iii):ind1(iii+ll2);
            d22 = d(ind1(iii):ind1(iii+ll2));
            co = polyfit(i22, d22, 1);
            co1(iii) = co(1,1);
        end
        co2 = abs(co1);
        [ccc,ind3] = min(co2);
        F = co1(ind3);
    else
        type = 3;
    end
else
    type = 3; % chaotic.
end

if type == 3
%     diff_d = diff(d,1);
%     F = mean(diff_d(find(diff_d>0)));
    for iii = 25:(lnth-25)
        i22 = iii:(iii+20);
        d22 = d(iii:(iii+20));
        co = polyfit(i22, d22, 1);
        co1(iii-24) = co(1,1);
    end
    diff_d = diff(d,1);
    diff_d2 = diff_d(25:(lnth-25));
    ind4 = find(diff_d2>0);
    co2 = abs(co1(ind4));
    F = max(co2);
end

% F = polyfit(t,d,1);
% the coefficient of fitting curve
if type == 0
    lle = 0;
else
    lle = F(1,1)*fs;
end

% if lle>=0.05
    figure();
    plot(1:lnth,d,'b');
    xlabel(['type = ', num2str(type)]);
    hold on
    line([1,maxiter],[mean(d),mean(d)],'Color','red');
    hold off
% end

function Y = recons(x,m,tao)
% Phase space reconstruction
% x : time series 
% m : embedding dimension
% tao : time delay
% npoint : total number of reconstructed vectors
% Y : a M*m matrix

N = length(x);
M = N-(m-1)*tao;

Y = zeros(M,m); 

parfor i = 1:m
    Y(:,i) = x((1:M)+(i-1)*tao)';
end