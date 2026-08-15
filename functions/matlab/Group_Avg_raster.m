function Group_Avg_raster(homedir, figfold, outfold, Groups, Condition,type)

layers = {'II' 'IV' 'Va' 'Vb' 'VI'};

for iGro = 1:length(Groups)

    ALLt = struct;
    MUAt = struct;
    SUSt = struct;
    count  = 1; 

    run([Groups{iGro} '.m']) % brings in Layer channels animals Cond
    clear channels

    for iCond = 1:length(Condition)

        [stimList, thisUnit, stimDur, stimITI, ~] = ...
            StimVariable(Condition{iCond},3,type);
        
        if matches(Condition{iCond},'Spontaneous')
            timeaxis = stimDur + stimITI;
        else
            timeaxis = 1200 + stimDur + stimITI;
        end

        for iLay = 1:length(layers)+1

            if iLay == length(layers)+1
                layname = 'All';
            else
                layname = layers{iLay};
            end

            PSTHfig = tiledlayout('flow');
                title(PSTHfig,[Groups{iGro} ' ' Condition{iCond} ' PSTH Layer ' layname])

            xlabel(PSTHfig, 'time [ms]')
            ylabel(PSTHfig, 'average normalized spike count')

            for istim = 1:length(stimList)

                groupsumall    = zeros(1,timeaxis+1);
                groupsummua    = zeros(1,timeaxis+1);
                groupsumsus    = zeros(1,timeaxis+1);
                numsubjects = length(animals);

                for iSub = 1:length(animals)
                    disp(['For ' Condition{iCond} ' ' layname ' ' num2str(stimList(istim)) ' ' animals{iSub}])
                    % subject data
                    load([animals{iSub} '_SpikeData.mat'],'SpikeData')
                    % subject data index
                    index = StimIndex({SpikeData.Condition},Cond,iSub,Condition{iCond});
                    if isempty(index)
                        numsubjects = numsubjects - 1;
                        continue
                    end
                    % pull appropriate data
                    alldat = SpikeData(index).AllRaster{istim};
                    muadat = SpikeData(index).MUARaster{istim};
                    susdat = SpikeData(index).SUSRaster{istim};

                    % get subject average spike data
                    trlsumall = sum(alldat,3);
                    trlsummua = sum(muadat,3);
                    trlsumsus = sum(susdat,3);
                    if iLay == length(layers)+1 % all channels
                        thislay = 1:size(trlsumall,1);
                    else % layer channels
                        thislay = str2num(Layer.(layname){iSub});
                    end
                    layersumall  = sum(trlsumall(thislay,:),1); 
                    layersummua  = sum(trlsummua(thislay,:),1); 
                    layersumsus  = sum(trlsumsus(thislay,:),1); 
                    % normalize by number of channels
                    layersumall  = layersumall / length(thislay);
                    layersummua  = layersummua / length(thislay);
                    layersumsus  = layersumsus / length(thislay);

                    % add to group sum for later averaging of group
                    groupsumall = groupsumall + layersumall;
                    groupsummua = groupsummua + layersummua;
                    groupsumsus = groupsumsus + layersumsus;

                    % fill a struct for now (table later)
                    ALLt(count).group      = Groups{iGro};
                    ALLt(count).condition  = Condition{iCond};
                    ALLt(count).layer      = layname;
                    ALLt(count).stimulus   = stimList(istim);
                    ALLt(count).subject    = animals{iSub};

                    % now get some variables while we're here
                    % get spiking rate per second
                    [ALLt(count).trlspikerate,ALLt(count).avgspikerate,...
                        ALLt(count).trlspikecount, ALLt(count).avgspikecount,...
                        ALLt(count).trlPREcount,ALLt(count).trlONSETcount,...
                        ALLt(count).trlPOSTcount,ALLt(count).avgPREcount,...
                        ALLt(count).avgONSETcount,ALLt(count).avgPOSTcount,...
                        ALLt(count).Fanofactor,ALLt(count).FanoPRE,...
                        ALLt(count).FanoONSET,ALLt(count).FanoPOST] = ...
                        spikeDetection(alldat(thislay,:,:),Condition{iCond});

                    % fill a struct for now (table later)
                    MUAt(count).group      = Groups{iGro};
                    MUAt(count).condition  = Condition{iCond};
                    MUAt(count).layer      = layname;
                    MUAt(count).stimulus   = stimList(istim);
                    MUAt(count).subject    = animals{iSub};

                    % now get some variables while we're here
                    % get spiking rate per second
                    [MUAt(count).trlspikerate,MUAt(count).avgspikerate,...
                        MUAt(count).trlspikecount, MUAt(count).avgspikecount,...
                        MUAt(count).trlPREcount,MUAt(count).trlONSETcount,...
                        MUAt(count).trlPOSTcount,MUAt(count).avgPREcount,...
                        MUAt(count).avgONSETcount,MUAt(count).avgPOSTcount,...
                        MUAt(count).Fanofactor,MUAt(count).FanoPRE,...
                        MUAt(count).FanoONSET,MUAt(count).FanoPOST] = ...
                        spikeDetection(muadat(thislay,:,:),Condition{iCond});

                    % fill a struct for now (table later)
                    SUSt(count).group      = Groups{iGro};
                    SUSt(count).condition  = Condition{iCond};
                    SUSt(count).layer      = layname;
                    SUSt(count).stimulus   = stimList(istim);
                    SUSt(count).subject    = animals{iSub};

                    % now get some variables while we're here
                    % get spiking rate per second
                    [SUSt(count).trlspikerate,SUSt(count).avgspikerate,...
                        SUSt(count).trlspikecount, SUSt(count).avgspikecount,...
                        SUSt(count).trlPREcount,SUSt(count).trlONSETcount,...
                        SUSt(count).trlPOSTcount,SUSt(count).avgPREcount,...
                        SUSt(count).avgONSETcount,SUSt(count).avgPOSTcount,...
                        SUSt(count).Fanofactor,SUSt(count).FanoPRE,...
                        SUSt(count).FanoONSET,SUSt(count).FanoPOST] = ...
                        spikeDetection(susdat(thislay,:,:),Condition{iCond});
                    count = count + 1;
                end % subject

                groupsumall = groupsumall ./ numsubjects;
                groupsummua = groupsummua ./ numsubjects;
                groupsumsus = groupsumsus ./ numsubjects;

                % now add the tiles
                nexttile
                bar(groupsumall,2,'histc')
                title([num2str(stimList(istim)) thisUnit ' ALL'])
                xlim([0 length(layersumall)])
                xticks(0:600:length(layersumall))
                labellist = xticks;
                xticklabels(labellist/3)

                nexttile
                bar(groupsummua,2,'histc')
                title([num2str(stimList(istim)) thisUnit ' MUA'])
                xlim([0 length(layersumall)])
                xticks(0:600:length(layersumall))
                labellist = xticks;
                xticklabels(labellist/3)
                
                nexttile
                bar(groupsumsus,2,'histc')
                title([num2str(stimList(istim)) thisUnit ' SUS'])
                xlim([0 length(layersumall)])
                xticks(0:600:length(layersumall))
                labellist = xticks;
                xticklabels(labellist/3)


            end % stim

            cd(figfold)
            if ~exist('GroupPSTH','dir')
                mkdir('GroupPSTH')
            end
            cd GroupPSTH

            h = gcf;
            if iLay == length(layers)+1
                savefig(h,[Groups{iGro} '_' Condition{iCond} '_NormPSTH_AllChan'])
            else
                savefig(h,[Groups{iGro} '_' Condition{iCond}  '_NormPSTH_Lay' layname])
            end
            close (h)
        end % layer
    end % condition

    cd(outfold)
    if ~exist('SpikeDetection','dir')
        mkdir('SpikeDetection')
    end
    cd SpikeDetection
    save([Groups{iGro} '_Normspikedetection_ALL'],'ALLt')
    save([Groups{iGro} '_Normspikedetection_MUA'],'MUAt')
    save([Groups{iGro} '_Normspikedetection_SUS'],'SUSt')
end % group
cd(homedir)