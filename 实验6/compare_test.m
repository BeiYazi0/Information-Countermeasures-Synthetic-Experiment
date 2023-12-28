clear all;clc;close all;

fc = 1;          % 信号频率
DOAs = 0.4:0.3:1.3;         % 方位角
lambda = 1;      % 波长
d = 0.5 * lambda;% 天线间距
theta_s = 10;    % 相邻天线轴线夹角
theta_half = 10; % 半功率天线波束宽度
SNRs = -20:2:10; % 信噪比
Mc = 1000;       % 蒙特卡洛实验次数

RMSE_A = zeros(length(SNRs), length(DOAs));
RMSE_P = zeros(length(SNRs), length(DOAs));
for k = 1:length(DOAs)
    DOA = DOAs(k);
    for i = 1:length(SNRs)
        SNR = SNRs(i);
        for j = 1:Mc
            [s1, s2] = gaussian_antenna_generate_amplitude(fc, DOA, theta_s, theta_half, SNR);
            DOA_e = DOA_estimation_amplitude(s1, s2, theta_s, theta_half);
            RMSE_A(i, k) = RMSE_A(i, k) + (DOA_e - DOA)^2;
            [s1, s2] = gaussian_antenna_generate_phase(fc, DOA, d, lambda, SNR);
            DOA_e = DOA_estimation_phase(s1, s2, d, lambda);
            RMSE_P(i, k) = RMSE_P(i, k) + (DOA_e - DOA)^2;
        end
    end
end
RMSE_A = sqrt(RMSE_A / Mc);
RMSE_P = sqrt(RMSE_P / Mc);

figure(1);
hold on
for k = 1:length(DOAs)
    plot(SNRs, RMSE_A(:, k));
end
grid on;
legend(["DOA = 0.4", "DOA = 0.7", "DOA = 1.0", "DOA = 1.3"]);
set(gca,'yscale','log')
title("比幅法测向性能");
xlabel("信噪比");ylabel("测向性能");

figure(2);
hold on
for k = 1:length(DOAs)
    plot(SNRs, RMSE_P(:, k));
end
grid on;
legend(["DOA = 0.4", "DOA = 0.7", "DOA = 1.0", "DOA = 1.3"]);
set(gca,'yscale','log')
title("比相法测向性能");
xlabel("信噪比");ylabel("测向性能");

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