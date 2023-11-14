% Created by E.Silva
% Modified by E.Silva 23/10/23

clc; clear;

s = '1';
s = ['1', '2', '3', '4', '5', '6', '7'];

% kinematic variables
eBRom = [];
eBTime = [];
eBRomSpirometry = [];
eBTimeSpirometry = [];
iBRom = [];
iBTime = [];
iBRomSpirometry = [];
iBTimeSpirometry = [];

ePRom = [];
ePTime = [];
ePRomSpirometry = [];
ePTimeSpirometry = [];
iPRom = [];
iPTime = [];
iPRomSpirometry = [];
iPTimeSpirometry = [];

eTRom = [];
eTTime = [];
eTRomSpirometry = [];
eTTimeSpirometry = [];
iTRom = [];
iTTime = [];
iTRomSpirometry = [];
iTTimeSpirometry = [];

% Biomechanics variables
eBEcomI = [];
eBEcomD = [];
eBPectI = [];
eBPectD = [];
eBAbdI = [];
eBAbdD = [];

eBEcomIS = [];
eBEcomDS = [];
eBPectIS = [];
eBPectDS = [];
eBAbdIS = [];
eBAbdDS = [];

iBEcomI = [];
iBEcomD = [];
iBPectI = [];
iBPectD = [];
iBAbdI = [];
iBAbdD = [];

iBEcomIS = [];
iBEcomDS = [];
iBPectIS = [];
iBPectDS = [];
iBAbdIS = [];
iBAbdDS = [];

ePEcomI = [];
ePEcomD = [];
ePPectI = [];
ePPectD = [];
ePAbdI = [];
ePAbdD = [];

ePEcomIS = [];
ePEcomDS = [];
ePPectIS = [];
ePPectDS = [];
ePAbdIS = [];
ePAbdDS = [];

iPEcomI = [];
iPEcomD = [];
iPPectI = [];
iPPectD = [];
iPAbdI = [];
iPAbdD = [];

iPEcomIS = [];
iPEcomDS = [];
iPPectIS = [];
iPPectDS = [];
iPAbdIS = [];
iPAbdDS = [];

eTEcomI = [];
eTEcomD = [];
eTPectI = [];
eTPectD = [];
eTAbdI = [];
eTAbdD = [];

eTEcomIS = [];
eTEcomDS = [];
eTPectIS = [];
eTPectDS = [];
eTAbdIS = [];
eTAbdDS = [];

iTEcomI = [];
iTEcomD = [];
iTPectI = [];
iTPectD = [];
iTAbdI = [];
iTAbdD = [];

iTEcomIS = [];
iTEcomDS = [];
iTPectIS = [];
iTPectDS = [];
iTAbdIS = [];
iTAbdDS = [];

