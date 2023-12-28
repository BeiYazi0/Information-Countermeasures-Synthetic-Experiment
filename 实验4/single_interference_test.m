clear all;clc;close all;

JSRs = 10:-5:-5;
S_power = 1;

fs = 1;
fd = 0.1;%符号速率
fc = 0.3; %% 载频
R = 0.35; %% 滚降滤波器系数
K = 0.5;

t = 0:1/fs:200;

f = fc + ((1+R) * fd) * K;

for JSR = JSRs
    signal = interference_signal(f, t, JSR, S_power);
    figure;
    subplot(2, 1, 1);
    plot(t, real(signal));
    title(['JSR: ', num2str(JSR), 'dB']);xlabel('time/s');ylabel('Real');
    subplot(2, 1, 2);
    plot(t, imag(signal));
    title(['JSR: ', num2str(JSR), 'dB']);xlabel('time/s');ylabel('Imag');
end

single_signal = interference_signal(f, t, 10, S_power);
f_muti = [fc + ((1+R) * fd) * 0.4, fc + ((1+R) * fd) * 0.6];
muti_signal = interference_signal(f_muti, t, 10, S_power);

FF = linspace(-0.5, 0.5, length(t));
single_fft = abs(fftshift(fft(single_signal)));
muti_fft = abs(fftshift(fft(muti_signal)));

figure;
subplot(2, 1, 1);
plot(FF, single_fft);
title('single interference');xlabel('nomalized frequency');ylabel('amplitude');
subplot(2, 1, 2);
plot(FF, muti_fft);
title('muti interference');xlabel('nomalized frequency');ylabel('amplitude');
