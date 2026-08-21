function [trlspikerate,avgspikerate,trlspikecount,avgspikecount,...
    trlPREcount,trlONSETcount,trlPOSTcount,avgPREcount,avgONSETcount,...
    avgPOSTcount,Fanofactor,FanoPRE,FanoONSET,FanoPOST] = ...
    spikeDetection(thisdat,Condition)

% sampling rate 
sampleRate = 3000;
% this function gets the spike rate and spike counts across full trials and
% trial averages, as well as spike counts across ROIs and the fano factor
% of each subject

% set time windows SPECIFIC to spike counting - we'll make this more
% dynamic later maybe - pup call stim types probably need a seperate
% version of this code so that more time windows can be set
prestim   = 900:1200; %300:400 ms
stimonset = 1200:1500; %400:500 ms
poststim  = 1800:2100; %600:700 ms
if matches(Condition,'gapASSR')
    poststim = 7650;9000; % 2550:3000 ms % our single gap in noise block
elseif matches(Condition,'Chirp')
    poststim = 4200:10200; % 1400:3400 ms % the 2 second Chirp
elseif matches(Condition,'ClickTrain')
    poststim = 4650:6000; % 1550:2000 ms % corresponding to zoomed in figure
end

% preallocate the trial spike buckets
trlspikerate  = zeros(size(thisdat,1),size(thisdat,3));
trlspikecount = trlspikerate;
trlPREcount   = trlspikerate;
trlONSETcount = trlspikerate;
trlPOSTcount  = trlspikerate;

for itrl = 1:length(trlspikerate)
    % spike count, full time window
    trlspikecount(:,itrl) = sum(thisdat(:,:,itrl),2);
    % spike rate per second (time axis in ms)
    trlspikerate(:,itrl)  = trlspikecount(:,itrl) / ((size(thisdat,2))/sampleRate);
    % spike count 100 ms of pre-stimulus activity
    trlPREcount(:,itrl)   = sum(thisdat(:,prestim,itrl),2);
    % spike count 100 ms from onset
    trlONSETcount(:,itrl) = sum(thisdat(:,stimonset,itrl),2);
    % spike count in post or continuous stim window
    trlPOSTcount(:,itrl)  = sum(thisdat(:,poststim,itrl),2);
end

avgspikerate  = mean(trlspikerate,2);
avgspikecount = mean(trlspikecount,2);
avgPREcount   = mean(trlPREcount,2);
avgONSETcount = mean(trlONSETcount,2);
avgPOSTcount  = mean(trlPOSTcount,2);

Fanofactor = (std(trlspikecount,0,2).^2)    ./avgspikecount;
FanoPRE    = (std(trlPREcount,0,2).^2)      ./avgPREcount;
FanoONSET  = (std(trlONSETcount,0,2).^2)    ./avgONSETcount;
FanoPOST   = (std(trlPOSTcount,0,2).^2)     ./avgPOSTcount;
 