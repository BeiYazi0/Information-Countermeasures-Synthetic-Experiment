function s1 = pulse_compression(st)
ht = conj( fliplr(st) ); %时域匹配滤波为发射信号时间反褶再取共轭
s1 = conv(st,ht); %线性调频信号经过匹配滤波器后的输出(时域卷积)
end