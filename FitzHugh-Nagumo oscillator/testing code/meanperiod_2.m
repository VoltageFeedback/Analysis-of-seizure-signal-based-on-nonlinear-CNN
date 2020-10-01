function mp = meanperiod_2(X,fs)
% another way to get the mean period of power spectrum

Y = fft(X);
N = length(Y);                                     
% Y(1) is the sum of other elements, so we discard it.

power = abs(Y(1:ceil(N/2)+1)).^2;
power(2:end-1) = 2*power(2:end-1);
% to get the power spectrum.

freq = fs/N:fs/N:fs/2;
% to get the frequency.
T = 1./freq;                     

[maxp,index] = max(power);       
% to get the index of maxima.
mp = T(index);                           
% to get the mean period according to the index.