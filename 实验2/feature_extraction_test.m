clear all;clc;close all;

SNRs = -20:2:10;

%% 使用方法一
ASK_cnt = zeros(3, 16);
BPSK_cnt = zeros(3, 16);
FSK_cnt = zeros(3, 16);
QPSK_cnt = zeros(3, 16);
for SNR = SNRs
    ASK_cnt(:, (SNR+20)/2+1) = feature_extraction_1(ASK_source(2, SNR), 0.75, 0.7, 0.7);
    BPSK_cnt(:, (SNR+20)/2+1) = feature_extraction_1(BPSK_source(SNR), 0.75, 0.7, 0.7);
    FSK_cnt(:, (SNR+20)/2+1) = feature_extraction_1(FSK_source(2, SNR), 0.75, 0.7, 0.7);
    QPSK_cnt(:, (SNR+20)/2+1) = feature_extraction_1(QPSK_source(SNR), 0.75, 0.7, 0.7);
end

figure;
plot(SNRs, ASK_cnt);
title('ASK信号谱峰-SNR图（方法一）');
xlabel('SNR');
ylabel('谱峰数');
legend('频谱', '二次方谱', '四次方谱')

figure;
plot(SNRs, BPSK_cnt);
title('BPSK信号谱峰-SNR图（方法一）');
xlabel('SNR');
ylabel('谱峰数');
legend('频谱', '二次方谱', '四次方谱')

figure;
plot(SNRs, FSK_cnt);
title('FSK信号谱峰-SNR图（方法一）');
xlabel('SNR');
ylabel('谱峰数');
legend('频谱', '二次方谱', '四次方谱')

figure;
plot(SNRs, QPSK_cnt);
title('QPSK信号谱峰-SNR图（方法一）');
xlabel('SNR');
ylabel('谱峰数');
legend('频谱', '二次方谱', '四次方谱')

% %% 使用方法二
% ASK_cnt = zeros(3, 16);
% BPSK_cnt = zeros(3, 16);
% FSK_cnt = zeros(3, 16);
% QPSK_cnt = zeros(3, 16);
% for SNR = SNRs
%     ASK_cnt(:, (SNR+20)/2+1) = feature_extraction_2(ASK_source(2, SNR), 8);
%     BPSK_cnt(:, (SNR+20)/2+1) = feature_extraction_2(BPSK_source(SNR), 8);
%     FSK_cnt(:, (SNR+20)/2+1) = feature_extraction_2(FSK_source(2, SNR), 8);
%     QPSK_cnt(:, (SNR+20)/2+1) = feature_extraction_2(QPSK_source(SNR), 8);
% end
% 
% figure;
% plot(SNRs, ASK_cnt);
% title('ASK信号谱峰-SNR图（方法二）');
% xlabel('SNR');
% ylabel('谱峰数');
% legend('频谱', '二次方谱', '四次方谱')
% 
% figure;
% plot(SNRs, BPSK_cnt);
% title('BPSK信号谱峰-SNR图（方法二）');
% xlabel('SNR');
% ylabel('谱峰数');
% legend('频谱', '二次方谱', '四次方谱')
% 
% figure;
% plot(SNRs, FSK_cnt);
% title('FSK信号谱峰-SNR图（方法二）');
% xlabel('SNR');
% ylabel('谱峰数');
% legend('频谱', '二次方谱', '四次方谱')
% 
% figure;
% plot(SNRs, QPSK_cnt);
% title('QPSK信号谱峰-SNR图（方法二）');
% xlabel('SNR');
% ylabel('谱峰数');
% legend('频谱', '二次方谱', '四次方谱')