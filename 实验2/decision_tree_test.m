clear all;clc;close all;

SNRs = -20:2:10;
test_cnt = 100; % 每个信噪比下的测试次数

ASK_true_cnt = zeros(1, 16);
BPSK_true_cnt = zeros(1, 16);
FSK_true_cnt = zeros(1, 16);
QPSK_true_cnt = zeros(1, 16);
for SNR = SNRs
    for j = 1:test_cnt
        if(decision_tree(ASK_source(2, SNR)) == 1)
            ASK_true_cnt((SNR+20)/2+1) = ASK_true_cnt((SNR+20)/2+1) + 1;
        end
        if(decision_tree(FSK_source(2, SNR)) == 2)
            FSK_true_cnt((SNR+20)/2+1) = FSK_true_cnt((SNR+20)/2+1) + 1;
        end
        if(decision_tree(BPSK_source(SNR)) == 3)
            BPSK_true_cnt((SNR+20)/2+1) = BPSK_true_cnt((SNR+20)/2+1) + 1;
        end
        if(decision_tree(QPSK_source(SNR)) == 4)
            QPSK_true_cnt((SNR+20)/2+1) = QPSK_true_cnt((SNR+20)/2+1) + 1;
        end
    end
end

figure;
plot(SNRs, ASK_true_cnt/test_cnt);
title('ASK信号正确识别率');
xlabel('SNR');
ylabel('正确识别率');

figure;
plot(SNRs, BPSK_true_cnt/test_cnt);
title('BPSK信号正确识别率');
xlabel('SNR');
ylabel('正确识别率');

figure;
plot(SNRs, FSK_true_cnt/test_cnt);
title('FSK信号正确识别率');
xlabel('SNR');
ylabel('正确识别率');

figure;
plot(SNRs, QPSK_true_cnt/test_cnt);
title('QPSK信号正确识别率');
xlabel('SNR');
ylabel('正确识别率');