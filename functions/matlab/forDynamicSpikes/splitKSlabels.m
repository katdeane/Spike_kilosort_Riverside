function [muas,suss] = splitKSlabels(spikes)

% we should already be inside of the kilosort output folder for this
% measurement

% load in kilosort's label system
Labels = readtable("cluster_KSLabel.tsv", "FileType","text",'Delimiter', '\t');

% get the list of id's per label type ('good' = single unit)
muaIDs = Labels(matches(Labels.KSLabel,'mua'),1).cluster_id;
susIDs = Labels(matches(Labels.KSLabel,'good'),1).cluster_id;

% there's definitely a more computationally efficient way to do this
muas = spikes(spikes(:,1)==muaIDs(1),:);
for iU = 2:length(muaIDs)
    muas = vertcat(muas, spikes(spikes(:,1)==muaIDs(iU),:));
end
suss = spikes(spikes(:,1)==susIDs(1),:);
for iU = 2:length(susIDs)
    suss = vertcat(suss, spikes(spikes(:,1)==susIDs(iU),:));
end

if length(suss) + length(muas) ~= length(spikes)
    disp('These lists do not match')
    keyboard
end
