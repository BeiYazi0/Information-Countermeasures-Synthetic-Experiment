function cnt = feature_extraction_1(signal, thes_1, thes_2, thes_4)
[y_fft, y_fft_2, y_fft_4] = get_spectrum(signal);

cnt = zeros(3, 1);
cnt(1) = length(find(y_fft > thes_1 * max(y_fft)));
cnt(2) = length(find(y_fft_2 > thes_2 * max(y_fft_2)));
cnt(3) = length(find(y_fft_4 > thes_4 * max(y_fft_4)));
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