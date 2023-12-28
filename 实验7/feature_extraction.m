function feature_extraction(signal, signal_name)
[y_fft_2, y_fft_4] = get_spectrum(signal);

N = length(signal);
FF = linspace(-0.5, 0.5, N);

figure();
subplot(1,2,1);
plot(FF, y_fft_2);
title([signal_name, ' ', '二次方谱']);xlabel('nomalized frequency');ylabel('amplitude');

subplot(1,2,2);
plot(FF, y_fft_4);
title([signal_name, ' ', '四次方谱']);xlabel('nomalized frequency');ylabel('amplitude');
end


% 获取频谱
function [y_fft_2, y_fft_4] = get_spectrum(signal)
% 二次方谱
signal_2 = signal.^2;
y_fft_2 = abs(fftshift(fft(signal_2)));

% 四次方谱
signal_4 = signal_2.^2;
y_fft_4 = abs(fftshift(fft(signal_4)));
end