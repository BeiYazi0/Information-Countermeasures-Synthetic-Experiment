function [TOA, PW] = estimate_TOA_PW_by_thre(signal)
power = sum(abs(signal).^2) / length(signal);
thre = sqrt(power)*0.4;

index = find(abs(signal) >= thre);
n2 = max(index);
n1 = min(index);

TOA = n1;
PW = n2 - n1;
end