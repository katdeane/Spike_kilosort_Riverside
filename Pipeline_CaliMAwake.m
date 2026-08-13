% Pipeline - Awake California Mouse Fathers vs Virgins

% notes about study

%% Get started

clear; clc;

% set working directory; change for your station
if exist('E:\Spike_kilosort_Riverside','dir')
    cd('E:\Spike_kilosort_Riverside'); 
elseif exist('F:\Spike_kilosort_Riverside','dir')
    cd('F:\Spike_kilosort_Riverside'); 
elseif exist('C:\Users\jimen\Documents\Spike_kilosort_Riverside','dir')
    cd('C:\Users\jimen\Documents\Spike_kilosort_Riverside');
else 
    print('add your working directory')
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
Groups = {'VMA' 'PMA'};  %'VMA' 'PMA' 
% Condition = {'NoiseBurst' 'ShortCall' 'Spontaneous'};
Condition = {'NoiseBurst' 'ShortCall' 'Spontaneous' 'MaskCall'  ...
    'Tonotopy' 'ClickTrain' 'gapASSR' 'NoiseBurst2pt5Hz' 'PostNoiseBurst'}; 

%% Data generation per subject ⊂◉‿◉つ

% per subject CSD Script
DynamicSpikes(homedir, figfold, Groups, Condition,'Awake')

