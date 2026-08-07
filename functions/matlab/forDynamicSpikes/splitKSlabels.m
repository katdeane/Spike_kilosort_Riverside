function [muas,suss] = splitKSlabels(spikes)

% we should already be inside of the kilosort output folder for this
% measurement

% load in kilosort's label system
Labels = readtable("cluster_KSLabel.tsv", "FileType","text",'Delimiter', '\t');

% get the list of id's per label type ('good' = single unit)
muaIDs = Labels(matches(Labels.KSLabel,'mua'),1).cluster_id;
susIDs = Labels(matches(Labels.KSLabel,'good'),1).cluster_id;

% there's definitely a more computationally efficient way to do this
muas = nan(length(spikes(:,1)),3);
suss = nan(length(spikes(:,1)),3);
mcount = 1; scount = 1;
for ievent = 1:length(spikes(:,1)) % look at each event
    if sum(spikes(ievent,1) == muaIDs) == 1 % does it match the muaID list?
        muas(mcount,:) = spikes(ievent,:);
        mcount = mcount +1;
    elseif sum(spikes(ievent,1) == susIDs) == 1 % does it match the susID list?
        suss(mcount,:) = spikes(ievent,:);
        scount = scount +1;
    else
        disp('this cluster does not have an expected label')
    end
end

muas(any(isnan(muas), 2), :) = [];
suss(any(isnan(suss), 2), :) = [];

if length(suss) + length(muas) ~= length(spikes)
    disp('and therefore these lists do not match')
    keyboard
end
