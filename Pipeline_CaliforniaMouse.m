%% Get started

clear; clc;

% set working directory; change for your station
if exist('E:\Spike_kilosort_Riverside','dir')
    cd('E:\Spike_kilosort_Riverside'); 
elseif exist('F:\Spike_kilosort_Riverside','dir')
    cd('F:\Spike_kilosort_Riverside'); 
else
    error('add your local repository as shown above')
end
homedir = pwd;
addpath(genpath(homedir));
set(0, 'DefaultFigureRenderer', 'painters');

% output folders now specified for each analysis (to keep my sanity)
figfold = [homedir '\figures\CaliAwake'];
outfold = [homedir '\output\CaliAwake'];
if ~exist(figfold, 'dir')
    mkdir(figfold); mkdir(outfold);
end

% set consistently needed variables
Groups = {'VMP' 'PMP'};  %'VMA' 'PMA' 
Condition = {'NoiseBurst'};
% Condition = {'NoiseBurst' 'ShortCall' 'Spontaneous' 'MaskCall'  ...
%     'Tonotopy' 'ClickTrain' 'gapASSR' 'NoiseBurst2pt5Hz' 'PostNoiseBurst'}; 

DynamicSpikes(homedir, figfold, Groups, Condition,'Anesthetized')

