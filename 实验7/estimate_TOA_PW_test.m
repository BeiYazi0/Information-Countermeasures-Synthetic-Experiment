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
fprintf("实际值    TOA: %d    PW: %d\n", TOA, PW);

% 常规
norm_signal = radar_signal(fc, zeros(1, N), 0, PW, TOA, A, SNR);
[TOAt, PWt] = estimate_TOA_PW_by_thre(norm_signal);
fprintf("\n常规信号估计值(门限检测)    TOA: %d    PW: %d", TOAt, PWt);
[TOAt, PWt] = estimate_TOA_PW_by_power(norm_signal);
fprintf("\n常规信号估计值(能量检测)    TOA: %d    PW: %d\n", TOAt, PWt);

% LFM
B = 0.4; % 带宽
K = B / PW; % 调制斜率
LFM_signal = radar_signal(fc, K*pi*(n.^2), 0, PW, TOA, A, SNR);
[TOAt, PWt] = estimate_TOA_PW_by_thre(LFM_signal);
fprintf("\nLFM信号估计值(门限检测)    TOA: %d    PW: %d", TOAt, PWt);
[TOAt, PWt] = estimate_TOA_PW_by_power(LFM_signal);
fprintf("\nLFM信号估计值(能量检测)    TOA: %d    PW: %d\n", TOAt, PWt);

% BPSK
s = (randsrc(ts*fd,1,[-1, 1]) * ones(1, fs/fd)).';
tn = pi .* s(:).' .* rectpuls(n, PW);
BPSK_signal = radar_signal(fc, tn, 0, PW, TOA, A, SNR);
[TOAt, PWt] = estimate_TOA_PW_by_thre(BPSK_signal);
fprintf("\nBPSK信号估计值(门限检测)    TOA: %d    PW: %d", TOAt, PWt);
[TOAt, PWt] = estimate_TOA_PW_by_power(BPSK_signal);
fprintf("\nBPSK信号估计值(能量检测)    TOA: %d    PW: %d\n", TOAt, PWt);

% QPSK
s = (randsrc(ts*fd,1,[-1, 1, 1i, -1i]) * ones(1, fs/fd)).';
tn = pi .* s(:).' .* rectpuls(n, PW);
QPSK_signal = radar_signal(fc, tn, 0, PW, TOA, A, SNR);
[TOAt, PWt] = estimate_TOA_PW_by_thre(QPSK_signal);
fprintf("\nQPSK信号估计值(门限检测)    TOA: %d    PW: %d", TOAt, PWt);
[TOAt, PWt] = estimate_TOA_PW_by_power(QPSK_signal);
fprintf("\nQPSK信号估计值(能量检测)    TOA: %d    PW: %d\n", TOAt, PWt);

