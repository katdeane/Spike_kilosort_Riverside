function DynamicSpikes(homedir, figfold, Group, Condition,type)
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
                allegofile  = AllegoLookup(animals{iSub},measurement);
                datafile = [subname '_' measurement '_LFP'];
                % skip empty measurements
                if exist(allegofile,'file')

                    disp(datafile)

                    % Layers
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
                    clear spikes
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

                    % split muas and single units into their own lists
                    [muas,suss] = splitKSlabels(spikes);

                    
                    % add lfp data (fs=1000) just for stimulus channel
                    stimIn = FileReaderStimChan(datafile);
                    
                    % organize spikes into full length raster
                    [spikeMatrix] = irasterdata(spikes,Ld);
                    [muaMatrix]   = irasterdata(muas,Ld);
                    [susMatrix]   = irasterdata(suss,Ld);
                    
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
                        sngtrlMUA    = icutsingleraster(stimIn, muaMatrix, BL, stimDur, stimITI, thisTag);
                        sngtrlSUS    = icutsingleraster(stimIn, susMatrix, BL, stimDur, stimITI, thisTag);
                    elseif matches(thisTag,'gapASSRRate') 
                        sngtrlSpikes = icutGAPrasters(datafile,stimIn, spikeMatrix, stimList, BL, stimDur, stimITI, thisTag);
                        sngtrlMUA    = icutGAPrasters(datafile,stimIn, muaMatrix, stimList, BL, stimDur, stimITI, thisTag);
                        sngtrlSUS    = icutGAPrasters(datafile,stimIn, susMatrix, stimList, BL, stimDur, stimITI, thisTag);
                    else
                        sngtrlSpikes = icutrasters(datafile,stimIn, spikeMatrix, stimList, BL, stimDur, stimITI, thisTag);
                        sngtrlMUA    = icutrasters(datafile,stimIn, muaMatrix, stimList, BL, stimDur, stimITI, thisTag);
                        sngtrlSUS    = icutrasters(datafile,stimIn, susMatrix, stimList, BL, stimDur, stimITI, thisTag);
                    end

                    %% Plot it

                    cd(figfold)
                    if exist(['Single_' Group{iGro}],'dir') == 0
                        mkdir(['Single_' Group{iGro}])
                    end
                    cd(['Single_' Group{iGro}])

                    plotdata = {sngtrlSpikes sngtrlMUA sngtrlSUS}; plotlabel = {'All' 'MUA' 'SUS'};
                   
                    for iLabel = 1:length(plotlabel)

                        thisdata = plotdata{iLabel}; % all units, muas, or single units

                        for iLay = 1:length(Layers)+1

                            PSTHfig = tiledlayout('flow');
                            if iLay == length(Layers)+1
                                title(PSTHfig,[subname ' ' Condition{iStimType} ' PSTH All Channels ' plotlabel{iLabel} ' Spikes'])
                            else
                                title(PSTHfig,[subname ' ' Condition{iStimType} ' PSTH Layer ' Layers{iLay} ' ' plotlabel{iLabel} ' Spikes'])
                            end
                            xlabel(PSTHfig, 'time [ms]')
                            ylabel(PSTHfig, 'spike count / spike rate [s]')

                            for istim = 1:length(stimList)

                                % figure of psth's for all and layers per stim
                                trlsum   = sum(thisdata{istim},3);

                                if iLay == length(Layers)+1
                                    % raster summing all channels or layer channels
                                    layersum  = sum(trlsum,1);
                                else
                                    % raster summing all channels or layer channels
                                    layersum  = sum(trlsum(L.(Layers{iLay}),:),1);
                                end

                                % get spiking rate per second
                                spikerate = sum(layersum) / ((length(layersum))/1000);
                                %adjust your raster by spiking rate
                                adjlaysum = layersum ./ spikerate;

                                % now add the tile
                                nexttile
                                bar(adjlaysum,30,'histc')
                                title([num2str(stimList(istim)) thisUnit])
                                xlim([0 length(layersum)])
                                xticks(0:200:length(layersum))
                                labellist = xticks;
                                xticklabels(labellist)

                            end

                            h = gcf;
                            if iLay == length(Layers)+1
                                savefig(h,[subname '_' Condition{iStimType} '_' plotlabel{iLabel} '_PSTH_AllChan'])
                            else
                                savefig(h,[subname '_' Condition{iStimType} '_' plotlabel{iLabel} '_PSTH_Lay' Layers{iLay}])
                            end
                            close (h)
                        end

                        heatmapfig = tiledlayout('flow');
                        title(heatmapfig,[subname ' ' Condition{iStimType} ' Noiseburst Heatmap ' plotlabel{iLabel} ' Spikes'])
                        xlabel(heatmapfig, 'time [ms]')
                        ylabel(heatmapfig, 'depth [channels]')

                        for istim = 1:length(stimList)
                            nexttile

                            imagesc((sum(thisdata{istim},3)*-1))
                            title([num2str(stimList(istim)) thisUnit])
                            colormap('gray')

                            xlim([0 length(layersum)])
                            xticks(0:200:length(layersum))
                            labellist = xticks;
                            xticklabels(labellist)

                        end

                        colorbar

                        h = gcf;
                        savefig(h,[subname '_' Condition{iStimType} '_' plotlabel{iLabel} '_Heatmap' ])
                        close (h)

                    end
                    
                    %% Save and Quit
                    % identifiers and basic info
                    SpikeData(CondIDX).measurement = datafile;
                    SpikeData(CondIDX).Condition   = [Condition{iStimType} '_' num2str(iStimCount)];
                    SpikeData(CondIDX).BL          = BL;
                    SpikeData(CondIDX).stimDur     = stimDur;
                    SpikeData(CondIDX).StimList    = stimList;

                    % spike data
                    SpikeData(CondIDX).AllRaster   = sngtrlSpikes;
                    SpikeData(CondIDX).AllList     = spikes;
                    SpikeData(CondIDX).MUARaster   = sngtrlMUA;
                    SpikeData(CondIDX).MUAList     = muas;
                    SpikeData(CondIDX).SUSRaster   = sngtrlSUS;
                    SpikeData(CondIDX).SUSList     = suss;
                    SpikeData(CondIDX).Templates   = templates;

                end % check file exists
            end % stim count
        end % stim type

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