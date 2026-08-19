function DynamicSpikes_byID(homedir, figfold, Group, Condition,type)
%% Reconstruct Spiking Data

%datachecks
if ~exist('Group','var')
    Group = {'MWT','MKO'};
end
if ~exist('Condition', 'var')
    Condition = {'NoiseBurst','ClickTrain'};
end
if ~exist('homedir','var')
    print('Do better.')
end

% run this to avoid saving things in scientific notation
format longG

for iGro = 1:length(Group)

    run([Group{iGro} '.m']); % brings animals channels Cond Condition Layer
    Indexer = imakeIndexer(Condition,animals,Cond); %#ok<*USENS>

    for iSub = 1:length(animals)

        subname = animals{iSub};
        chanorder = str2num(channels{iSub});

        % initialize save data
        load([subname '_SpikeData'],'SpikeData')

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

                    L.II = str2num(Layer.II{iSub});
                    Ld.II = ((L.II .* 50) - 50)*-1; % convert to depth
                    L.IV = str2num(Layer.IV{iSub});
                    Ld.IV = ((L.IV .* 50) - 50)*-1;
                    L.Va = str2num(Layer.Va{iSub});
                    Ld.Va = ((L.Va .* 50) - 50)*-1;
                    L.Vb = str2num(Layer.Vb{iSub});
                    Ld.Vb = ((L.Vb .* 50) - 50)*-1;
                    L.VI = str2num(Layer.VI{iSub});
                    Ld.VI = ((L.VI .* 50) - 50)*-1;
                    Layers = fieldnames(L);

                    % navigate to kilo output %
                    cd(homedir);cd Data
                    subfolders = dir;
                    subfolders = {subfolders.name}';
                    thisfolder = subfolders(contains(subfolders,[animals{iSub} '_kilo']));
                    thisfolder = thisfolder{:};
                    cd(thisfolder)
                    cd(allegofile)

                    % load data in %
                    % clear spikes
                    templates  = double(readNPY('templates.npy')); % pull the kilo spike template data
                    locations  = double(readNPY('spike_positions.npy')); % location of spike in microns
                    timestamps = double(readNPY('spike_times.npy')); % time of spike peak in fs=30k
                    kilochanpos= double(readNPY('channel_positions.npy')); % position of channels from kilosort
                    map        = readNPY('channel_map.npy');
                    spike_ID   = double(readNPY('spike_clusters.npy')); %
                    spikes = [spike_ID,timestamps,locations(:,2)];

                    % set spikes to microseconds %
                    spikes(:,2) = round((spikes(:,2)./10),2);

                    % sort out channels/locations % - note: channels are already
                    % mapped correct to the actual depth
                    % which channels we took in during CSD:
                    chandepths = kilochanpos(find(map==chanorder(1)-1):find(map==chanorder(end)-1),2);
                    % find the top and bottom
                    depthstart = max(chandepths);
                    depthend   = min(chandepths)-depthstart;
                    % move the spike locations up to match depth from top
                    % channel
                    spikes(:,3) = spikes(:,3) - depthstart; % top of cortex = 0
                    spikes = spikes(spikes(:,3)<25,:); % cut off locations above cortex (allow wiggle room)
                    spikes = spikes(spikes(:,3)>(depthend-25),:); % cut off locations below lowest channel (allow wiggle room)
                    % sanity check; plot all spikes in continuous data:
                    % plot(spikes(:,2),spikes(:,3),'.')

                    % add lfp data (fs=1000) just for stimulus channel
                    stimIn = FileReaderStimChan(datafile);

                    IDlist = unique(spikes(:,1)); % only look at spikes kept after cortical layer size determined
                    % loop through spike IDs
                    for iID = 1:length(IDlist)

                        thisspike = spikes(spikes(:,1)==IDlist(iID),:);
                        % organize spikes into full length raster
                        [spikeMatrix] = irasterdata(thisspike,Ld);

                        % spikeMatrix is currently as long as it's last
                        % spike timestamp. However, onsets may exist beyond
                        % that, which will throw an error below. We'll padd
                        % the end with zeros up to the size of the stimIn
                        % variable (updated from fs=1000 to fs=3000)
                        if size(spikeMatrix,2) < (size(stimIn,2)*3)
                            padlength = (size(stimIn,2)*3) - size(spikeMatrix,2);
                            padheight = size(spikeMatrix,1);
                            spikeMatrix = [spikeMatrix zeros(padheight,padlength)];
                        end

                        % baseline is 400 ms
                        BL      = 400;
                        % The next part depends on the stimulus; pull the
                        % relevant variables
                        [stimList, thisUnit, stimDur, stimITI, thisTag] = ...
                            StimVariable(Condition{iStimType},1,type);

                        % now single trial stack it TO DO - update gap and
                        % single rasters to new data type as is done with
                        % icutrasters
                        if matches(thisTag ,'spont') || matches(thisTag,'single')
                            sngtrlSpikes = icutsingleraster(stimIn, spikeMatrix, BL, stimDur, stimITI, thisTag);
                        elseif matches(thisTag,'gapASSRRate')
                            sngtrlSpikes = icutGAPrasters(datafile,stimIn, spikeMatrix, stimList, BL, stimDur, stimITI, thisTag);
                        else
                            sngtrlSpikes = icutrasters(datafile,stimIn, spikeMatrix, stimList, BL, stimDur, stimITI, thisTag);
                        end

                        %% Plot it

                        cd(figfold)
                        if exist(['SpikeID_' Group{iGro}],'dir') == 0
                            mkdir(['SpikeID_' Group{iGro}])
                        end
                        % so as not to be incredibly obnoxious
                        cd(['SpikeID_' Group{iGro}])
                        if exist(['SpikeID_' subname],'dir') == 0
                            mkdir(['SpikeID_' subname])
                        end
                        cd(['SpikeID_' subname])

                        % psth figures per stimulus, if multiple
                        PSTHfig = tiledlayout('flow');
                        title(PSTHfig,[subname ' ' Condition{iStimType} ' PSTH Spike ID ' num2str(IDlist(iID))])
                        xlabel(PSTHfig, 'time [ms]')
                        ylabel(PSTHfig, 'spike count / spike rate [s]')

                        for istim = 1:length(stimList)

                            % figure of psth's for all and layers per stim
                            trlsum   = sum(sngtrlSpikes{istim},3);
                            chansum  = sum(trlsum,1);
                            
                            % get spiking rate per second
                            spikerate = sum(chansum) / ((length(chansum))/1000);
                            %adjust your raster by spiking rate
                            adjlaysum = chansum ./ spikerate;

                            % now add the tile
                            nexttile
                            bar(adjlaysum,30,'histc')
                            title([num2str(stimList(istim)) thisUnit])
                            xlim([0 length(chansum)])
                            xticks(0:600:length(chansum))
                            xticklabels(xticks/3)

                        end

                        % template 
                        thistemplate = squeeze(templates(iID,:,:)); % assuming spikes are listed in order from 0, which is how the IDlist is automatically ordered from 'unique'
                        % get just the highest rms channel for plotting
                        bestchan     = find(max(rms(thistemplate,1))==rms(thistemplate,1));
                        
                        nexttile
                        plot(thistemplate(:,bestchan))
                        title(['Spike Template; chan ' num2str(bestchan)])
                        xticks(0:20:60)
                        xticklabels(round(xticks/30,2))

                        h = gcf;
                        thislocation = num2str(round(mean(thisspike(:,3))));
                        savefig(h,[subname '_' Condition{iStimType} '_SpikeID_' num2str(IDlist(iID)) '_loc' thislocation])
                        close (h)

                        %% Save and Quit

                        % individual spike ID data (follows the same
                        % indexing as the DynamicSpikes.m function)
                        % SpikeData(CondIDX).(['ID' num2str(IDlist(iID)) '_list']) = spikes; this makes the data way too big, matlab is unable to contain the memory to hold it if there are enough spikes
                        SpikeData(CondIDX).(['ID' num2str(IDlist(iID)) '_raster']) = sngtrlSpikes;
                        clear spikes sngtrlSpikes
                    end
                else
                    disp([subname ' ' Condition{iStimType} ' allego data missing: ' allegofile])
                end % check file exists
            end % stim count
        end % stim type

        % save over existing SpikeData file
        if exist('SpikeData','var')
            cd(homedir);
            cd datastructs
            save([subname '_SpikeData'],'SpikeData');
            clear SpikeData
            cd(homedir)
        end

    end % subject
end % group
cd(homedir)