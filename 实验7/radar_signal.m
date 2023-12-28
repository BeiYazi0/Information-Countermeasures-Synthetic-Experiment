function S = radar_signal(f0, theta, phi, PW, TOA, A, SNR)
N = length(theta);
n = -TOA-PW/2:N-TOA-PW/2-1;

phase = 2*pi * f0 * n + theta + phi; % 信号相位

S = awgn(A * rectpuls(n, PW) .* exp(1j*phase), SNR, 'measured');
end