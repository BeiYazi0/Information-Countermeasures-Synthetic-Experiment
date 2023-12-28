function G = interference_signal(f, t, JSR, S_power)
N = length(f); % N 个干扰
theta = rand(1, N)*2*pi; % 每个频率干扰信号的初始相位
phase = 2*pi * f.' * t + theta.' * ones(1, length(t)); % N * length(t)个

J = S_power * 10 ^ (JSR/10);
G = sqrt(J/N) * sum(exp(1j*phase), 1).'; % 沿 f 维度相加
end