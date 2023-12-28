clear all;clc;close all;

fc = 1;          % 信号频率
DOA = 3;         % 方位角
theta_s = 10;    % 相邻天线轴线夹角
theta_half = 10; % 半功率天线波束宽度
SNR = 10;        % 信噪比
Mc = 1000;       % 蒙特卡洛实验次数

RMSE = 0;
for i = 1:Mc
    [s1, s2] = gaussian_antenna_generate_amplitude(fc, DOA, theta_s, theta_half, SNR);
    DOA_e = DOA_estimation_amplitude(s1, s2, theta_s, theta_half);
    RMSE = RMSE + (DOA_e - DOA)^2;
end
RMSE = sqrt(RMSE / Mc);
fprintf("比幅法测向性能: %f\n", RMSE);

%% function

function DOA = DOA_estimation_amplitude(signal1, signal2, theta_s, theta_half)
% 计算功率
s1_power = sum(abs(signal1).^2)/length(signal1);
s2_power = sum(abs(signal2).^2)/length(signal2);

% 功率比值
R = 10*log10(s1_power/s2_power);

% 方位角估计
DOA = theta_half^2 * R / (24.32 * theta_s);
end

function [s1, s2] = gaussian_antenna_generate_amplitude(fc, DOA, theta_s, theta_half, SNR)
% 功率归一化信号
t = 0:0.01:10;
s_power = 1;
s = sqrt(s_power) * cos(1j*2*pi*fc*t);

% 计算天线功率增益
F1 = exp(-2.8 * (DOA - theta_s/2).^2 / theta_half^2);
F2 = exp(-2.8 * (DOA + theta_s/2).^2 / theta_half^2);

s1 = sqrt(F1) * s;
s2 = sqrt(F2) * s;

% 通过awgn信道，接收的信号
s1 = awgn(s1, SNR, 10*log10(F1 * s_power));
s2 = awgn(s2, SNR, 10*log10(F2 * s_power));
end