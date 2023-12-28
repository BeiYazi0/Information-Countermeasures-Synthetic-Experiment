clear all;clc;close all;

ts = 5000; % 仿真时长

fs = 1;   % 采样速率
fd = 0.1; % 符号速率
fc = 0.5; % 载频
tau = 4500; % 脉冲宽度
A = 1; % 振幅

N = ts * fs; % 采样点数
n = -N/2:N/2-1;
t = -ts/2:1/fs:ts/2-1;

%% 信号
% LFM
B = 0.4; % 带宽
K = B / tau; % 调制斜率
LFM_signal = radar_signal(fc, K*pi*(n.^2), 0, tau, A);

% BPSK
s = (randsrc(ts*fd,1,[0:1]) * ones(1, fs/fd)).';
tn = pi .* s(:).' .* rectpuls(n, tau);
BPSK_signal = radar_signal(fc, tn, 0, tau, A);

FF = linspace(0, 1, N);
LFM_fft = abs(fft(LFM_signal));
BPSK_fft = abs(fft(BPSK_signal));

figure;
plot(t, real(LFM_signal));
xlim([-N/32, N/32]);
title('LFM signal');xlabel('time/s');ylabel('amplitude');

figure;
plot(FF, LFM_fft);
title('LFM fft');xlabel('nomalized frequency');ylabel('amplitude');

figure;
plot(t, real(BPSK_signal));
xlim([-N/32, N/32]);
title('BPSK signal');xlabel('time/s');ylabel('amplitude');

figure;
plot(FF, BPSK_fft);
title('BPSK fft');xlabel('nomalized frequency');ylabel('amplitude');