disp ('calculating...')
for t = 1:length(s)

    targetData = join(['data\sujeto', s(t),'.mat'],'');
    load(targetData);

    disp(targetData)

    nNames = fieldnames(peaks);

    emgBasalActivity1 = mean([mean(emgrms.EB1(:,1)), mean(emgrms.EB2(:,1)), mean(emgrms.EB3(:,1))]);
    emgBasalActivity2 = mean([mean(emgrms.EB1(:,2)), mean(emgrms.EB2(:,2)), mean(emgrms.EB3(:,2))]);
    emgBasalActivity3 = mean([mean(emgrms.EB1(:,3)), mean(emgrms.EB2(:,3)), mean(emgrms.EB3(:,3))]);
    emgBasalActivity4 = mean([mean(emgrms.EB1(:,4)), mean(emgrms.EB2(:,4)), mean(emgrms.EB3(:,4))]);
    emgBasalActivity5 = mean([mean(emgrms.EB1(:,5)), mean(emgrms.EB2(:,5)), mean(emgrms.EB3(:,5))]);
    emgBasalActivity6 = mean([mean(emgrms.EB1(:,6)), mean(emgrms.EB2(:,6)), mean(emgrms.EB3(:,6))]);

    basalActivity = [emgBasalActivity1, emgBasalActivity2, emgBasalActivity3, emgBasalActivity4, emgBasalActivity5, emgBasalActivity6];

    % Calculations for Basal Activity
    A = [];  % ROM
    B = [];  % TIME
    C = [];  % ROM Spirometry
    D = [];  % TIME Spirometry
    E = [];  % ROM
    F = [];  % TIME
    G = [];  % ROM Spirometry
    H = [];  % TIME Spirometry

    M1L = [];  % ecom izq
    M1R = [];  % ecom der
    M2L = [];  % pect izq
    M2R = [];  % pect der
    M3L = [];  % abdm izq
    M3R = [];  % abdm der

    M4L = [];  % ecom izq
    M4R = [];  % ecom der
    M5L = [];  % pect izq
    M5R = [];  % pect der
    M6L = [];  % abdm izq
    M6R = [];  % abdm der

    sM1L = [];  % ecom izq Spirometry
    sM1R = [];  % ecom der Spirometry
    sM2L = [];  % pect izq Spirometry
    sM2R = [];  % pect der Spirometry
    sM3L = [];  % abdm izq Spirometry
    sM3R = [];  % abdm der Spirometry

    sM4L = [];  % ecom izq Spirometry
    sM4R = [];  % ecom der Spirometry
    sM5L = [];  % pect izq Spirometry
    sM5R = [];  % pect der Spirometry
    sM6L = [];  % abdm izq Spirometry
    sM6R = [];  % abdm der Spirometry

    for i = 1:3
        dataPeaks = peaks.(nNames{i});
        dataemg = emgrms.(nNames{i});
        [A(i,:), B(i,:), C(i,:), D(i,:)] = eExtractRom(dataPeaks);
        [E(i,:), F(i,:), G(i,:), H(i,:)] = iExtractRom(dataPeaks);
        [M1L(i,:), M1R(i,:), M2L(i,:), M2R(i,:), M3L(i,:), M3R(i,:)] = eCalculateRms(dataPeaks,basalActivity, dataemg);
        [M4L(i,:), M4R(i,:), M5L(i,:), M5R(i,:), M6L(i,:), M6R(i,:)] = iCalculateRms(dataPeaks,basalActivity, dataemg);
        [sM1L(i,:), sM1R(i,:), sM2L(i,:), sM2R(i,:), sM3L(i,:), sM3R(i,:)] = eCalculateRmsS(dataPeaks,basalActivity, dataemg);
        [sM4L(i,:), sM4R(i,:), sM5L(i,:), sM5R(i,:), sM6L(i,:), sM6R(i,:)] = iCalculateRmsS(dataPeaks,basalActivity, dataemg);

    end

    eBRom = [eBRom, A];
    eBTime = [eBTime, B];
    eBRomSpirometry = [eBRomSpirometry, C];
    eBTimeSpirometry = [eBTimeSpirometry, D];

    iBRom = [iBRom, E];
    iBTime = [iBTime, F];
    iBRomSpirometry = [iBRomSpirometry, G];
    iBTimeSpirometry = [iBTimeSpirometry, H];

    eBEcomI = [eBEcomI,M1L];
    eBEcomD = [eBEcomD,M1R];
    eBPectI = [eBPectI,M2L];
    eBPectD = [eBPectD,M2R];
    eBAbdI = [eBAbdI, M3L];
    eBAbdD = [eBAbdD, M3R];

    eBEcomIS = [eBEcomIS,sM1L];
    eBEcomDS = [eBEcomDS,sM1R];
    eBPectIS = [eBPectIS,sM2L];
    eBPectDS = [eBPectDS,sM2R];
    eBAbdIS = [eBAbdIS,sM3L];
    eBAbdDS = [eBAbdDS,sM3R];


    iBEcomI = [iBEcomI,M4L];
    iBEcomD = [iBEcomD,M4R];
    iBPectI = [iBPectI,M5L];
    iBPectD = [iBPectD,M5R];
    iBAbdI = [iBAbdI,M6L];
    iBAbdD = [iBAbdD,M6R];

    iBEcomIS = [iBEcomIS,sM4L];
    iBEcomDS = [iBEcomDS,sM4R];
    iBPectIS = [iBPectIS,sM5L];
    iBPectDS = [iBPectDS,sM5R];
    iBAbdIS = [iBAbdIS,sM6L];
    iBAbdDS = [iBAbdDS,sM6R];

    % Calculations for Pre Therapep Spirometry Activity
    A = [];  % ROM
    B = [];  % TIME
    C = [];  % ROM Spirometry
    D = [];  % TIME Spirometry
    E = [];  % ROM
    F = [];  % TIME
    G = [];  % ROM Spirometry
    H = [];  % TIME Spirometry

    M1L = [];  % ecom izq
    M1R = [];  % ecom der
    M2L = [];  % pect izq
    M2R = [];  % pect der
    M3L = [];  % abdm izq
    M3R = [];  % abdm der

    M4L = [];  % ecom izq
    M4R = [];  % ecom der
    M5L = [];  % pect izq
    M5R = [];  % pect der
    M6L = [];  % abdm izq
    M6R = [];  % abdm der

    sM1L = [];  % ecom izq
    sM1R = [];  % ecom der
    sM2L = [];  % pect izq
    sM2R = [];  % pect der
    sM3L = [];  % abdm izq
    sM3R = [];  % abdm der

    sM4L = [];  % ecom izq
    sM4R = [];  % ecom der
    sM5L = [];  % pect izq
    sM5R = [];  % pect der
    sM6L = [];  % abdm izq
    sM6R = [];  % abdm der

    for i = 4:6

        dataPeaks = peaks.(nNames{i});
        dataemg = emgrms.(nNames{i});
        [A(i-3,:), B(i-3,:), C(i-3,:), D(i-3,:)] = eExtractRom(dataPeaks);
        [E(i-3,:), F(i-3,:), G(i-3,:), H(i-3,:)] = iExtractRom(dataPeaks);
        [M1L(i-3,:), M1R(i-3,:), M2L(i-3,:), M2R(i-3,:), M3L(i-3,:), M3R(i-3,:)] = eCalculateRms(dataPeaks,basalActivity, dataemg);
        [M4L(i-3,:), M4R(i-3,:), M5L(i-3,:), M5R(i-3,:), M6L(i-3,:), M6R(i-3,:)] = iCalculateRms(dataPeaks,basalActivity, dataemg);
        [sM1L(i-3,:), sM1R(i-3,:), sM2L(i-3,:), sM2R(i-3,:), sM3L(i-3,:), sM3R(i-3,:)] = eCalculateRmsS(dataPeaks,basalActivity, dataemg);
        [sM4L(i-3,:), sM4R(i-3,:), sM5L(i-3,:), sM5R(i-3,:), sM6L(i-3,:), sM6R(i-3,:)] = iCalculateRmsS(dataPeaks,basalActivity, dataemg);
    end

    ePRom = [ePRom, A];
    ePTime = [ePTime, B];
    ePRomSpirometry = [ePRomSpirometry, C];
    ePTimeSpirometry = [ePTimeSpirometry, D];

    iPRom = [iPRom, E];
    iPTime = [iPTime, F];
    iPRomSpirometry = [iPRomSpirometry, G];
    iPTimeSpirometry = [iPTimeSpirometry, H];

    ePEcomI = [ePEcomI,M1L];
    ePEcomD = [ePEcomD,M1R];
    ePPectI = [ePPectI,M2L];
    ePPectD = [ePPectD,M2R];
    ePAbdI = [ePAbdI, M3L];
    ePAbdD = [ePAbdD, M3R];

    ePEcomIS = [ePEcomIS,sM1L];
    ePEcomDS = [ePEcomDS,sM1R];
    ePPectIS = [ePPectIS,sM2L];
    ePPectDS = [ePPectDS,sM2R];
    ePAbdIS = [ePAbdIS,sM3L];
    ePAbdDS = [ePAbdDS,sM3R];

    iPEcomI = [iPEcomI,M4L];
    iPEcomD = [iPEcomD,M4R];
    iPPectI = [iPPectI,M5L];
    iPPectD = [iPPectD,M5R];
    iPAbdI = [iPAbdI,M6L];
    iPAbdD = [iPAbdD,M6R];

    iPEcomIS = [iPEcomIS,sM4L];
    iPEcomDS = [iPEcomDS,sM4R];
    iPPectIS = [iPPectIS,sM5L];
    iPPectDS = [iPPectDS,sM5R];
    iPAbdIS = [iPAbdIS,sM6L];
    iPAbdDS = [iPAbdDS,sM6R];

    % Calculations for Post Therapep Spirometry Activity
    A = [];  % ROM
    B = [];  % TIME
    C = [];  % ROM Spirometry
    D = [];  % TIME Spirometry
    E = [];  % ROM
    F = [];  % TIME
    G = [];  % ROM Spirometry
    H = [];  % TIME Spirometry

    M1L = [];  % ecom izq
    M1R = [];  % ecom der
    M2L = [];  % pect izq
    M2R = [];  % pect der
    M3L = [];  % abdm izq
    M3R = [];  % abdm der

    M4L = [];  % ecom izq
    M4R = [];  % ecom der
    M5L = [];  % pect izq
    M5R = [];  % pect der
    M6L = [];  % abdm izq
    M6R = [];  % abdm der

    sM1L = [];  % ecom izq
    sM1R = [];  % ecom der
    sM2L = [];  % pect izq
    sM2R = [];  % pect der
    sM3L = [];  % abdm izq
    sM3R = [];  % abdm der

    sM4L = [];  % ecom izq
    sM4R = [];  % ecom der
    sM5L = [];  % pect izq
    sM5R = [];  % pect der
    sM6L = [];  % abdm izq
    sM6R = [];  % abdm der

    for i = 7:9
        dataPeaks = peaks.(nNames{i});
        dataemg = emgrms.(nNames{i});
        [A(i-6,:), B(i-6,:), C(i-6,:), D(i-6,:)] = eExtractRom(dataPeaks);
        [E(i-6,:), F(i-6,:), G(i-6,:), H(i-6,:)] = iExtractRom(dataPeaks);
        [M1L(i-6,:), M1R(i-6,:), M2L(i-6,:), M2R(i-6,:), M3L(i-6,:), M3R(i-6,:)] = eCalculateRms(dataPeaks,basalActivity, dataemg);
        [M4L(i-6,:), M4R(i-6,:), M5L(i-6,:), M5R(i-6,:), M6L(i-6,:), M6R(i-6,:)] = iCalculateRms(dataPeaks,basalActivity, dataemg);
        [sM1L(i-6,:), sM1R(i-6,:), sM2L(i-6,:), sM2R(i-6,:), sM3L(i-6,:), sM3R(i-6,:)] = eCalculateRmsS(dataPeaks,basalActivity, dataemg);
        [sM4L(i-6,:), sM4R(i-6,:), sM5L(i-6,:), sM5R(i-6,:), sM6L(i-6,:), sM6R(i-6,:)] = iCalculateRmsS(dataPeaks,basalActivity, dataemg);
    end

    eTRom = [eTRom, A];
    eTTime = [eTTime, B];
    eTRomSpirometry = [eTRomSpirometry, C];
    eTTimeSpirometry = [eTTimeSpirometry, D];

    iTRom = [iTRom, E];
    iTTime = [iTTime, F];
    iTRomSpirometry = [iTRomSpirometry, G];
    iTTimeSpirometry = [iTTimeSpirometry, H];

    eTEcomI = [eTEcomI,M1L];
    eTEcomD = [eTEcomD,M1R];
    eTPectI = [eTPectI,M2L];
    eTPectD = [eTPectD,M2R];
    eTAbdI = [eTAbdI, M3L];
    eTAbdD = [eTAbdD, M3R];

    eTEcomIS = [eTEcomIS,sM1L];
    eTEcomDS = [eTEcomDS,sM1R];
    eTPectIS = [eTPectIS,sM2L];
    eTPectDS = [eTPectDS,sM2R];
    eTAbdIS = [eTAbdIS,sM3L];
    eTAbdDS = [eTAbdDS,sM3R];

    iTEcomI = [iTEcomI,M4L];
    iTEcomD = [iTEcomD,M4R];
    iTPectI = [iTPectI,M5L];
    iTPectD = [iTPectD,M5R];
    iTAbdI = [iTAbdI,M6L];
    iTAbdD = [iTAbdD,M6R];

    iTEcomIS = [iTEcomIS,sM4L];
    iTEcomDS = [iTEcomDS,sM4R];
    iTPectIS = [iTPectIS,sM5L];
    iTPectDS = [iTPectDS,sM5R];
    iTAbdIS = [iTAbdIS,sM6L];
    iTAbdDS = [iTAbdDS,sM6R];
