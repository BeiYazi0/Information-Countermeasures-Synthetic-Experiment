clear all;clc;close all;

ASK_signal = ASK_source(2, 10);
BPSK_signal = BPSK_source(10);
FSK_signal = FSK_source(2, 10);
QPSK_signal = QPSK_source(10);

plot_spectrum(ASK_signal, 'ASK');
plot_spectrum(BPSK_signal, 'BPSK');
plot_spectrum(FSK_signal, 'FSK');
plot_spectrum(QPSK_signal, 'QPSK');

%% 功能函数

% 绘制频谱
function plot_spectrum(signal, signal_name)
N = length(signal);
FF = linspace(-0.5, 0.5, N); %% 频谱观察范围为-fs/2~fs/2之间

[y_fft, y_fft_2, y_fft_4] = get_spectrum(signal);

figure;
plot(FF, y_fft);
title([signal_name, ' ', 'passband signal of pulse shaped in frequency domain']);
xlabel('normalized frequency');
ylabel('amplitude');

figure;
plot(FF, y_fft_2);
title([signal_name, ' ', '二次方谱']);
xlabel('normalized frequency');
ylabel('amplitude');

figure;
plot(FF, y_fft_4);
title([signal_name, ' ', '四次方谱']);
xlabel('normalized frequency');
ylabel('amplitude');
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