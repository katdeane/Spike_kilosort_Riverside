function DataOut = icutsingleraster(stimIn, SpikeMatrix, BL, stimdur, ITI, thistype)

%% timing info 
% IMPORTANT: keep in mind that stimIn comes in at fs=1k and the data is fs=3k
% to that end, all timestamps brought in will be multiplied by 3

% stim duration + ITI (ms)
stimITI = stimdur+ITI; % ms
stimITI = stimITI*3; % μs
BL = BL*3; % μs

%% cut and stack
if matches(thistype, 'spont')

    % truncate data in 2 second intervals, no space between (can be
    % restacked)
    onsets = 1:stimITI:size(SpikeMatrix,2);
    % cut off end if it doesn't reach the right amount of time
    onsets = onsets(1:floor(size(SpikeMatrix,2)/stimITI));

    curData = NaN(size(SpikeMatrix,1), stimITI, length(onsets));

    % now we can cut out the time points around onsets corresponding to
    % specific dB
    for iOn = 1:length(onsets)

        curData(:,:,iOn) = SpikeMatrix(:,onsets(iOn):onsets(iOn)+stimITI-1);

    end

    % this format lets it run through the rest of the script without
    % changes
    DataOut{1} = curData;

elseif matches(thistype, 'single')

    threshold = 0.9; %microvolts, constant input of at least 0.1 through analog channel from RZ6 to XDAC
    location = threshold <= stimIn; % 1 is above, 0 is below

    % detect when signal crosses ABOVE threshold
    % this means if throwoutfirst == 1, the first onset is second stim
    crossover = diff(location);
    onsets = find(crossover == 1);
    onsets = onsets*3; % convert to fs 3k

    curData = NaN(size(SpikeMatrix,1), stimITI + BL + 1, length(onsets));

    % now we can cut out the time points around onsets corresponding to
    % specific dB
    for iOn = 1:length(onsets)
        % 400 ms = exact onset "1" 
        curData(:,:,iOn) = SpikeMatrix(:,onsets(iOn)-BL:onsets(iOn)+stimITI);

    end

    DataOut{1} = curData;

end