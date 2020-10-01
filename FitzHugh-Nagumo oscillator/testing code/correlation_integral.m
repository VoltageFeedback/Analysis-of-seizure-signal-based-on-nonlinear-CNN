function CI = correlation_integral(X,N,r)
% the function is used to calculate correlation integral

% C_I: the value of the correlation integral
% X: the reconstituted state space,M is a m*M matrix
% m: the embedding demention
% M: M is the number of embedded points in m-dimensional sapce
% r: the radius of the Heaviside function,sigma/2<r<2sigma
% calculate the sum of all the values of Heaviside

sum_H = 0;
for i = 1:N
    for j = i+1:N
        d = norm((X(i,:)-X(j,:)),inf);
        % to calculat the distances of each two points in matris M with sup-norm
        % it returns the p-norm of matrix X. 
        % When p is inf, n is the maximum absolute row sum of the matrix.
        sita = heaviside(r-d);
        % to calculate the value of the heaviside function
        sum_H = sum_H+sita;
    end
end

CI = 2*sum_H/(N*(N-1));