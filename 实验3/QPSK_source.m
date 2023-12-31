function y = QPSK_source(SNR)
%%----参数设定---------%%
    M = 4;
    N=500; %%% 符号个数（信号时间长度与符号速率相乘即为符号个数）
    fs=1;%采样频率
    fd=0.1;%符号速率
    fc=0.2; %% 载频
    r=fs/fd;%%% 过采样率
    filtorder = 60; % 成型滤波器阶数
    a=0.35; %% 滚降滤波器系数
    delay = filtorder/(r*2); % 群延迟Group delay (# of input samples)
    h=rcosfir(a, delay, r,1,'sqrt');%%% 产生滤波器系数。采用根升余弦滤波器，使得匹配接收后为升余弦滤波器，从而避免ISI;
    h=sqrt(r)*h/norm(h); %%% 归一化滤波器系数，使经过成型滤波后的信号功率为1

%-------------------产生信号-----------------------%

   %-----产生符号与映射-----%
    s=randsrc(N,1,[0:M-1]);
    s_mod=pskmod(s,M);    
    
%-----过采样及成型滤波-----% 
   %-----过采样与矩形波形-----%
%     s_base=rectpulse(s_mod,r);%% 该行程序是产生矩形波形的基带信号

%---根升余弦成型滤波器----% %% 这三行程序是表示过采样，符号1表示成1000（r-1个0，此时r=4）
    s_base=zeros(r,N);%% N个符号，每个符号r个采样点
    s_base(1,:)=s_mod.';%% 第1行表示原有N个符号
    s_base=s_base(:);%% 把rXN矩阵转换成rNX1列向量    
    s_base=conv(h.',s_base);%%符号序列与根升余弦器卷积，实现波形成型
    %% var(s_base) %%接近1，信号功率已经归一化为1
    
% %     s_base=s_base(delay*r+1:end);%%去掉开始的群延迟部分

   %----载波调制-------%
    theta=rand*2*pi;%% 载波的初始相位，在（0，2pi）之间均匀变化
    y_x=s_base.*exp(1j*(2*pi*fc/fs*[0:length(s_base)-1].'+theta));%Generate PSK modualted signal 不含噪声
    
   %---产生复高斯白噪声---%
    noise=sqrt(1/10^(SNR/10)/2)*(randn(size(s_base))+j*randn(size(s_base)));%Generate complex noise signal
    
   %----- 产生含噪声的发射信号 ---%    
    y=y_x+noise; 


