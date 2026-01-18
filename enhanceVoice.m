% ENHANCEVOICE 人声增强
% 1.Function of this function
%     读取音频文件的时域采样数据及采样率，基于FFT增强人声，并返回增强后的时域采样数据及采样率
% 2.Input parameters
%     audioData:原始时域采样数据矩阵（单通道1维；双通道2维已在外部处理为单通道）
%     Fs:原始采样率（单位：Hz）
% 3.Output parameters
%     enhancedAudio:处理后的时域采样数据矩阵（1维）
%     Fs:采样率（单位：Hz）
% 4.Examples
%     Inputs:
%     filename = fullfile(folder, 'audio.mp3');
%     [audioData, Fs] = audioread(filename);
%     [enhancedAudio, Fs] = enhanceVoice(audioData, Fs);
%     Results:
%     return enhancedAudio, Fs
% --------------Implementation goes here---------------------
function [enhancedAudio, Fs] = enhanceVoice(audioData, Fs)
    % 参数设置
    lowCut = 300; % 人声低频截止
    highCut = 2500; % 人声高频截止
    transitionWidth = 100; % 过渡带宽度
    frameSize = 2048; % 帧长
    overlap = 0.75; % 重叠率
    
    % 分帧处理
    hopSize = round(frameSize * (1 - overlap));
    numFrames = floor((size(audioData, 1) - frameSize) / hopSize) + 1;
    window = hamming(frameSize);
    
    % 初始化
    enhancedAudio = zeros(size(audioData)); % 初始化为0向量
    noiseSpectrum = zeros(frameSize, 1);
    
    for channel = 1:size(audioData, 2)
        for i = 1:numFrames
            % 分帧加窗
            startIdx = (i-1) * hopSize + 1;
            frame = audioData(startIdx:startIdx+frameSize-1, channel) .* window;
            
            % FFT及频率轴
            spectrum = fft(frame);
            freq = (0:frameSize-1) * (Fs / frameSize);
            
            % 设计渐变滤波器
            mask = zeros(size(freq));
            for k = 1:length(freq)
                if freq(k) >= lowCut && freq(k) <= highCut
                    mask(k) = 1;
                elseif freq(k) > highCut && freq(k) < highCut + transitionWidth
                    mask(k) = 0.5 * (1 + cos(pi * (freq(k) - highCut) / transitionWidth));
                elseif freq(k) < lowCut && freq(k) > lowCut - transitionWidth
                    mask(k) = 0.5 * (1 + cos(pi * (lowCut - freq(k)) / transitionWidth));
                end
            end
            mask = mask | flip(mask);
            
            % 噪声估计（前5帧为噪声样本）
            if i <= 5
                noiseSpectrum = 0.8 * noiseSpectrum + 0.2 * abs(spectrum);
                filteredSpectrum = spectrum .* mask';
            else
                % 谱减法 + 频段增强
                enhancedMagnitude = max(abs(spectrum) - 0.3 * noiseSpectrum, 0);
                filteredSpectrum = enhancedMagnitude .* mask' .* exp(1i * angle(spectrum));
            end
            
            % 逆FFT并重叠相加
            filteredFrame = real(ifft(filteredSpectrum));
            enhancedAudio(startIdx:startIdx+frameSize-1, channel) = ...
                enhancedAudio(startIdx:startIdx+frameSize-1, channel) + filteredFrame;
        end
    end
    
    % 归一化
    enhancedAudio = enhancedAudio / max(abs(enhancedAudio(:)));
end