end

%reshape for analysis and data export
disp('reshaping...')

% iTTimeSpirometry = reshape(iTTimeSpirometry,[length(s)*3,1])
% iTTime = reshape(iTTime,[length(s)*3,1]);
% iTRomSpirometry = reshape(iTRomSpirometry,[length(s)*3,1]);
% iTRom = reshape(iTRom,[length(s)*3,1]);
% iTPectIS = reshape(iTPectIS,[length(s)*3,1]);
% iTPectI = reshape(iTPectI,[length(s)*3,1]);
% iTPectDS = reshape(iTPectDS,[length(s)*3,1]);
% iTPectD = reshape(iTPectD,[length(s)*3,1]);
% iTEcomIS = reshape(iTEcomIS,[length(s)*3,1]);
% iTEcomI = reshape(iTEcomI,[length(s)*3,1]);
% iTEcomDS = reshape(iTEcomDS,[length(s)*3,1]);
% iTEcomD = reshape(iTEcomD,[length(s)*3,1]);
% iTAbdIS = reshape(iTAbdIS,[length(s)*3,1]);
% iTAbdI = reshape(iTAbdI,[length(s)*3,1]);
% iTAbdDS = reshape(iTAbdDS,[length(s)*3,1]);
% iTAbdD = reshape(iTAbdD,[length(s)*3,1]);
% iPTimeSpirometry = reshape(iPTimeSpirometry,[length(s)*3,1]);
% iPTime = reshape(iPTime,[length(s)*3,1]);
% iPRomSpirometry = reshape(iPRomSpirometry,[length(s)*3,1]);
% iPRom = reshape(iPRom,[length(s)*3,1]);
% iPPectIS = reshape(iPPectIS,[length(s)*3,1]);
% iPPectI = reshape(iPPectI,[length(s)*3,1]);
% iPPectDS = reshape(iPPectDS,[length(s)*3,1]);
% iPPectD = reshape(iPPectD,[length(s)*3,1]);
% iPEcomIS = reshape(iPEcomIS,[length(s)*3,1]);
% iPEcomI = reshape(iPEcomI,[length(s)*3,1]);
% iPEcomDS = reshape(iPEcomDS,[length(s)*3,1]);
% iPEcomD = reshape(iPEcomD,[length(s)*3,1]);
% iPAbdIS = reshape(iPAbdIS,[length(s)*3,1]);
% iPAbdI = reshape(iPAbdI,[length(s)*3,1]);
% iPAbdDS = reshape(iPAbdDS,[length(s)*3,1]);
% iPAbdD = reshape(iPAbdD,[length(s)*3,1]);
% iBTimeSpirometry = reshape(iBTimeSpirometry,[length(s)*3,1]);
% iBTime = reshape(iBTime,[length(s)*3,1]);
% iBRomSpirometry = reshape(iBRomSpirometry,[length(s)*3,1]);
% iBRom = reshape(iBRom,[length(s)*3,1]);
% iBPectIS = reshape(iBPectIS,[length(s)*3,1]);
% iBPectI = reshape(iBPectI,[length(s)*3,1]);
% iBPectDS = reshape(iBPectDS,[length(s)*3,1]);
% iBPectD = reshape(iBPectD,[length(s)*3,1]);
% iBEcomIS = reshape(iBEcomIS,[length(s)*3,1]);
% iBEcomI = reshape(iBEcomI,[length(s)*3,1]);
% iBEcomDS = reshape(iBEcomDS,[length(s)*3,1]);
% iBEcomD = reshape(iBEcomD,[length(s)*3,1]);
% iBAbdIS = reshape(iBAbdIS,[length(s)*3,1]);
% iBAbdI = reshape(iBAbdI,[length(s)*3,1]);
% iBAbdDS = reshape(iBAbdDS,[length(s)*3,1]);
% iBAbdD = reshape(iBAbdD,[length(s)*3,1]);
% eTTimeSpirometry = reshape(eTTimeSpirometry,[length(s)*3,1]);
% eTTime = reshape(eTTime,[length(s)*3,1]);
% eTRomSpirometry = reshape(eTRomSpirometry,[length(s)*3,1]);
% eTRom = reshape(eTRom,[length(s)*3,1]);
% eTPectIS = reshape(eTPectIS,[length(s)*3,1]);
% eTPectI = reshape(eTPectI,[length(s)*3,1]);
% eTPectDS = reshape(eTPectDS,[length(s)*3,1]);
% eTPectD = reshape(eTPectD,[length(s)*3,1]);
% eTEcomIS = reshape(eTEcomIS,[length(s)*3,1]);
% eTEcomI = reshape(eTEcomI,[length(s)*3,1]);
% eTEcomDS = reshape(eTEcomDS,[length(s)*3,1]);
% eTEcomD = reshape(eTEcomD,[length(s)*3,1]);
% eTAbdIS = reshape(eTAbdIS,[length(s)*3,1]);
% eTAbdI = reshape(eTAbdI,[length(s)*3,1]);
% eTAbdDS = reshape(eTAbdDS,[length(s)*3,1]);
% eTAbdD = reshape(eTAbdD,[length(s)*3,1]);
% ePTimeSpirometry = reshape(ePTimeSpirometry,[length(s)*3,1]);
% ePTime = reshape(ePTime,[length(s)*3,1]);
% ePRomSpirometry = reshape(ePRomSpirometry,[length(s)*3,1]);
% ePRom = reshape(ePRom,[length(s)*3,1]);
% ePPectIS = reshape(ePPectIS,[length(s)*3,1]);
% ePPectI = reshape(ePPectI,[length(s)*3,1]);
% ePPectDS = reshape(ePPectDS,[length(s)*3,1]);
% ePPectD = reshape(ePPectD,[length(s)*3,1]);
% ePEcomIS = reshape(ePEcomIS,[length(s)*3,1]);
% ePEcomI = reshape(ePEcomI,[length(s)*3,1]);
% ePEcomDS = reshape(ePEcomDS,[length(s)*3,1]);
% ePEcomD = reshape(ePEcomD,[length(s)*3,1]);
% ePAbdIS = reshape(ePAbdIS,[length(s)*3,1]);
% ePAbdI = reshape(ePAbdI,[length(s)*3,1]);
% ePAbdDS = reshape(ePAbdDS,[length(s)*3,1]);
% ePAbdD = reshape(ePAbdD,[length(s)*3,1]);
% eBTimeSpirometry = reshape(eBTimeSpirometry,[length(s)*3,1]);
% eBTime = reshape(eBTime,[length(s)*3,1]);
% eBRomSpirometry = reshape(eBRomSpirometry,[length(s)*3,1]);
% eBRom = reshape(eBRom,[length(s)*3,1]);
% eBPectIS = reshape(eBPectIS,[length(s)*3,1]);
% eBPectI = reshape(eBPectI,[length(s)*3,1]);
% eBPectDS = reshape(eBPectDS,[length(s)*3,1]);
% eBPectD = reshape(eBPectD,[length(s)*3,1]);
% eBEcomIS = reshape(eBEcomIS,[length(s)*3,1]);
% eBEcomI = reshape(eBEcomI,[length(s)*3,1]);
% eBEcomDS = reshape(eBEcomDS,[length(s)*3,1]);
% eBEcomD = reshape(eBEcomD,[length(s)*3,1]);
% eBAbdIS = reshape(eBAbdIS,[length(s)*3,1]);
% eBAbdI = reshape(eBAbdI,[length(s)*3,1]);
% eBAbdDS = reshape(eBAbdDS,[length(s)*3,1]);
% eBAbdD = reshape(eBAbdD,[length(s)*3,1]);

