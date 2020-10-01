function X = reconstitution0(data,m,tau)
% to reconstitute the state space.
% data: time series.
% m: embedding dimension.
% tau: time delay.
% X: a m*n matrix.

N = length(data);
M = N-(m-1)*tau;
for j = 1:M           
    for i = 1:m
        X(i,j) = data((i-1)*tau+j);
    end
end