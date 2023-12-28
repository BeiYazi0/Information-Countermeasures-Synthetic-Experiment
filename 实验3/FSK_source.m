function y = FSK_source(M, SNR)
%%----�����趨---------%%
    N=500; %%% ���Ÿ������ź�ʱ�䳤�������������˼�Ϊ���Ÿ�����
    fs=1;%����Ƶ��
    fd=0.1;%��������
    fc0=0.29; %% ��Ƶ
    fc1 = 0.31; %% ��Ƶ
    r=fs/fd;%%% ��������
    filtorder = 60; % �����˲�������
    a=0.35; %% �����˲���ϵ��
    delay = filtorder/(r*2); % Ⱥ�ӳ�Group delay (# of input samples)
    h=rcosfir(a, delay, r,1,'sqrt');%%% �����˲���ϵ�������ø��������˲�����ʹ��ƥ����պ�Ϊ�������˲������Ӷ�����ISI;
    h=sqrt(r)*h/norm(h); %%% ��һ���˲���ϵ����ʹ���������˲�����źŹ���Ϊ1

%-------------------�����ź�-----------------------%

   %-----����������ӳ��-----%
    s=randsrc(N,1,[0:M-1]);
    s_mod=fskmod(s, M, fc1 - fc0, r, fs, 'cont');    
    
%-----�������������˲�-----% 
   %-----����������β���-----%
%     s_base=rectpulse(s_mod,r);%% ���г����ǲ������β��εĻ����ź�

%---�������ҳ����˲���----% %% �����г����Ǳ�ʾ������������1��ʾ��1000��r-1��0����ʱr=4��
    %s_base=zeros(r,N);%% N�����ţ�ÿ������r��������
    %s_base(1,:)=s_mod.';%% ��1�б�ʾԭ��N������
    s_base=s_mod;%% ��rXN����ת����rNX1������    
    s_base=conv(h.',s_base);%%������������������������ʵ�ֲ��γ���
    %% var(s_base) %%�ӽ�1���źŹ����Ѿ���һ��Ϊ1
    
    s_base=s_base(delay*r+1:end);%%ȥ����ʼ��Ⱥ�ӳٲ���

   %----�ز�����-------%
    theta=rand*2*pi;%% �ز��ĳ�ʼ��λ���ڣ�0��2pi��֮����ȱ仯
    s_a = [repelem(s, r); zeros(length(s_base) - N*r, 1)];
    phase = (s_a == 0).*exp(1j*(2*pi*fc0/fs*[0:length(s_base)-1].'+theta)) + (s_a == 1).*exp(1j*(2*pi*fc1/fs*[0:length(s_base)-1].'+theta));
    y_x=s_base.*phase;%Generate PSK modualted signal ��������
   %---��������˹������---%
    noise=sqrt(1/10^(SNR/10)/2)*(randn(size(s_base))+j*randn(size(s_base)));%Generate complex noise signal
    
   %----- �����������ķ����ź� ---%    
    y=y_x+noise; 


