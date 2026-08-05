function [spikeMatrix] = irasterdata(spikes,L)

% spikes is spike ID x timestamp (fs=3000) x depth on probe (microns)
% L is layer structure where channels are set to corresponding depths

channels = [L.II L.IV L.Va L.Vb L.VI];
numchan = length(channels);
lastspike = max(spikes(:,2));

% sanity check: minutelength = (((lastspike/3)/1000)/60); anesthetized
% noise should be around 7.5 minutes

% build a container
spikeMatrix = zeros(numchan,round(lastspike)); % fs = 3000

% we're going to shoehorn the depths back into their corresponding channels
% so as to keep the size of the container down to 32 rows instead of 1500

% fill the container 1 spike at a time babyyyyy (is there a better way?...)
for ispike = 1:size(spikes,1)    

    % round to that 3k sampling in time
    timeindex = round(spikes(ispike,2)); 
    % round to nearest 50 micron in depth
    loc = spikes(ispike,3);
    div = 50;
    depth = round(loc./div).*div;
    chanindex = channels==depth; 
    % add 1 to the corresponding channel and timepoint in ms 
    spikeMatrix(chanindex,timeindex) = 1 + ...
        spikeMatrix(chanindex,timeindex); 
end