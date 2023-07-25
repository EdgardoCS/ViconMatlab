% Created by E.Silva 25/07/23

clc; clear; 

load('C:\Users\Usuario\Documents\GitHub\ViconMatlab\Chaffin\DataEMG\001\taskData.mat')

muscles = [C01_T1_deltAnt, C01_T1_deltMed, C01_T1_trapSup, C01_T1_trapMed, C01_T1_trapInf, C01_T1_serrAnt];

%%
for i = 1:length(muscles(1,:))

targetData = muscles(:,i)*1000; % to mV

L = length(targetData);
fs = 2000; 
f = fs*(0:(L/2))/L;

p = fft(targetData);
p = abs(p/L);

p = p(1:L/2+1); 
p(2:end-1) = 2*p(2:end-1);

% subplot(3,2,i)
% plot(f, p)
% ylim([0,0.001])
% xlabel('Frequency (Hz)')
% ylabel('Amplitude (mV)')
% title('Deltoides Anterior')
% grid 
% 
% if (i ==1)
%     title('Anterior Deltoid')
% elseif (i==2)
%     title('Medial Deltoid ')
% elseif (i==3)
%     title('Superior Trapezius')
% elseif (i==4)
%     title('Medial Trapezius')
% elseif (i==5)
%     title('Inferior Trapezius')
% elseif (i==6)
%     title('Anterior Serratus')
% end

end

%%
% Filter stage
% From 15 to 300 Hz


muscles = muscles*1000;

fn = fs/2; 
fch = 10; 
fcl = 300; 

% 4th order butterworth band-pass
[b,a] = butter(4,[fch,fcl]/fn, "bandpass"); 

for i = 1:6
    filteredData(:,i) = filtfilt(b,a,muscles(:,6));

% subplot(3,2,i)
% plot(filteredData(:,i))
% xlabel('Frequency (Hz)')
% ylabel('Amplitude (mV)')
% title('Deltoides Anterior')
% grid 
% 
% if (i ==1)
%     title('Anterior Deltoid')
% elseif (i==2)
%     title('Medial Deltoid ')
% elseif (i==3)
%     title('Superior Trapezius')
% elseif (i==4)
%     title('Medial Trapezius')
% elseif (i==5)
%     title('Inferior Trapezius')
% elseif (i==6)
%     title('Anterior Serratus')
% end

% rectifitaction

filteredData(:,i) = abs(filteredData(:,i));
end