iTTimeSpirometry = mean(iTTimeSpirometry).';
iTTime = mean(iTTime).';
iTRomSpirometry = mean(iTRomSpirometry).';
iTRom = mean(iTRom).';
iTPectIS = mean(iTPectIS).';
iTPectI = mean(iTPectI).';
iTPectDS = mean(iTPectDS).';
iTPectD = mean(iTPectD).';
iTEcomIS = mean(iTEcomIS).';
iTEcomI = mean(iTEcomI).';
iTEcomDS = mean(iTEcomDS).';
iTEcomD = mean(iTEcomD).';
iTAbdIS = mean(iTAbdIS).';
iTAbdI = mean(iTAbdI).';
iTAbdDS = mean(iTAbdDS).';
iTAbdD = mean(iTAbdD).';
iPTimeSpirometry = mean(iPTimeSpirometry).';
iPTime = mean(iPTime).';
iPRomSpirometry = mean(iPRomSpirometry).';
iPRom = mean(iPRom).';
iPPectIS = mean(iPPectIS).';
iPPectI = mean(iPPectI).';
iPPectDS = mean(iPPectDS).';
iPPectD = mean(iPPectD).';
iPEcomIS = mean(iPEcomIS).';
iPEcomI = mean(iPEcomI).';
iPEcomDS = mean(iPEcomDS).';
iPEcomD = mean(iPEcomD).';
iPAbdIS = mean(iPAbdIS).';
iPAbdI = mean(iPAbdI).';
iPAbdDS = mean(iPAbdDS).';
iPAbdD = mean(iPAbdD).';
iBTimeSpirometry = mean(iBTimeSpirometry).';
iBTime = mean(iBTime).';
iBRomSpirometry = mean(iBRomSpirometry).';
iBRom = mean(iBRom).';
iBPectIS = mean(iBPectIS).';
iBPectI = mean(iBPectI).';
iBPectDS = mean(iBPectDS).';
iBPectD = mean(iBPectD).';
iBEcomIS = mean(iBEcomIS).';
iBEcomI = mean(iBEcomI).';
iBEcomDS = mean(iBEcomDS).';
iBEcomD = mean(iBEcomD).';
iBAbdIS = mean(iBAbdIS).';
iBAbdI = mean(iBAbdI).';
iBAbdDS = mean(iBAbdDS).';
iBAbdD = mean(iBAbdD).';
eTTimeSpirometry = mean(eTTimeSpirometry).';
eTTime = mean(eTTime).';
eTRomSpirometry = mean(eTRomSpirometry).';
eTRom = mean(eTRom).';
eTPectIS = mean(eTPectIS).';
eTPectI = mean(eTPectI).';
eTPectDS = mean(eTPectDS).';
eTPectD = mean(eTPectD).';
eTEcomIS = mean(eTEcomIS).';
eTEcomI = mean(eTEcomI).';
eTEcomDS = mean(eTEcomDS).';
eTEcomD = mean(eTEcomD).';
eTAbdIS = mean(eTAbdIS).';
eTAbdI = mean(eTAbdI).';
eTAbdDS = mean(eTAbdDS).';
eTAbdD = mean(eTAbdD).';
ePTimeSpirometry = mean(ePTimeSpirometry).';
ePTime = mean(ePTime).';
ePRomSpirometry = mean(ePRomSpirometry).';
ePRom = mean(ePRom).';
ePPectIS = mean(ePPectIS).';
ePPectI = mean(ePPectI).';
ePPectDS = mean(ePPectDS).';
ePPectD = mean(ePPectD).';
ePEcomIS = mean(ePEcomIS).';
ePEcomI = mean(ePEcomI).';
ePEcomDS = mean(ePEcomDS).';
ePEcomD = mean(ePEcomD).';
ePAbdIS = mean(ePAbdIS).';
ePAbdI = mean(ePAbdI).';
ePAbdDS = mean(ePAbdDS).';
ePAbdD = mean(ePAbdD).';
eBTimeSpirometry = mean(eBTimeSpirometry).';
eBTime = mean(eBTime).';
eBRomSpirometry = mean(eBRomSpirometry).';
eBRom = mean(eBRom).';
eBPectIS = mean(eBPectIS).';
eBPectI = mean(eBPectI).';
eBPectDS = mean(eBPectDS).';
eBPectD = mean(eBPectD).';
eBEcomIS = mean(eBEcomIS).';
eBEcomI = mean(eBEcomI).';
eBEcomDS = mean(eBEcomDS).';
eBEcomD = mean(eBEcomD).';
eBAbdIS = mean(eBAbdIS).';
eBAbdI = mean(eBAbdI).';
eBAbdDS = mean(eBAbdDS).';
eBAbdD = mean(eBAbdD).';

