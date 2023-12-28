function flag = detector(signal, ps, SNR, Pf)
N = length(signal);
SNR = 10^(SNR/10);

th = ps/SNR * (N+sqrt(2*N)*sqrt(2)*erfcinv(2*Pf)); %门限值
power = sum(abs(signal).^2); %接收信号能量

if power > th
    flag = 1; %进行判决
else
    flag = 0;
end
end