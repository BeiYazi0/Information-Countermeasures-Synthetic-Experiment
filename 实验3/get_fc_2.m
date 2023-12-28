function fc = get_fc_2(signal, fs)
N = length(signal);
y_fft = abs(fft(signal))/N*2;

idx = find(y_fft > max(y_fft)/2); % 3dB 带宽谱线
spectrum_3db = y_fft(idx);            % 3dB 带宽谱值
l = sum(idx.*spectrum_3db)/sum(spectrum_3db); % 3dB 带宽重心

fc = (l - 1) * fs/N;
end