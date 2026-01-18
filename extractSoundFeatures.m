% EXTRACTSOUNDFEATURES 从声音信号中提取特征
% 1.Function of this function
%     读取音频文件的时域采样数据及采样率，读入事件检测阈值，基于FFT进行特征分析，并返回特征结构体
% 2.Input parameters
%     soundData:声音信号数据向量
%     fs:采样率(Hz)
%     threshold:高音量事件检测阈值
% 3.Output parameters
%     features:包含特征的结构体
% 4.Examples
%     Inputs:
%     filename = fullfile(folder, 'audio.mp3');
%     [soundData, fs] = audioread(filename);
%     threshold = 560;
%     features = extractSoundFeatures(soundData, fs, threshold)
%     Results:
%     return features
% --------------Implementation goes here---------------------
function features = extractSoundFeatures(soundData, fs, threshold)
    % 基本统计特征
    features.mean = mean(soundData);
    features.max = max(soundData);
    features.min = min(soundData);
    features.std = std(soundData);
    
    % 频谱分析
    N = length(soundData);
    if N > 1
        fftResult = fft(soundData - mean(soundData)); % 去除直流分量
        magnitude = abs(fftResult(1:floor(N/2)));    % 取单边频谱
        f = linspace(0, fs/2, floor(N/2));
        
        [~, idx] = max(magnitude);
        features.dominantFreq = f(idx);              % 主频率
        features.spectralCentroid = sum(f.*magnitude)/sum(magnitude); % 频谱质心
    else
        features.dominantFreq = 0;
        features.spectralCentroid = 0;
    end
    
    % 事件检测
    features.eventDetected = any(soundData > threshold);
    features.peakCount = sum(soundData > threshold);
    
    % 时域特征
    features.zcr = sum(diff(sign(soundData - mean(soundData))) ~= 0)/N; % 过零率
end