disp('Done')

sub = [1;2;3;4;5;6;7];

% task1 = [
%     "basal";"basal";"basal";
%     "basal";"basal";"basal";
%     "basal";"basal";"basal";
%     "basal";"basal";"basal";
%     "basal";"basal";"basal";
%     "basal";"basal";"basal";
%     "basal";"basal";"basal"
%     ];
% 
% task2 = [
%     "preTherapep";"preTherapep";"preTherapep";
%     "preTherapep";"preTherapep";"preTherapep";
%     "preTherapep";"preTherapep";"preTherapep";
%     "preTherapep";"preTherapep";"preTherapep";
%     "preTherapep";"preTherapep";"preTherapep";
%     "preTherapep";"preTherapep";"preTherapep";
%     "preTherapep";"preTherapep";"preTherapep"
%     ];
% 
% task3 = [
%     "postTherapep";"postTherapep";"postTherapep";
%     "postTherapep";"postTherapep";"postTherapep";
%     "postTherapep";"postTherapep";"postTherapep";
%     "postTherapep";"postTherapep";"postTherapep";
%     "postTherapep";"postTherapep";"postTherapep";
%     "postTherapep";"postTherapep";"postTherapep";
%     "postTherapep";"postTherapep";"postTherapep"
%     ];

task1 = [
    "basal";"basal";"basal";
    "basal";"basal";"basal";
    "basal";
    ];

