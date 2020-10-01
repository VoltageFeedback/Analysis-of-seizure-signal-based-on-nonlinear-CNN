figure();
[X,Y] = meshgrid(-2:.2:2, -2:.2:2);                                
Z = X .* exp(-X.^2 - Y.^2);                                       
[c h] = contourf(Z);
shading interp;
set(h, 'LineStyle','none');