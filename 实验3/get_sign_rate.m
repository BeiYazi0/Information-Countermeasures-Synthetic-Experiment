function sr = get_sign_rate(signal, fs, s)
N = length(signal);

signal_delay = [zeros(s, 1); signal(1:end-s)];
x = conj(signal_delay) .* signal;
y_fft = abs(fft(x-mean(x)));

[~, idx] = max(y_fft(1:round(N/2)));
sr = (idx - 1)*fs/N;
end