clear all;clc;close all;

ts = 2000; % 仿真时长

fs = 1;   % 采样速率
fd = 0.1; % 符号速率
fc = 0.5; % 载频
PW = 1000; % 脉冲宽度
TOA = 200;
A = 1; % 振幅
SNR = 20; % 信噪比

N = ts * fs; % 采样点数
n = -TOA-PW/2:N-TOA-PW/2-1;
t = 0:1/fs:ts-1;

%% 信号
fprintf("实际值    PA: %d    f: %d\n", 0.005, 0.5);

% 常规
norm_signal = radar_signal(fc, zeros(1, N), 0, PW, TOA, A, SNR);
fprintf("\n常规信号估计值    PA: %d    f: %d\n", estimate_PA(norm_signal), estimate_fc(norm_signal, fs));

% LFM
B = 0.4; % 带宽
K = B / PW; % 调制斜率
LFM_signal = radar_signal(fc, K*pi*(n.^2), 0, PW, TOA, A, SNR);
fprintf("\nLFM信号估计值    PA: %d    f: %d\n", estimate_PA(LFM_signal), estimate_fc(LFM_signal, fs));

% BPSK
s = (randsrc(ts*fd,1,[-1, 1]) * ones(1, fs/fd)).';
tn = pi .* s(:).' .* rectpuls(n, PW);
BPSK_signal = radar_signal(fc, tn, 0, PW, TOA, A, SNR);
fprintf("\nBPSK信号估计值    PA: %d    f: %d\n", estimate_PA(BPSK_signal), estimate_fc(BPSK_signal, fs));

% QPSK
s = (randsrc(ts*fd,1,[-1, 1, 1i, -1i]) * ones(1, fs/fd)).';
tn = pi .* s(:).' .* rectpuls(n, PW);
QPSK_signal = radar_signal(fc, tn, 0, PW, TOA, A, SNR);
fprintf("\nQPSK信号估计值    PA: %d    f: %d\n", estimate_PA(QPSK_signal), estimate_fc(QPSK_signal, fs));