task2 = [
    "preTherapep";"preTherapep";"preTherapep";
    "preTherapep";"preTherapep";"preTherapep";
    "preTherapep";
    ];

task3 = [
    "postTherapep";"postTherapep";"postTherapep";
    "postTherapep";"postTherapep";"postTherapep";
    "postTherapep";
    ];

varNames = {'Sujeto','Tarea',...
    'VC ROM espiracion','VC Tiempo espiracion', ...
    'CVF ROM espiracion','CVF Tiempo espiracion', ...
    'VC ROM inspiracion','VC Tiempo inspiracion', ...
    'CVF ROM inspiracion','CVF Tiempo inspiracion', ...
    'VC EMG normalizado espiracion ECOM D', 'VC EMG normalizado espiracion ECOM I', ...
    'VC EMG normalizado espiracion Pectoralis D', 'VC EMG normalizado espiracion Pectoralis I', ...
    'VC EMG normalizado espiracion Abdominalis D', 'VC EMG normalizado espiracion Abdominalis I', ...
    'CVF EMG normalizado espiracion ECOM D', 'CVF EMG normalizado espiracion ECOM I', ...
    'CVF EMG normalizado espiracion Pectoralis D', 'CVF EMG normalizado espiracion Pectoralis I', ...
    'CVF EMG normalizado espiracion Abdominalis D', 'CVF EMG normalizado espiracion Abdominalis I', ...
    'VC EMG normalizado inspiracion ECOM D', 'VC EMG normalizado inspiracion ECOM I', ...
    'VC EMG normalizado inspiracion Pectoralis D', 'VC EMG normalizado inspiracion Pectoralis I', ...
    'VC EMG normalizado inspiracion Abdominalis D', 'VCEMG normalizado inspiracion Abdominalis I', ...
    'CVF EMG normalizado inspiracion ECOM D', 'CVF EMG normalizado inspiracion ECOM I', ...
    'CVF EMG normalizado inspiracion Pectoralis D', 'CVF EMG normalizado inspiracion Pectoralis I', ...
    'CVF EMG normalizado inspiracion Abdominalis D', 'CVF EMG normalizado inspiracion Abdominalis I', ...
    };


