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


%% Data generation per subject ⊂◉‿◉つ

DynamicSpikes(homedir, figfold, Groups, Condition,'Anesthetized')



% % code snippet to eventually plot spike templates
% % load the data container in with the templates 
% unit1 = squeeze(templates(1,:,:));
% thischan = find(max(rms(unit1,1))==rms(unit1,1));