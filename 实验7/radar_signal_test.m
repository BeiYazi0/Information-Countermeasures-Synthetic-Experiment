clear all;clc;close all;

ts = 2000; % 仿真时长

fs = 1;   % 采样速率
fd = 0.1; % 符号速率
fc = 0.5; % 载频
PW = 1000; % 脉冲宽度
TOA = 500;
A = 1; % 振幅
SNR = 20; % 信噪比

N = ts * fs; % 采样点数
n = -TOA-PW/2:N-TOA-PW/2-1;
t = 0:1/fs:ts-1;

%% 信号
% 常规
norm_signal = radar_signal(fc, zeros(1, N), 0, PW, TOA, A, SNR);

% LFM
B = 0.4; % 带宽
K = B / PW; % 调制斜率
LFM_signal = radar_signal(fc, K*pi*(n.^2), 0, PW, TOA, A, SNR);

% BPSK
s = (randsrc(ts*fd,1,[-1, 1]) * ones(1, fs/fd)).';
tn = pi .* s(:).' .* rectpuls(n, PW);
BPSK_signal = radar_signal(fc, tn, 0, PW, TOA, A, SNR);

% QPSK
s = (randsrc(ts*fd,1,[-1, 1, 1i, -1i]) * ones(1, fs/fd)).';
tn = pi .* s(:).' .* rectpuls(n, PW);
QPSK_signal = radar_signal(fc, tn, 0, PW, TOA, A, SNR);

FF = linspace(0, 1, N);
norm_fft = abs(fft(norm_signal));
LFM_fft = abs(fft(LFM_signal));
BPSK_fft = abs(fft(BPSK_signal));
QPSK_fft = abs(fft(QPSK_signal));

figure;
plot(t, real(norm_signal));
% xlim([-N/32, N/32]);
title('norm signal');xlabel('time/s');ylabel('amplitude');

figure;
plot(FF, norm_fft);
title('norm fft');xlabel('nomalized frequency');ylabel('amplitude');

figure;
plot(t, real(LFM_signal));
% xlim([-N/32, N/32]);
title('LFM signal');xlabel('time/s');ylabel('amplitude');

figure;
plot(FF, LFM_fft);
title('LFM fft');xlabel('nomalized frequency');ylabel('amplitude');

figure;
plot(t, real(BPSK_signal));
% xlim([-N/32, N/32]);
title('BPSK signal');xlabel('time/s');ylabel('amplitude');

figure;
plot(FF, BPSK_fft);
title('BPSK fft');xlabel('nomalized frequency');ylabel('amplitude');

figure;
plot(t, real(QPSK_signal));
% xlim([-N/32, N/32]);
title('QPSK signal');xlabel('time/s');ylabel('amplitude');

figure;
plot(FF, QPSK_fft);
title('QPSK fft');xlabel('nomalized frequency');ylabel('amplitude');
