% Pipeline - Awake FMR1 Comparison Study ~( °٢° )~

% This is the master script for the awake FMR1 KO and WT study, run by Katrina
% Deane at University of California, Riverside in Khaleel Razak's lab in
% the Psychology Department. 

% The overall goal of this study is to characterize A1 laminar differences
% between groups. FMR1 KOs have auditory hypersensitivity and in vitro it
% was found that their layer 2/3 and 5 were more synchronized in response
% to stimulation in layer 2/3 specifically (Goswami 2019, Neurobiol Dis)

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
figfold = [homedir '\figures\Fmr1Awake'];
outfold = [homedir '\output\Fmr1Awake'];
if ~exist(figfold, 'dir')
    mkdir(figfold); mkdir(outfold);
end

% set consistently needed variables
Groups = {'AKO'};  %'AWT' 'AKO' 'CKH'
% Condition = {'NoiseBurst'};
Condition = {'NoiseBurst' 'Spontaneous' 'ClickTrain' 'Chirp' ...
    'gapASSR' 'postNoiseBurst'};

%% this REASSIGNS KSlabel (mua/good) based on correlogram check


%% LAYERS
% Data generation across layers ⊂◉‿◉つ

DynamicSpikes(homedir, figfold, Groups, Condition,'Awake')


% Group Layer pics 
% this also used the spikeDetection.m script to pull data for stats
Group_Avg_raster(homedir, figfold, outfold, Groups, Condition,'Awake')

%% Individual IDs
% Run each spike ID, adding it to the data structure per subject
DynamicSpikes_byID(homedir, figfold, Groups, Condition,'Awake')

% to do:
% use the spikeDetection.m script to pull data for stats, add column to
% output for label (mua/good)
% NewFunction(homedir, figfold, outfold, Groups, Condition,'Anesthetized')