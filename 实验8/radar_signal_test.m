clear all;clc;close all;

ts = 2000; % 仿真时长

fs = 1;   % 采样速率
fd = 0.1; % 符号速率
fc = 0.5; % 载频
PW = 1000; % 脉冲宽度
TOA = 500;
A = 1; % 振幅
SNR = -10;

N = ts * fs; % 采样点数
n = -TOA-PW/2:N-TOA-PW/2-1;
t = 0:1/fs:ts-1;

%% 信号
% LFM
B = 0.4; % 带宽
K = B / PW; % 调制斜率
LFM_signal = radar_signal(fc, K*pi*(n.^2), 0, PW, TOA, A);
ps = sum(abs(LFM_signal).^2) / N; % 信号功率
y = awgn(LFM_signal, SNR, 10*log10(ps));

pulse_signal = pulse_compression(LFM_signal);
y_pulse = awgn(pulse_signal, SNR, 'measured');

FF = linspace(0, 1, N);
LFM_fft = abs(fft(LFM_signal));

figure;
plot(t, real(LFM_signal));
title('LFM signal');xlabel('time/s');ylabel('amplitude');

figure;
plot(FF, LFM_fft);
title('LFM fft');xlabel('nomalized frequency');ylabel('amplitude');

t2 = linspace(0, ts-1, 2*N-1);
figure;
plot(t2, abs(pulse_signal));
title('pulse signal');xlabel('time/s');ylabel('amplitude');


figure;
plot(t, abs(y));
title('LFM signal + noise');xlabel('time/s');ylabel('amplitude');

figure;
plot(t2, abs(y_pulse));
title('LFM signal after pulse compression + noise');xlabel('time/s');ylabel('amplitude');
