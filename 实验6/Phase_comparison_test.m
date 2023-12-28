clear all;clc;close all;

fc = 1;          % 信号频率
DOA = 1;         % 方位角
lambda = 1;      % 波长
d = 0.5 * lambda;% 天线间距
SNR = 10;        % 信噪比
Mc = 1000;       % 蒙特卡洛实验次数

RMSE = 0;
for i = 1:Mc
    [s1, s2] = gaussian_antenna_generate_phase(fc, DOA, d, lambda, SNR);
    DOA_e = DOA_estimation_phase(s1, s2, d, lambda);
    RMSE = RMSE + (DOA_e - DOA)^2;
end
RMSE = sqrt(RMSE / Mc);
fprintf("比相法测向性能: %f\n", RMSE);

%% function

function DOA = DOA_estimation_phase(signal1, signal2, d, lambda)
% 计算相位差
phase = angle(signal1 .* conj(signal2));

% 方位角估计
DOA = mean(asin(phase/(2*pi*d/lambda)));
end

function [s1, s2] = gaussian_antenna_generate_phase(fc, DOA, d, lambda, SNR)
% 功率归一化信号
t = 0:0.01:10;
s_power = 1;
s1 = sqrt(s_power) * cos(1j*2*pi*fc*t);
s2 = s1 * exp(-1j*2*pi*d/lambda*sin(DOA));

% 通过awgn信道，接收的信号
s1 = awgn(s1, SNR, 10*log10(s_power));
s2 = awgn(s2, SNR, 10*log10(s_power));
end