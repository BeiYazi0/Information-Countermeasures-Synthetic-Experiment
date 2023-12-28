clear all;clc;close all;

T = 2000;
fs = 1;   % 采样速率
fd = 0.1; % 符号速率
fc = 0.5; % 载频
PW = 1000; % 脉冲宽度
TOA = 500;
A = 1; % 振幅

Mc = 1000;   % 蒙特卡洛实验次数
Pfs =(0.01:0.02:1).^2; % 虚警概率
SNRs = -20:2:-10;   % 信噪比

N = T * fs; % 采样点数
n = -TOA-PW/2:N-TOA-PW/2-1;
t = 0:1/fs:T-1;

B = 0.4; % 带宽
K = B / PW; % 调制斜率

Pd = zeros(length(SNRs), length(Pfs));
for SNR = SNRs
    i = (SNR + 20)/2 + 1;
    for k = 1:Mc
%         S = A * rectpuls(n, tau) .* exp(1j*phase);
        LFM_signal = radar_signal(fc, K*pi*(n.^2), 0, PW, TOA, A);
        pulse_signal = pulse_compression(LFM_signal);
        ps = sum(abs(pulse_signal).^2) / (2*N-1); % 信号功率
        y = awgn(pulse_signal, SNR, 10*log10(ps));
        for j = 1:length(Pfs)
            Pd(i, j) = Pd(i, j) + detector(y, ps, SNR, Pfs(j));
        end
    end
end
Pd = Pd/Mc;

figure
hold on;
for i = 1:length(SNRs)
    plot(Pfs, Pd(i,:), '*-');
end
grid on
legend('SNR=-20dB','SNR=-18dB', 'SNR=-16dB','SNR=-14dB','SNR=-12dB','SNR=-10dB');
title ('不同信噪比的检测对比')
xlabel('Pf');
ylabel('Pd');