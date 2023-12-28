clear all;clc;close all;

%%----�����趨---------%%
M=4; %% M=4��PSK
N=500; %%% ���Ÿ������ź�ʱ�䳤�������������˼�Ϊ���Ÿ�����
fs=1;%����Ƶ��
fd=0.1;%��������
fc=0.3; %% ��Ƶ
r=fs/fd;%%% ��������
filtorder = 60; % �����˲�������
a=0.35; %% �����˲���ϵ��
delay = filtorder/(r*2); % Ⱥ�ӳ�Group delay (# of input samples)
h=rcosfir(a, delay, r,1,'sqrt');%%% �����˲���ϵ�������ø��������˲�����ʹ��ƥ����պ�Ϊ�������˲������Ӷ�����ISI;
h=sqrt(r)*h/norm(h); %%% ��һ���˲���ϵ����ʹ���������˲�����źŹ���Ϊ1
SNR=10;%% ��λdB,�����

%-------------------�����ź�-----------------------%

   %-----����������ӳ��-----%
    s=randsrc(N,1,[0:M-1]);
    s_mod=pskmod(s,M);    
    scatterplot(s_mod);%�۲�����ź�����ͼ
    
%-----�������������˲�-----% 
   %-----����������β���-----%
%     s_base=rectpulse(s_mod,r);%% ���г����ǲ������β��εĻ����ź�

%---�������ҳ����˲���----% %% �����г����Ǳ�ʾ������������1��ʾ��1000��r-1��0����ʱr=4��
    s_base=zeros(r,N);%% N�����ţ�ÿ������r��������
    s_base(1,:)=s_mod.';%% ��1�б�ʾԭ��N������
    s_base=s_base(:);%% ��rXN����ת����rNX1������    
    s_base=conv(h.',s_base);%%������������������������ʵ�ֲ��γ���
    %% var(s_base) %%�ӽ�1���źŹ����Ѿ���һ��Ϊ1
    
% %     s_base=s_base(delay*r+1:end);%%ȥ����ʼ��Ⱥ�ӳٲ���
    
    scatterplot(s_base);%�۲�����˲����ɢ��ͼ
   %----�ز�����-------%
    theta=rand*2*pi;%% �ز��ĳ�ʼ��λ���ڣ�0��2pi��֮����ȱ仯
    y_x=s_base.*exp(1j*(2*pi*fc/fs*[0:length(s_base)-1].'+theta));%Generate PSK modualted signal ��������
    scatterplot(y_x);%�۲��ز����ƺ��ɢ��ͼ
   %---��������˹������---%
    noise=sqrt(1/10^(SNR/10)/2)*(randn(size(s_base))+j*randn(size(s_base)));%Generate complex noise signal
    
   %----- �����������ķ����ź� ---%    
    y=y_x+noise; 


%-------------��ͼ-------------------%
figure;%%��200�������㳤�ȵ����벨��ͼ,ʵ���鲿�ֱ𻭣����ȿ����б仯
NT=200;
subplot(2,1,1);plot(real(y_x(1:NT)));title('passband signal of square root raised cosine pulse shaped in time domain');xlabel('sample');ylabel('In amplitude');
subplot(2,1,2);plot(imag(y_x(1:NT)));title('passband signal of square root raised cosine pulse shaped in time domain');xlabel('sample');ylabel('Qn amplitude');

figure;%%������Ƶ��ͼ
NN2=length(y);
FF2=linspace(-fs/2,fs/2,NN2);%% Ƶ�׹۲췶ΧΪ-fs/2~fs/2֮��
YF_yc=abs(fft(y));
plot(FF2,fftshift(YF_yc));title('passband signal of pulse shaped in frequency domain');xlabel('normalized frequency');ylabel('amplitude');


figure;%%�������Ĵη�Ƶ��ͼ
NN2=length(y);
FF2=linspace(-fs/2,fs/2,NN2);
YF_yc=abs(fft(y.^4-mean(y.^4)));%% �ź��Ĵη�������������ֱ���������ʼ�ȥֱ��
plot(FF2,fftshift(YF_yc));title('�Ĵη���');xlabel('nomalized frequency');ylabel('amplitude');



