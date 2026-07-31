function DynamicSpikes(homedir, Group, Condition,type)
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
                datafile = [subname '_' measurement '_Spikes'];
                % skip empty measurements
                if exist(allegofile,'file')

                    disp(datafile)

                    % Layers
                    L.II = str2num(Layer.II{iSub});
                    L.IV = str2num(Layer.IV{iSub});
                    L.Va = str2num(Layer.Va{iSub});
                    L.Vb = str2num(Layer.Vb{iSub});
                    L.VI = str2num(Layer.VI{iSub});
                    Layers = fieldnames(L);

                    % labels - which neuron (not currently used)
                    % ntvldxs - which channel (0 - 31 == 1 - 32)
                    % timestamps - what time (s)
                    % load([datafile '_s0.mat'],'ntvIdxs','timestamps')

                    % neuronexus data converter for matlab to get timing data
                    % stimIn contains stimulus onset data at fs = 1000
                    % files needed here are:
                    % *_Spikes.xdat.json
                    % *_Spikes_data.xdat (the big one)
                    % *_Spikes_timestamp.xdat
                    [timerange,stimIn] = FileReaderSpike(datafile);

                    % organize spikes into full length raster
                    [spikeMatrix] = irasterdata(timerange,timestamps,ntvIdxs,chanorder);

                    BL      = 399;
                    % The next part depends on the stimulus; pull the
                    % relevant variSubbles
                    [stimList, thisUnit, stimDur, stimITI, thisTag] = ...
                        StimVariable(Condition{iStimType},1,type);

                    % now single triSubl stack it
                    if matches(thisTag ,'spont') || matches(thisTag,'single')
                        sngtrlSpikes = icutsingleraster(stimIn, spikeMatrix, BL, stimDur, stimITI, thisTag);
                    elseif matches(thisTag,'gapASSRRate') 
                        sngtrlSpikes = icutGAPrasters(datafile,stimIn, spikeMatrix, stimList, BL, stimDur, stimITI, thisTag);
                    else
                        sngtrlSpikes = icutrasters(datafile,stimIn, spikeMatrix, stimList, BL, stimDur, stimITI, thisTag);
                    end

                    %% Plot it

                    cd (homedir); cd figures;
                    if exist(['Single_' Group{iGro}],'dir') == 0
                        mkdir(['Single_' Group{iGro}])
                    end
                    cd(['Single_' Group{iGro}])

                    for iLay = 1:length(Layers)+1

                        PSTHfig = tiledlayout('flow');
                        if iLay == length(Layers)+1
                            title(PSTHfig,[subname ' ' Condition{iStimType} ' PSTH All Channels'])
                        else
                            title(PSTHfig,[subname ' ' Condition{iStimType} ' PSTH Layer ' Layers{iLay}])
                        end
                        xlabel(PSTHfig, 'time [ms]')
                        ylabel(PSTHfig, 'spike count / spike rate [s]')

                        for istim = 1:length(stimList)

                            % figure of psth's for all and layers per stim
                            trlsum   = sum(sngtrlSpikes{istim},3);

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
                            savefig(h,[subname '_' Condition{iStimType} '_PSTH_AllChan'],'compact')
                        else
                            savefig(h,[subname '_' Condition{iStimType}  '_PSTH_Lay' Layers{iLay}],'compact')
                        end
                        close (h)
                    end

                    heatmapfig = tiledlayout('flow');
                    title(heatmapfig,[subname ' ' Condition{iStimType} ' Noiseburst Heatmap'])
                    xlabel(heatmapfig, 'time [ms]')
                    ylabel(heatmapfig, 'depth [channels]')

                    for istim = 1:length(stimList)
                        nexttile

                        imagesc((sum(sngtrlSpikes{istim},3)*-1))
                        title([num2str(stimList(istim)) thisUnit])
                        colormap('gray')

                        xlim([0 length(layersum)])
                        xticks(0:200:length(layersum))
                        labellist = xticks;
                        xticklabels(labellist)

                    end

                    colorbar

                    h = gcf;
                    savefig(h,[subname '_' Condition{iStimType} '_Heatmap' ],'compact')
                    close (h)

                    %% Save and Quit
                    % identifiers and basic info
                    SpikeData(CondIDX).measurement   = datafile;
                    SpikeData(CondIDX).Condition     = [Condition{iStimType} '_' num2str(iStimCount)];
                    SpikeData(CondIDX).BL            = BL;
                    SpikeData(CondIDX).stimDur       = stimDur;
                    SpikeData(CondIDX).StimList      = stimList;

                    % spike data
                    SpikeData(CondIDX).SortedSpikes  = sngtrlSpikes;
                    SpikeData(CondIDX).ContSpikes    = spikeMatrix;
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