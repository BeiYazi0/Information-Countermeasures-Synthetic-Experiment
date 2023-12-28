clear all;clc;close all;

SNRs = -20:2:10;

test_cnt = 100;

%% 使用方法一
ASK_precision = zeros(1, 16);
FSK_precision = zeros(1, 16);
BPSK_precision = zeros(1, 16);
QPSK_precision = zeros(1, 16);
for SNR = SNRs
    idx = (SNR+20)/2+1;
    for i = 1:test_cnt
        ASK_precision(idx) = ASK_precision(idx) + (abs(get_fc_1(ASK_source(2, SNR), 1)-0.3)/0.3)^2;
        FSK_precision(idx) = FSK_precision(idx) + (abs(get_fc_1(FSK_source(2, SNR), 2)-0.3)/0.3)^2;
        BPSK_precision(idx) = BPSK_precision(idx) + (abs(get_fc_1(BPSK_source(SNR), 3)-0.3)/0.3)^2;
        QPSK_precision(idx) = QPSK_precision(idx) + (abs(get_fc_1(QPSK_source(SNR), 4)-0.2)/0.2)^2;
    end
end

ASK_precision = sqrt(ASK_precision/test_cnt);
FSK_precision = sqrt(FSK_precision/test_cnt);
BPSK_precision = sqrt(BPSK_precision/test_cnt);
QPSK_precision = sqrt(QPSK_precision/test_cnt);

figure;
plot(SNRs, ASK_precision);
title('ASK载频估计相对误差(方法一)');
xlabel('SNR');
ylabel('相对误差');

figure;
plot(SNRs, FSK_precision);
title('FSK载频估计相对误差(方法一)');
xlabel('SNR');
ylabel('相对误差');

figure;
plot(SNRs, BPSK_precision);
title('BPSK载频估计相对误差(方法一)');
xlabel('SNR');
ylabel('相对误差');

figure;
plot(SNRs, QPSK_precision);
title('QPSK载频估计相对误差(方法一)');
xlabel('SNR');
ylabel('相对误差');

%% 使用方法二
ASK_precision = zeros(1, 16);
FSK_precision = zeros(1, 16);
BPSK_precision = zeros(1, 16);
QPSK_precision = zeros(1, 16);
for SNR = SNRs
    idx = (SNR+20)/2+1;
    for i = 1:test_cnt
        ASK_precision(idx) = ASK_precision(idx) + (abs(get_fc_2(ASK_source(2, SNR), 1)-0.3)/0.3)^2;
        FSK_precision(idx) = FSK_precision(idx) + (abs(get_fc_2(FSK_source(2, SNR), 1)-0.3)/0.3)^2;
        BPSK_precision(idx) = BPSK_precision(idx) + (abs(get_fc_2(BPSK_source(SNR), 1)-0.3)/0.3)^2;
        QPSK_precision(idx) = QPSK_precision(idx) + (abs(get_fc_2(QPSK_source(SNR), 1)-0.2)/0.2)^2;
    end
end

ASK_precision = sqrt(ASK_precision/test_cnt);
FSK_precision = sqrt(FSK_precision/test_cnt);
BPSK_precision = sqrt(BPSK_precision/test_cnt);
QPSK_precision = sqrt(QPSK_precision/test_cnt);

figure;
plot(SNRs, ASK_precision);
title('ASK载频估计相对误差(方法二)');
xlabel('SNR');
ylabel('相对误差');

figure;
plot(SNRs, FSK_precision);
title('FSK载频估计相对误差(方法二)');
xlabel('SNR');
ylabel('相对误差');

figure;
plot(SNRs, BPSK_precision);
title('BPSK载频估计相对误差(方法二)');
xlabel('SNR');
ylabel('相对误差');

figure;
plot(SNRs, QPSK_precision);
title('QPSK载频估计相对误差(方法二)');
xlabel('SNR');
ylabel('相对误差');