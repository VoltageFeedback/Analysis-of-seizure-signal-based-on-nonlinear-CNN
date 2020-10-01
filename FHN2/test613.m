tic;
x = [1:6000];
y = [1:6000];
[xGrid,yGrid] = meshgrid( x, y );
z0 = xGrid + 1i*yGrid;
count = ones( size(z0), 'gpuArray' );
% count = ones( size(z0) );

z = z0;
for n = 0:1000
    z = z.*z + z0;
    inside = abs( z )<=2;
    count = count + inside;
end
count = log( count );

toc;