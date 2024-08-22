% Created by E.Silva 14/08/24
clc; clear;

root = 'C:\Users\Usuario\Documents\GitHub\ViconMatlab\Paper4. Chaffin/DataEMG/';
path = dir(root);

Muscle1 = [];
Muscle2 = [];
Muscle3 = [];
Muscle4 = [];
Muscle5 = [];
Muscle6 = [];

for i=3:length(path)

    targetPath = path(i).name;
    f = fullfile(root , targetPath , 'taskData.mat');
    disp(['loading subject ',targetPath]);
    load(f);

    % Target muscles Condition 1 (task2) (mV)
    m1c1 = C01_T6_deltAnt*1000;
    m2c1 = C01_T6_deltMed*1000;
    m3c1 = C01_T6_trapSup*1000;
    m4c1 = C01_T6_trapMed*1000;
    m5c1 = C01_T6_trapInf*1000;
    m6c1 = C01_T6_serrAnt*1000;

    % Target muscles Condition 2 (task2) (mV)
    m1c2 = C02_T6_deltAnt*1000;
    m2c2 = C02_T6_deltMed*1000;
    m3c2 = C02_T6_trapSup*1000;
    m4c2 = C02_T6_trapMed*1000;
    m5c2 = C02_T6_trapInf*1000;
    m6c2 = C02_T6_serrAnt*1000;


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

Columns = { 'M1SlopeC1','M1SlopeC2',...
            'M2SlopeC1','M2SlopeC2',...
            'M3SlopeC1','M3SlopeC2',...
            'M4SlopeC1','M4SlopeC2',...
            'M5SlopeC1','M5SlopeC2',...
            'M6SlopeC1','M6SlopeC2'};
T1 = table( Muscle1(:,1),Muscle1(:,2),...
            Muscle2(:,1),Muscle2(:,2),...
            Muscle3(:,1),Muscle3(:,2),...
            Muscle4(:,1),Muscle4(:,2),...
            Muscle5(:,1),Muscle5(:,2),...
            Muscle6(:,1),Muscle6(:,2),...
            'VariableNames',Columns);

writetable(T1,'FatigueDynamic6.xlsx');

disp('all done')

function [out] = mFreq(input1, input2)
Fs = 2000; %sample freq
Fn = Fs/2; %nyquist freq
Fc = 20;

% 4th order butterworth band-pass
[b, a] = butter(2,Fc*1.25/Fn,"low");
input1 = filtfilt(b,a,input1);
input2 = filtfilt(b,a,input2);

window_length = 0.25;  % Window length in seconds
window_samples = round(window_length * Fs);  % Convert to number of samples
overlap = 0.5;  % 50% overlap
overlap_samples = round(overlap * window_samples);


% Initialize the array for storing IMNF values
num_windows1 = floor((length(input1) - overlap_samples) / (window_samples - overlap_samples));
imnf1 = zeros(1, num_windows1);
num_windows2 = floor((length(input2) - overlap_samples) / (window_samples - overlap_samples));
imnf2 = zeros(1, num_windows2);

time_vector1 = (0:num_windows1-1) * (window_samples - overlap_samples) / Fs;
time_vector2 = (0:num_windows2-1) * (window_samples - overlap_samples) / Fs;

% Perform the segmentation and IMNF calculation
for i = 1:num_windows1
    start_idx = (i - 1) * (window_samples - overlap_samples) + 1;
    end_idx = start_idx + window_samples - 1;
    segment = input1(start_idx:end_idx);

    % Compute the power spectral density (PSD)
    [pxx, f] = pwelch(segment, [], [], [], Fs);

    % Compute the mean frequency for this segment
    imnf1(i) = sum(f .* pxx) / sum(pxx);
end

for i = 1:num_windows2
    start_idx = (i - 1) * (window_samples - overlap_samples) + 1;
    end_idx = start_idx + window_samples - 1;
    segment = input2(start_idx:end_idx);

    [pxx, f] = pwelch(segment, [], [], [], Fs);

    imnf2(i) = sum(f .* pxx) / sum(pxx);
end

slope1 = polyfit(time_vector1, imnf1, 1);
slope2 = polyfit(time_vector2, imnf2, 1);

out = [slope1(1), slope2(1)];

end