function PA = estimate_PA(signal)
[TOA, PW] = estimate_TOA_PW_by_power(signal);
signal_r = [signal(1:TOA-1), signal(TOA+PW+1:end)];

N = length(signal_r);
PA = mean(abs(signal_r).^2) - abs(mean(signal_r))^2;
end