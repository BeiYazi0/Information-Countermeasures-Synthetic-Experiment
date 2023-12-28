function cnt = feature_extraction_2(signal, thes)
N = 40;

[y_fft, y_fft_2, y_fft_4] = get_spectrum(signal);
R_fft = y_fft./([zeros(N, 1); y_fft(1:end-N)] + [y_fft(N+1:end); zeros(N, 1)]);
R_fft_2 = y_fft_2./([zeros(N, 1); y_fft_2(1:end-N)] + [y_fft_2(N+1:end); zeros(N, 1)]);
R_fft_4 = y_fft_4./([zeros(N, 1); y_fft_4(1:end-N)] + [y_fft_4(N+1:end); zeros(N, 1)]);

cnt = zeros(3, 1);
cnt(1) = length(find(R_fft > thes));
cnt(2) = length(find(R_fft_2 > thes));
cnt(3) = length(find(R_fft_4 > thes));
end


% 获取频谱
function [y_fft, y_fft_2, y_fft_4] = get_spectrum(signal)
% 频谱
y_fft = abs(fftshift(fft(signal)));

% 二次方谱
signal_2 = signal.^2;
y_fft_2 = abs(fftshift(fft(signal_2 -mean(signal_2))));

% 四次方谱
signal_4 = signal_2.^2;
y_fft_4 = abs(fftshift(fft(signal_4 -mean(signal_4))));
end