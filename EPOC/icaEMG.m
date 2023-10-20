clear; close all; clc;

load data\sujeto1.mat

% plot Fp1 electrode data (sits at front left part of head hear left eye)
% perturbations can be seen visually due to blinks
Data = emg.EB1; 

plot(Data(:,5))
title("Fp1 Before Blink Removal", 'FontSize', 14)

% PCA

% DEFINE NUMBER OF PRINICPAL COMPONENTS TO KEEP
% NOTE: it is typically a good idea to try out different numbers and
% compare their total explained variation
q=6;

% PERFORM PCA
% NOTE: it is important to normalize data! (i.e. substract mean of each 
% column and divide by standard deviation. MATLAB's pca function does this 
% automatically :p
[coeff,Data_PCA,latent,tsquared,explained,mu] = pca(Data, 'NumComponents', q);

% compute and display explained variation
disp(strcat("Top ", string(q), " principal components explain ", ...
    string(sum(explained(1:q))), " of variation"))
% ICA

% compute independent components from principal components
Mdl = rica(Data_PCA, q);
Data_ICA = transform(Mdl, Data_PCA);

% PLOT RESULTING COMPONENTS

% define number of plots per column of figure
plotsPerCol = 3;

% set up figure
figure(2)
fig = gcf;
fig.Units = 'normalized';
fig.Position = [0 0 1 1];

% plot components
for i = 1:q
    
    subplot(plotsPerCol,ceil(q/plotsPerCol),i)
    plot(Data_ICA(:,i).^2)
    title(strcat("Component ", string(i), " Squared"), 'FontSize', 16)
    ax = gca;
    ax.XTickLabel = {};
    
end