
%https://www.sciencedirect.com/science/article/pii/S1050641103001500?via%3Dihub#FIG1

clc; clear; 

load data\sujeto5.mat

data = emg.EB1;
[emgFilt, emgRms] = filterEMG(data);
emgbp.EB1 = emgFilt; 
emgrms.EB1 = emgRms;

data = emg.EB2;
[emgFilt, emgRms] = filterEMG(data);
emgbp.EB2 = emgFilt; 
emgrms.EB2 = emgRms;

data = emg.EB3;
[emgFilt, emgRms] = filterEMG(data);
emgbp.EB3 = emgFilt; 
emgrms.EB3 = emgRms;

data = emg.EP1;
[emgFilt, emgRms] = filterEMG(data);
emgbp.EP1 = emgFilt; 
emgrms.EP1 = emgRms;

data = emg.EP2;
[emgFilt, emgRms] = filterEMG(data);
emgbp.EP2 = emgFilt; 
emgrms.EP2 = emgRms;

data = emg.EP3;
[emgFilt, emgRms] = filterEMG(data);
emgbp.EP3 = emgFilt; 
emgrms.EP3 = emgRms;

data = emg.ET1;
[emgFilt, emgRms] = filterEMG(data);
emgbp.ET1 = emgFilt; 
emgrms.ET1 = emgRms;

data = emg.ET2;
[emgFilt, emgRms] = filterEMG(data);
emgbp.ET2 = emgFilt; 
emgrms.ET2 = emgRms;

data = emg.ET3;
[emgFilt, emgRms] = filterEMG(data);
emgbp.ET3 = emgFilt; 
emgrms.ET3 = emgRms;

clearvars -except emgbp emgrms
disp('Done')

function [emgFilt, emgRms] = filterEMG(emg)

% Sampling frequency    
Fs = 2000;
T = 1/Fs;               % Sampling period       
L = length(emg(:,1));   % Length of signal
t = (0:L-1)*T;          % Time vector 

for i = 1:6

targetData = emg(:,i);
emgFilt(:,i) = bandpass(targetData,[25 250],Fs);
emgRms(:,i) = sqrt(movmean(emgFilt(:,i).^ 2, 1000));

% subplot(3,2,i)
% plot(targetData)
% hold on 
% plot(filterData, 'r')
% hold on
% plot(rmsData, 'k', 'LineWidth',2)
% grid 
% 
% if (i ==1)
%     title('ECOM L')
% elseif (i==2)
%     title('ECOM R')
% elseif (i==3)
%     title('Pectoralis L')
% elseif (i==4)
%     title('Pectoralis R')
% elseif (i==5)
%     title('Abdominis L')
% elseif (i==6)
%     title('Abdominis R')
% end

end

end


%{
% Fourier and Spectral Analysis

% plot original signal
subplot(2,2,1)
plot(emg(:,1))
title("Original signal")
xlabel("t (milliseconds)")
ylabel("X(t)")

% apply fft 
Y = fft(emg);

subplot(2,2,2)
plot(Fs/L*(0:L-1),abs(Y),"LineWidth",3)
title("Complex Magnitude of fft Spectrum")
xlabel("f (Hz)")
ylabel("|fft(X)|")

%plot fft in double side spectrum

subplot(2,2,3)
plot(Fs/L*(-L/2:L/2-1),abs(fftshift(Y)),"LineWidth",3)
title("fft Spectrum in the Positive and Negative Frequencies")
xlabel("f (Hz)")
ylabel("|fft(X)|")

% plot fft in single side spectrum
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

subplot(2,2,4)
f = Fs/L*(0:(L/2));
plot(f,P1,"LineWidth",3) 
title("Single-Sided Amplitude Spectrum of X(t)")
xlabel("f (Hz)")
ylabel("|P1(f)|")

f1 = figure; 
for i = 1:6

targetData = emg(:,i);

Fs = 2000;              % Sampling frequency                    
T = 1/Fs;               % Sampling period       
L = length(emg(:,1));   % Length of signal
t = (0:L-1)*T;          % Time vector 

Y = fft(targetData);

P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs/L*(0:(L/2));

subplot(3,2,i)
plot(f,P1,"LineWidth",2) 
ylim([0,0.000001])
grid 

if (i ==1)
    title('ECOM L')
elseif (i==2)
    title('ECOM R')
elseif (i==3)
    title('Pectoralis L')
elseif (i==4)
    title('Pectoralis R')
elseif (i==5)
    title('Abdominis L')
elseif (i==6)
    title('Abdominis R')
end

end

%}