% Create a MATLAB table
data = table([sub;sub;sub], ...
    [task1; task2; task3], ...
    [eBRom; ePRom; eTRom], ...
    [eBTime; ePTime; eTTime], ...
    [eBRomSpirometry; ePRomSpirometry; eTRomSpirometry], ...
    [eBTimeSpirometry; ePTimeSpirometry; eTTimeSpirometry], ...
    [iBRom; iPRom; iTRom],  ...
    [iBTime; iPTime; iTTime],...
    [iBRomSpirometry; iPRomSpirometry; iTRomSpirometry], ...
    [iBTimeSpirometry; iPTimeSpirometry; iTTimeSpirometry], ...
    [eBEcomD; ePEcomD; eTEcomD], ...
    [eBEcomI; ePEcomI; eTEcomI], ...
    [eBPectD; ePPectD; eTPectD], ...
    [eBPectI; ePPectI; eTPectI], ...
    [eBAbdD; ePAbdD; eTAbdD], ...
    [eBAbdI; ePAbdI; eTAbdI], ...
    [iBEcomD; iPEcomD; iTEcomD], ...
    [iBEcomI; iPEcomI; iTEcomI], ...
    [iBPectD; iPPectD; iTPectD], ...
    [iBPectI; iPPectI; iTPectI], ...
    [iBAbdD; iPAbdD; iTAbdD], ...
    [iBAbdI; iPAbdI; iTAbdI], ...
    [eBEcomDS; ePEcomDS; eTEcomDS], ...
    [eBEcomIS; ePEcomIS; eTEcomIS], ...
    [eBPectDS; ePPectDS; eTPectDS], ...
    [eBPectIS; ePPectIS; eTPectIS], ...
    [eBAbdDS; ePAbdDS; eTAbdDS], ...
    [eBAbdIS; ePAbdIS; eTAbdIS], ...
    [iBEcomDS; iPEcomDS; iTEcomDS], ...
    [iBEcomIS; iPEcomIS; iTEcomIS], ...
    [iBPectDS; iPPectDS; iTPectDS], ...
    [iBPectIS; iPPectIS; iTPectIS], ...
    [iBAbdDS; iPAbdDS; iTAbdDS], ...
    [iBAbdIS; iPAbdIS; iTAbdIS], ...    
    'VariableNames',varNames);


% Write the table to an Excel file
writetable(data, 'Epoc_data.xlsx');


% Extract ROM from espiration cycles (including spirometry)
function [romBasal, timeBasal, spiroBasal, timeSpiroBasal] = eExtractRom(inputData)

counter = 0 ;
data = inputData;

