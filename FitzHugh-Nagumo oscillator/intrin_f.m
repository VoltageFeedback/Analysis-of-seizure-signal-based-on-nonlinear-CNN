function f = intrin_f(data,tunit)
% to find the intrinsic frequency of time series

[V,In] = findpeaks(data);
% returns a vector with the local maxima (peaks) 
% of the input signal vector, data, and the indices at which the peaks occur.

d_In = In(3)-In(2);
% the interval between two peaks is period.

T = d_In*tunit;
f = 1/T;