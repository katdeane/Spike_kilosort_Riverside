function [stimIn] = FileReaderStimChan(file)
% This converts the data from allego/curate, assuming it has already been 
% downsampled by 30. 
% sr = 1000 (1000 sp in 1 second / each sp is 1 ms)

% initalized NeuroNexus conversion function
reader = allegoXDatFileReaderR2019b;

timerange = reader.getAllegoXDatTimeRange(file);
signalStruct = reader.getAllegoXDatAllSigs(file, timerange);

% sanity check: 
% timeSamples = signalStruct.timeSamples; % seconds

% stimulus-in channel: 
stimIn = signalStruct.signals(33,:); % microvolts
