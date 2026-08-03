function [spikeMatrix] = irasterdata(timestamps,locations,kilochanpos,chanorder,keptspikes)

% sampling rate is currently 30000, we need to downsample to 3000
timestamps = timestamps ./ 10;

% location is in microns, keep as is
% slap the times and locations together
spikes = [timestamps,locations(:,2)];
% filter out spikes not kept during sorting
spikes = spikes(keptspikes,:);




chandepths = kilochanpos(chanorder,2);





% length of data and corresponding sampling points (fs = 3000)
datams     = (timerange(2) - timerange(1)) * 1000; % ms
datalength = round(datams); % 
% sp_in_ms   = 1:0.33333333:datams;



% now let's fix the channel Idxs and designate channel order
ntvIdxs   = ntvIdxs + 1;

% for raster, I think we can currently ignore the labels 

%% Reorder 
% Note: if we want it in nanoseconds instead, we can only work with a
% channel at a time. It's too many data points 

% build a container
spikeMatrix = zeros(32,datalength); % fs = 3000

% fill the container
for ispike = 1:length(ntvIdxs)

    timeindex = round(timestamps(ispike));
    if timeindex > datalength
        timeindex = timeindex - 1;
    end
    % round the spike to its timepoint 3 sp/ms
    % thisStamp = threeSPround(timestamps(ispike));
    % find that time point index
    % error = 0.1;
    % timeindex = find(abs(thisStamp - sp_in_ms)<=error & ...
    %     abs(thisStamp - sp_in_ms)<=error);

    % add 1 to the corresponding channel and timepoint in ms 
    spikeMatrix(ntvIdxs(ispike),timeindex) = 1 + ...
        spikeMatrix(ntvIdxs(ispike),timeindex); 
end

% correct order of channels
spikeMatrix = spikeMatrix(chanorder,:);