function S = radar_signal(f0, theta, phi, tau, A)
N = length(theta);
n = -N/2:N/2-1;

phase = 2*pi * f0 * n + theta + phi; % 信号相位

S = A * rectpuls(n, tau) .* exp(1j*phase);
end