function X = reconstitution(data,m,tau)
% to reconstitute the data in phase space.
% X will be a M*m matrix.

% data: time series.
% m: embedding dimension.
% tau: time delay.


N = length(data);
M = N-(m-1)*tau;

for j=1:M           
    for i=1:m
        X(j,i)=data((i-1)*tau+j);
    end
end