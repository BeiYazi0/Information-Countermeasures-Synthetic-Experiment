clear all;clc;close all;

%%----参数设定---------%%
M=4; %% M=4的PSK
N=500; %%% 符号个数（信号时间长度与符号速率相乘即为符号个数）
fs=1;%采样频率
fd=0.1;%符号速率
fc=0.3; %% 载频
r=fs/fd;%%% 过采样率
filtorder = 60; % Filter order
a=0.35; %% 滚降滤波器系数
delay = filtorder/(r*2); % 群延迟Group delay (# of input samples)
h=rcosfir(a, delay, r,1,'sqrt');%%% 产生滤波器系数。采用根升余弦滤波器，使得匹配接收后为升余弦滤波器，从而避免ISI;
h=sqrt(r)*h/norm(h); %%% 归一化滤波器系数，使经过成型滤波后的信号功率为1

% fs=1;%采样频率
% fd=0.25;%符号速率
% fc=0.3; %% 载频
% r=fs/fd;%%% 过采样率
% M=2; %% MPSK
% N=200; %%% 符号个数
% a=0.35; %% 滚将滤波器系数
% delay=3; %% 延迟
% h=rcosfir(a, delay, r,1,'sqrt');%%% 采用根升余弦滤波器，使得匹配接收后为升余弦滤波器，从而避免ISI;
% h=sqrt(r)*h/norm(h); %%% 归一化滤波器系数

EbN0_v=[3:10]; %信噪比
h_r=h(end:-1:1); %%% 接收端匹配滤波器，由于线性相位对称，可不需要
K=1000; %% 仿真次数；

for m=1:length(EbN0_v)
    EbN0=EbN0_v(m);
    EsN0=EbN0+10*log10(log2(M));
    SNR=EsN0-10*log10(r);%采样频率范围内的信噪比 
for k=1:K
    s=randsrc(N,1,[0:M-1]);
    s_mod=pskmod(s,M);
    %scatterplot(s_mod);
% %     s_base=rectpulse(s_mod,r);
    s_base=zeros(r,N);
    s_base(1,:)=s_mod.';
    s_base=s_base(:);
    s_base=conv(h.',s_base);
    y_x=s_base.*exp(1j*(2*pi*fc*[0:length(s_base)-1].'+rand*2*pi));%Generate PSK modualted signal
    noise=sqrt(1/10^(SNR/10)/2)*(randn(size(s_base))+1j*randn(size(s_base)));%Generate noise signal
        
    y=y_x+noise; %% 产生中频发射信号

    %%%%%%-----干扰----------------%%%%%%%%%%%%%%%%

    t = 0:length(s_base)-1;
    % 单音干扰
%     f = fc;% + ((1+a) * fd) * 0.5;
%     y = y + interference_signal(f, t, 10, 1);
    % 多音干扰
    f_muti = [fc + ((1+a) * fd) * 0.45, fc + ((1+a) * fd) * 0.55];
    y = y + interference_signal(f_muti, t, 10, 1);
   
    %%%%%%%-----解调过程------------%%%%%%%%%%%%%%%%
    y_r=y.*exp(-1j*(2*pi*fc*[0:length(s_base)-1].'));  %%% 频谱搬移到基带
    s_r=conv(y_r,h_r.');  %% 匹配接收
    s_r=s_r(2*delay*r+1:r:2*delay*r+N*r); %%% 抽取，无ISI
    
    s_est=pskdemod(s_r(2:end)./s_r(1:end-1),M); %% 解调（点除消除相位模糊，类似差分）
    s_true=pskdemod(s_mod(2:end)./s_mod(1:end-1),M); %%实际发送的符号（点除消除相位模糊，类似差分）

    rate(m,k)=length(find(s_est(1:length(s_true))~=s_true))/length(s_true); %%% 误符号率
end
Rate(m)=mean(rate(m,:));

Rate_theo(m)=erfc(sqrt(2*(10^(EsN0/10)))*sin(pi/(2*M))); %%% 差分解调理论误符号率

end

figure
semilogy(EbN0_v,Rate,'b-*')      %% 画图比较
hold on,semilogy(EbN0_v,Rate_theo,'r-d')
grid on;
title('single interference & QPSK & JSR = 10')
legend('仿真误码率','理论误码率');
xlabel('EbN0/dB');
ylabel('Bit error rate');
% 
% figure
% plot(EbN0_v,Rate)      %% 画图比较
% hold on,plot(EbN0_v,Rate_theo,'r')
% grid on;