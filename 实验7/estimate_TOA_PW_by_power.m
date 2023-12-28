function [TOA, PW] = estimate_TOA_PW_by_power(signal)
N = length(signal);

E = cumsum(abs(signal).^2); % 能量
F = (E(end) - E(1))/(N-1) * (1:N) + E(1);
D = E - F;
[~, n2] = max(D);
[~, n1] = min(D);

TOA = n1;
PW = n2 - n1;
end