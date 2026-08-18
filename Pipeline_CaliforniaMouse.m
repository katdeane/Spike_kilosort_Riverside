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
Groups = {'VMP' 'PMP'};  %'VMA' 'PMA' 
% Condition = {'NoiseBurst'};
Condition = {'NoiseBurst' 'Pupcall30' 'Spontaneous'  ...
    'ClickTrain' 'gapASSR' 'Chirp' 'PostNoiseBurst'}; 


%% this REASSIGNS KSlabel (mua/good) based on correlogram check

% it currently actually doesn't do anything
CorrelogramCheck(homedir, Groups, Condition)

%% LAYERS
% Data generation across layers ⊂◉‿◉つ

DynamicSpikes(homedir, figfold, Groups, Condition,'Anesthetized')

% Group Layer pics 
% this also used the spikeDetection.m script to pull data for stats
Group_Avg_raster(homedir, figfold, outfold, Groups, Condition,'Anesthetized')

%% Individual IDs
% Run each spike ID, adding it to the data structure per subject
DynamicSpikes_byID(homedir, figfold, Groups, Condition,'Anesthetized')

% to do:
% use the spikeDetection.m script to pull data for stats, add column to
% output for label (mua/good)
% NewFunction(homedir, figfold, outfold, Groups, Condition,'Anesthetized')