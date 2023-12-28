function fc = get_fc_1(signal, type)
if type == 1
    fc = ASK_signal_fc(signal);
end
if type == 2
    fc = FSK_signal_fc(signal);
end
if type == 3
    fc = BPSK_signal_fc(signal);
end
if type == 4
    fc = QPSK_signal_fc(signal);
end
end

function fc = ASK_signal_fc(signal)
N = length(signal);
FF = linspace(0, 1, N);
y_fft = abs(fft(signal));
[~, idx] = max(y_fft);
fc = FF(idx);
end

function fc = FSK_signal_fc(signal)
N = length(signal);
FF = linspace(0, 1, N);
y_fft = abs(fft(signal));
idx = find(y_fft > 0.75 * max(y_fft));
fc = sum(FF(idx))/length(idx);
end

function fc = BPSK_signal_fc(signal)
N = length(signal);
FF = linspace(0, 1, N);
signal_2 = signal.^2;
y_fft_2 = abs(fft(signal_2 -mean(signal_2)));
[~, idx] = max(y_fft_2);
fc = FF(idx)/2;
end

function fc = QPSK_signal_fc(signal)
N = length(signal);
FF = linspace(0, 1, N); 
signal_4 = signal.^4;
y_fft_4 = abs(fft(signal_4 -mean(signal_4)));
[~, idx] = max(y_fft_4);
fc = FF(idx)/4;
end