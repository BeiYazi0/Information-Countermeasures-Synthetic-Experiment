clear all;clc;close all;

%%----�����趨---------%%
M=4; %% M=4��PSK
N=500; %%% ���Ÿ������ź�ʱ�䳤�������������˼�Ϊ���Ÿ�����
fs=1;%����Ƶ��
fd=0.1;%��������
fc=0.3; %% ��Ƶ
r=fs/fd;%%% ��������
filtorder = 60; % Filter order
a=0.35; %% �����˲���ϵ��
delay = filtorder/(r*2); % Ⱥ�ӳ�Group delay (# of input samples)
h=rcosfir(a, delay, r,1,'sqrt');%%% �����˲���ϵ�������ø��������˲�����ʹ��ƥ����պ�Ϊ�������˲������Ӷ�����ISI;
h=sqrt(r)*h/norm(h); %%% ��һ���˲���ϵ����ʹ���������˲�����źŹ���Ϊ1

% fs=1;%����Ƶ��
% fd=0.25;%��������
% fc=0.3; %% ��Ƶ
% r=fs/fd;%%% ��������
% M=2; %% MPSK
% N=200; %%% ���Ÿ���
% a=0.35; %% �����˲���ϵ��
% delay=3; %% �ӳ�
% h=rcosfir(a, delay, r,1,'sqrt');%%% ���ø��������˲�����ʹ��ƥ����պ�Ϊ�������˲������Ӷ�����ISI;
% h=sqrt(r)*h/norm(h); %%% ��һ���˲���ϵ��

EbN0_v=[3:10]; %�����
h_r=h(end:-1:1); %%% ���ն�ƥ���˲���������������λ�Գƣ��ɲ���Ҫ
K=1000; %% ���������

for m=1:length(EbN0_v)
    EbN0=EbN0_v(m);
    EsN0=EbN0+10*log10(log2(M));
    SNR=EsN0-10*log10(r);%����Ƶ�ʷ�Χ�ڵ������ 
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
        
    y=y_x+noise; %% ������Ƶ�����ź�

    %%%%%%-----����----------------%%%%%%%%%%%%%%%%

    t = 0:length(s_base)-1;
    % ��������
%     f = fc;% + ((1+a) * fd) * 0.5;
%     y = y + interference_signal(f, t, 10, 1);
    % ��������
    f_muti = [fc + ((1+a) * fd) * 0.45, fc + ((1+a) * fd) * 0.55];
    y = y + interference_signal(f_muti, t, 10, 1);
   
    %%%%%%%-----�������------------%%%%%%%%%%%%%%%%
    y_r=y.*exp(-1j*(2*pi*fc*[0:length(s_base)-1].'));  %%% Ƶ�װ��Ƶ�����
    s_r=conv(y_r,h_r.');  %% ƥ�����
    s_r=s_r(2*delay*r+1:r:2*delay*r+N*r); %%% ��ȡ����ISI
    
    s_est=pskdemod(s_r(2:end)./s_r(1:end-1),M); %% ��������������λģ�������Ʋ�֣�
    s_true=pskdemod(s_mod(2:end)./s_mod(1:end-1),M); %%ʵ�ʷ��͵ķ��ţ����������λģ�������Ʋ�֣�

    rate(m,k)=length(find(s_est(1:length(s_true))~=s_true))/length(s_true); %%% �������
end
Rate(m)=mean(rate(m,:));

Rate_theo(m)=erfc(sqrt(2*(10^(EsN0/10)))*sin(pi/(2*M))); %%% ��ֽ�������������

end

figure
semilogy(EbN0_v,Rate,'b-*')      %% ��ͼ�Ƚ�
hold on,semilogy(EbN0_v,Rate_theo,'r-d')
grid on;
title('single interference & QPSK & JSR = 10')
legend('����������','����������');
xlabel('EbN0/dB');
ylabel('Bit error rate');
% 
% figure
% plot(EbN0_v,Rate)      %% ��ͼ�Ƚ�
% hold on,plot(EbN0_v,Rate_theo,'r')
% grid on;