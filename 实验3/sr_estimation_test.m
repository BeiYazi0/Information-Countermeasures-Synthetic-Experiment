clear all;clc;close all;

SNRs = -20:2:10;

test_cnt = 100;


BPSK_precision = zeros(1, 16);
QPSK_precision = zeros(1, 16);
for SNR = SNRs
    idx = (SNR+20)/2+1;
    for i = 1:test_cnt
        BPSK_precision(idx) = BPSK_precision(idx) + (abs(get_sign_rate(BPSK_source(SNR), 1, 5)-0.1)/0.1)^2;
        QPSK_precision(idx) = QPSK_precision(idx) + (abs(get_sign_rate(QPSK_source(SNR), 1, 5)-0.1)/0.1)^2;
    end
end

BPSK_precision = sqrt(BPSK_precision/test_cnt);
QPSK_precision = sqrt(QPSK_precision/test_cnt);

figure;
plot(SNRs, BPSK_precision);
title('BPSK符合速率估计相对误差');
xlabel('SNR');
ylabel('相对误差');

figure;
plot(SNRs, QPSK_precision);
title('QPSK符合速率估计相对误差');
xlabel('SNR');
ylabel('相对误差');