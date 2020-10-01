function mp = meanperiod(X,fs)
% to get the mean period of power spectrum

Y = fft(X);
N = length(Y);                                     
% Y(1) is the sum of other elements, so we discard it.

power = abs(Y(ceil(1:N/2))).^2;
% to get the power spectrum.

freq = (1:N/2)/(N/2)/2;
% to get the frequency.
T = 1./freq;                     

[maxp,index] = max(power);       
% to get the index of maxima.
mp = T(index);                           
% to get the mean period according to the index.