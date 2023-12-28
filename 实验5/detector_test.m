clear all;clc;close all;

T = 1000;  % 仿真时长
Fs = 1;    % 采样速率
fc = 0.5;  % 载频
tau = 600; % 脉冲宽度
A = 1;     % 振幅

Mc = 1000;   % 蒙特卡洛实验次数
Pfs =(0.01:0.02:1).^2; % 虚警概率
SNRs = -20:2:-10;   % 信噪比

N = Fs * T;  % 采样点数
n = -N/2:N/2-1;
t = -T/2:1/Fs:T/2-1;

Pd = zeros(length(SNRs), length(Pfs));
for SNR = SNRs
    i = (SNR + 20)/2 + 1;
    for k = 1:Mc
        t = ((k-1)*N+1:k*N) / Fs; %时间轴
        phase = 2*pi * fc * t;
        S = A * rectpuls(n, tau) .* exp(1j*phase);
        ps = sum(abs(S).^2) / N; % 信号功率
        y = awgn(S, SNR, 10*log10(ps));
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