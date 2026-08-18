function CorrelogramCheck(homedir, Group, Condition)
%% Reconstruct Spiking Data

%datachecks
if ~exist('homedir','var')
    print('Do better. (it is ok, just run the pipeline)')
end

for iGro = 1:length(Group)

    run([Group{iGro} '.m']); % brings animals channels Cond Condition Layer
    Indexer = imakeIndexer(Condition,animals,Cond); %#ok<*USENS>

    for iSub = 1:length(animals)

        subname = animals{iSub};
        chanorder = str2num(channels{iSub});

        % initialize save data
        SpikeData = struct;

        for iStimType = 1:length(Condition)
            for iStimCount = 1:length(Cond.(Condition{iStimType}){iSub})
                if iStimCount == 1
                    CondIDX = Indexer(2).(Condition{iStimType});
                else
                    CondIDX = Indexer(2).(Condition{iStimType})+iStimCount-1;
                end

                measurement = Cond.(Condition{iStimType}){iSub}{iStimCount};

                %% Load the data from Videre/python and do things to it :D
                datafile = [subname '_' measurement '_LFP'];
                if isempty(measurement)
                    allegofile = 'not in group script';
                else
                    allegofile  = AllegoLookup(subname,measurement);
                end
                % skip empty measurements
                if exist(allegofile,'file')

                    disp(datafile)

                    % navigate to kilo output %
                    cd(homedir);cd Data
                    subfolders = dir;
                    subfolders = {subfolders.name}';
                    thisfolder = subfolders(contains(subfolders,[animals{iSub} '_kilo']));
                    thisfolder = thisfolder{:};
                    cd(thisfolder)
                    cd(allegofile)

                    


                    % waiting to hear back about spikecleaner

                    % % load data in %
                    % timestamps = double(readNPY('spike_times.npy')); % time of spike peak in fs=30k
                    % spike_ID   = double(readNPY('spike_clusters.npy')); %
                    % Labels     = readtable("cluster_KSLabel.tsv", "FileType","text",'Delimiter', '\t');
                    % spikes     = [spike_ID,timestamps];
                    %
                    % % set spikes to milliseconds %
                    % spikes(:,2) = round((spikes(:,2)./30),2);
                    %
                    % % loop through spike IDs
                    % IDlist = unique(spike_ID);
                    % for spikeID = 1:length(IDlist)
                    %     % pull the list of time stamps for this ID
                    %     thisID    = spikes(spikes(:,1)==IDlist(spikeID),:);
                    %     % generate correlogram
                    %     [c,lags] = xcorr(timestamps);
                    %     stem(lags,c)
                    %     hist(lags,50)
                    %
                    % end



                else
                    disp([subname ' ' Condition{iStimType} ' allego data missing: ' allegofile])
                end % check file exists
            end % stim count
        end % stim type
    end % subject
end % group
cd(homedir)