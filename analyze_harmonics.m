% ANALYZE_HARMONICS 通过MATLAB App Designer的UIAxes绘制谐波结构
% 1.Function of this function
%     读取音频文件，计算频谱并提取谐波信息，并在指定的UIAxes上绘制谐波结构
% 2.Input parameters
%     filename:文件名
%     app:传入MATLAB App对象
% 3.Output parameters
%     无
% 4.Examples
%     Inputs:
%     filename = fullfile(folder, 'audio.mp3');
%     analyze_harmonics(filename, app);
%     Results:
%     None (plot images in UIAxes)
% --------------Implementation goes here---------------------
function analyze_harmonics(filename, app)    
    % 读取音频
    [sample, fs] = audioread(filename);

    % 确定分析的音频时长（前2分钟）
    max_duration = 2 * 60;  % 前2分钟
    num_samples = min(max_duration * fs, length(sample));  % 截取前2分钟或整个音频
    
    x = sample(1:num_samples);  % 截取前2分钟的音频
    
    app.player2 = audioplayer(sample, fs);
    play(app.player2);

    if size(x, 2) == 2
        x = mean(x, 2); % 将立体声信号转换为单声道
    end
    
    % 计算FFT
    N = length(x);  % 信号长度
    X = fft(x);  % 进行傅里叶变换
    f = (0:N-1) * (fs/N);  % 频率向量
    
    % 提取谐波，增加MinPeakHeight和MinPeakDistance来减少密集的谱线
    [pks, locs] = findpeaks(abs(X(1:N/2)), 'MinPeakHeight', 0.05, 'MinPeakDistance', 50);
    
    % 确保locs是整数
    locs = round(locs);  % 将locs转换为整数索引
    
    harmonic_freqs = f(locs);  % 谐波频率
    harmonic_mags = pks;  % 谐波幅值
    
    % 限制频率范围显示（例如0-2000 Hz）
    freq_range = [0, 2000];
    xlim(app.UIAxes_musicInstrument, freq_range);
    
    % 绘制谐波结构（使用stem图，保留对数坐标）
    stem(app.UIAxes_musicInstrument, harmonic_freqs, harmonic_mags, 'filled');
    set(app.UIAxes_musicInstrument, 'XScale', 'log');  % 设置x轴为对数坐标
    xlabel(app.UIAxes_musicInstrument, 'Frequency (Hz)');
    ylabel(app.UIAxes_musicInstrument, 'Magnitude');
    if app.language == "CH"
        title(app.UIAxes_musicInstrument, '谐波结构');
    else
        title(app.UIAxes_musicInstrument, 'Harmonic Structure');
    end
    grid(app.UIAxes_musicInstrument, 'on');
end