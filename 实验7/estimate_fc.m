function fc = estimate_fc(signal, fs)
N = length(signal);
y_fft = abs(fft(signal))/N*2;

[~, k] = max(y_fft);
r = 1;
if y_fft(k + 1) < y_fft(k - 1)
    r = -1;
end

fc = fs*(k + r*y_fft(k+r)/(y_fft(k) + y_fft(k+r)))/N;
end