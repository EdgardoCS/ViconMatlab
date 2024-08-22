% Created by E.Silva 14/08/24
clc; clear;

root = 'C:/Users/Usuario/Documents/GitHub/ViconMatlab/Chaffin/DataEMG/';
path = dir(root);

Muscle1 = [];
Muscle2 = [];
Muscle3 = [];
Muscle4 = [];
Muscle5 = [];
Muscle6 = [];

for i=3:4%length(path)

    targetPath = path(i).name;
    f = fullfile(root , targetPath , 'taskData.mat');
    disp(['loading subject ',targetPath]);
    load(f);

    % Target muscles Condition 1 (task2) (mV)
    m1c1 = C01_T2_deltAnt*1000;
    m2c1 = C01_T2_deltMed*1000;
    m3c1 = C01_T2_trapSup*1000;
    m4c1 = C01_T2_trapMed*1000;
    m5c1 = C01_T2_trapInf*1000;
    m6c1 = C01_T2_serrAnt*1000;

    % Target muscles Condition 2 (task2) (mV)
    m1c2 = C02_T2_deltAnt*1000;
    m2c2 = C02_T2_deltMed*1000;
    m3c2 = C02_T2_trapSup*1000;
    m4c2 = C02_T2_trapMed*1000;
    m5c2 = C02_T2_trapInf*1000;
    m6c2 = C02_T2_serrAnt*1000;

    Muscle1(i,:) = mFreq(m1c1, m1c2);
    Muscle2(i,:) = mFreq(m2c1, m2c2);
    Muscle3(i,:) = mFreq(m3c1, m3c2);
    Muscle4(i,:) = mFreq(m4c1, m4c2);
    Muscle5(i,:) = mFreq(m5c1, m5c2);
    Muscle6(i,:) = mFreq(m6c1, m6c2);


end

Muscle1(1:2,:) = [];
Muscle2(1:2,:) = [];
Muscle3(1:2,:) = [];
Muscle4(1:2,:) = [];
Muscle5(1:2,:) = [];
Muscle6(1:2,:) = [];

clearvars -except Muscle1 Muscle2 Muscle3 Muscle4 Muscle5 Muscle6

Columns = {'M1FrequenciaC1','M1FrequenciaC2',...
    'M2FrequenciaC1','M2FrequenciaC2',...
    'M3FrequenciaC1','M3FrequenciaC2',...
    'M4FrequenciaC1','M4FrequenciaC2',...
    'M5FrequenciaC1','M5FrequenciaC2',...
    'M6FrequenciaC1','M6FrequenciaC2'};
T1 = table(Muscle1(:,1),Muscle1(:,2),...
    Muscle2(:,1),Muscle2(:,2),...
    Muscle3(:,1),Muscle3(:,2),...
    Muscle4(:,1),Muscle4(:,2),...
    Muscle5(:,1),Muscle5(:,2),...
    Muscle6(:,1),Muscle6(:,2),...
     'VariableNames',Columns);

writetable(T1,'Fatiga.xlsx');

function [data] = mFreq(muscle1, muscle2)

Fs = 2000;
% L1 = length(muscle1);
% L1 = int32(L1/2);
% 
% L2 = length(muscle2);
% L2 = int32(L2/5);
% 
% win1 = muscle1(1:L1);
% win2 = muscle1(end-L1:end);
% 
% win3 = muscle2(1:L2);
% win4 = muscle2(end-L2:end);


f1 = fft(muscle1);
f2 = fft(muscle2);

meanFreq = meanfreq(f1,Fs);
medianFreq = medfreq(f2,Fs);


data = [meanfreq(f1,Fs),meanfreq(f2,Fs)];

end



%{
% Load your EMG signal
emg_signal = load('emg_signal.mat');  % Replace with your data
emg_signal = emg_signal.data;  % Assuming your data is in a variable 'data'

% Define parameters
fs = 1000;  % Sampling frequency in Hz
window_length = 0.25;  % Window length in seconds
window_samples = round(window_length * fs);  % Convert to number of samples
overlap = 0.5;  % 50% overlap
overlap_samples = round(overlap * window_samples);

% High-pass filter to remove motion artifacts (optional)
[b, a] = butter(4, 20 / (fs / 2), 'high');  % 20 Hz cutoff
emg_filtered = filtfilt(b, a, emg_signal);

% Initialize the array for storing IMNF values
num_windows = floor((length(emg_filtered) - overlap_samples) / (window_samples - overlap_samples));
imnf = zeros(1, num_windows);

% Perform the segmentation and IMNF calculation
for i = 1:num_windows
    start_idx = (i - 1) * (window_samples - overlap_samples) + 1;
    end_idx = start_idx + window_samples - 1;
    segment = emg_filtered(start_idx:end_idx);

    % Compute the power spectral density (PSD)
    [pxx, f] = pwelch(segment, [], [], [], fs);

    % Compute the mean frequency for this segment
    imnf(i) = sum(f .* pxx) / sum(pxx);
end

% Time vector for plotting
time_vector = (0:num_windows-1) * (window_samples - overlap_samples) / fs;

% Plot IMNF
figure;
plot(time_vector, imnf);
xlabel('Time (s)');
ylabel('Instantaneous Mean Frequency (Hz)');
title('Instantaneous Mean Frequency Over Time');
grid on;
%}