for i = 1:2:6

    counter = counter + 1;

    xstart = data(i,1);
    xend = data(i+1,1);

    ystart = data(i,2);
    yend = data(i+1,2);

    timeDiaphragm(counter,:) = abs(xend- xstart);
    romDiaphragm(counter,:) = abs(yend-ystart);

    timeBasal = mean(timeDiaphragm)/100; %seconds
    romBasal = mean(romDiaphragm); % cm

    timeSpiroBasal = abs(data(8,1)-data(7,1))/100; %seconds
    spiroBasal = abs(data(8,2)-data(7,2)); %cm

end
end


% Extract ROM from inspiration cycles (including spirometry)
function [romBasal, timeBasal, spiroBasal, timeSpiroBasal] = iExtractRom(inputData)

counter = 0 ;
data = inputData;

for i = 2:2:7

    counter = counter + 1;

    xstart = data(i,1);
    xend = data(i+1,1);

    ystart = data(i,2);
    yend = data(i+1,2);

    timeDiaphragm(counter,:) = abs(xend- xstart);
    romDiaphragm(counter,:) = abs(yend-ystart);

end
timeBasal = mean(timeDiaphragm)/100; %seconds
romBasal = mean(romDiaphragm); % cm

timeSpiroBasal = abs(data(9,1)-data(8,1))/100; %seconds
spiroBasal = abs(data(9,2)-data(8,2)); %cm
end


% Extract RMS from espiration cycles
function [m1, m2, m3, m4, m5, m6] = eCalculateRms(input1, input2, input3)

counter = 0;
data = input1;

for i = 1:2:6
    counter = counter + 1;

    xstart = data(i,1);
    xend = data(i+1,1);

    m1(counter,:) = (mean(input3(xstart*20:xend*20,1))*100)/input2(:,1);
    m2(counter,:) = (mean(input3(xstart*20:xend*20,2))*100)/input2(:,2);
    m3(counter,:) = (mean(input3(xstart*20:xend*20,3))*100)/input2(:,3);
    m4(counter,:) = (mean(input3(xstart*20:xend*20,4))*100)/input2(:,4);
    m5(counter,:) = (mean(input3(xstart*20:xend*20,5))*100)/input2(:,5);
    m6(counter,:) = (mean(input3(xstart*20:xend*20,6))*100)/input2(:,6);

end
m1 = mean(m1);
m2 = mean(m2);
m3 = mean(m3);
m4 = mean(m4);
m5 = mean(m5);
m6 = mean(m6);

end


% Extract RMS from inspiration cycles
function [m1, m2, m3, m4, m5, m6] = iCalculateRms(input1, input2, input3)

counter = 0;
data = input1;

for i = 2:2:7
    counter = counter + 1;

    xstart = data(i,1);
    xend = data(i+1,1);

    m1(counter,:) = (mean(input3(xstart*20:xend*20,1))*100)/input2(:,1);
    m2(counter,:) = (mean(input3(xstart*20:xend*20,2))*100)/input2(:,2);
    m3(counter,:) = (mean(input3(xstart*20:xend*20,3))*100)/input2(:,3);
    m4(counter,:) = (mean(input3(xstart*20:xend*20,4))*100)/input2(:,4);
    m5(counter,:) = (mean(input3(xstart*20:xend*20,5))*100)/input2(:,5);
    m6(counter,:) = (mean(input3(xstart*20:xend*20,6))*100)/input2(:,6);

end
m1 = mean(m1);
m2 = mean(m2);
m3 = mean(m3);
m4 = mean(m4);
m5 = mean(m5);
m6 = mean(m6);
end


% Extract RMS from spirometry (espiration)
function [m1, m2, m3, m4, m5, m6] = eCalculateRmsS(input1, input2, input3)

data = input1;
xstart = data(7,1);
xend = data(8,1);

m1 = (mean(input3(xstart*20:xend*20,1))*100)/input2(:,1);
m2 = (mean(input3(xstart*20:xend*20,2))*100)/input2(:,2);
m3 = (mean(input3(xstart*20:xend*20,3))*100)/input2(:,3);
m4 = (mean(input3(xstart*20:xend*20,4))*100)/input2(:,4);
m5 = (mean(input3(xstart*20:xend*20,5))*100)/input2(:,5);
m6 = (mean(input3(xstart*20:xend*20,6))*100)/input2(:,6);

end


% Extract RMS from inspiration cycles
function [m1, m2, m3, m4, m5, m6] = iCalculateRmsS(input1, input2, input3)

data = input1;
xstart = data(8,1);
xend = data(9,1);

m1 = (mean(input3(xstart*20:xend*20,1))*100)/input2(:,1);
m2 = (mean(input3(xstart*20:xend*20,2))*100)/input2(:,2);
m3 = (mean(input3(xstart*20:xend*20,3))*100)/input2(:,3);
m4 = (mean(input3(xstart*20:xend*20,4))*100)/input2(:,4);
m5 = (mean(input3(xstart*20:xend*20,5))*100)/input2(:,5);
m6 = (mean(input3(xstart*20:xend*20,6))*100)/input2(:,6);

end



