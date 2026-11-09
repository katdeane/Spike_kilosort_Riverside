function SpikeFigsCut(homedir,figfold,Group1,Group2)

% load in data generated from Group_Avg_raster.m
load([Group1 '_Normspikedetection_ALL.mat'],'ALLt')
Grp1 = struct2table(ALLt);
% average the channels now, fano factor already calculated
Grp1.trlspikerate   = cellfun(@nanmean, Grp1.trlspikerate, 'UniformOutput', false);
Grp1.avgspikerate   = cellfun(@nanmean, Grp1.avgspikerate, 'UniformOutput', false);
Grp1.trlspikecount  = cellfun(@nanmean, Grp1.trlspikecount, 'UniformOutput', false);
Grp1.avgspikecount  = cellfun(@nanmean, Grp1.avgspikecount, 'UniformOutput', false);
Grp1.trlPREcount    = cellfun(@nanmean, Grp1.trlPREcount, 'UniformOutput', false);
Grp1.trlONSETcount  = cellfun(@nanmean, Grp1.trlONSETcount, 'UniformOutput', false);
Grp1.trlPOSTcount   = cellfun(@nanmean, Grp1.trlPOSTcount, 'UniformOutput', false);
Grp1.avgPREcount    = cellfun(@nanmean, Grp1.avgPREcount, 'UniformOutput', false);
Grp1.avgONSETcount  = cellfun(@nanmean, Grp1.avgONSETcount, 'UniformOutput', false);
Grp1.avgPOSTcount   = cellfun(@nanmean, Grp1.avgPOSTcount, 'UniformOutput', false);
Grp1.Fanofactor     = cellfun(@nanmean, Grp1.Fanofactor, 'UniformOutput', false);
Grp1.FanoPRE        = cellfun(@nanmean, Grp1.FanoPRE, 'UniformOutput', false);
Grp1.FanoONSET      = cellfun(@nanmean, Grp1.FanoONSET, 'UniformOutput', false);
Grp1.FanoPOST       = cellfun(@nanmean, Grp1.FanoPOST, 'UniformOutput', false);

load([Group2 '_Normspikedetection_ALL.mat'],'ALLt')
Grp2 = struct2table(ALLt);
% average the channels now, fano factor already calculated
Grp2.trlspikerate   = cellfun(@nanmean, Grp2.trlspikerate, 'UniformOutput', false);
Grp2.avgspikerate   = cellfun(@nanmean, Grp2.avgspikerate, 'UniformOutput', false);
Grp2.trlspikecount  = cellfun(@nanmean, Grp2.trlspikecount, 'UniformOutput', false);
Grp2.avgspikecount  = cellfun(@nanmean, Grp2.avgspikecount, 'UniformOutput', false);
Grp2.trlPREcount    = cellfun(@nanmean, Grp2.trlPREcount, 'UniformOutput', false);
Grp2.trlONSETcount  = cellfun(@nanmean, Grp2.trlONSETcount, 'UniformOutput', false);
Grp2.trlPOSTcount   = cellfun(@nanmean, Grp2.trlPOSTcount, 'UniformOutput', false);
Grp2.avgPREcount    = cellfun(@nanmean, Grp2.avgPREcount, 'UniformOutput', false);
Grp2.avgONSETcount  = cellfun(@nanmean, Grp2.avgONSETcount, 'UniformOutput', false);
Grp2.avgPOSTcount   = cellfun(@nanmean, Grp2.avgPOSTcount, 'UniformOutput', false);
Grp2.Fanofactor     = cellfun(@nanmean, Grp2.Fanofactor, 'UniformOutput', false);
Grp2.FanoPRE        = cellfun(@nanmean, Grp2.FanoPRE, 'UniformOutput', false);
Grp2.FanoONSET      = cellfun(@nanmean, Grp2.FanoONSET, 'UniformOutput', false);
Grp2.FanoPOST       = cellfun(@nanmean, Grp2.FanoPOST, 'UniformOutput', false);

CondList = unique(Grp1.condition);
LayList  = {'All' 'II' 'IV' 'Va' 'Vb' 'VI'};

for iCond = 1:length(CondList)
    % breakout the condition data (i.e. 'NoiseBurst')
    Gpr1Cond = Grp1(matches(Grp1.condition,CondList{iCond}),:);
    Gpr2Cond = Grp2(matches(Grp2.condition,CondList{iCond}),:);

    StimList = unique(Gpr1Cond.stimulus);
    ratediv = 0.1; postratediv = 0.1; % 100 ms windows
    if matches(CondList{iCond},'gapASSR') || matches(CondList{iCond},'ClickTrain')
        postratediv = 0.45; % 450 ms windows
    elseif matches(CondList{iCond},'Chirp')
        postratediv = 2; % 2 s windows
    end

    for iStim = 1:length(StimList)
        % further breakout the stimulus data (i.e. 20 dB)
        Grp1Stim = Gpr1Cond(Gpr1Cond.stimulus == StimList(iStim),:);
        Grp2Stim = Gpr2Cond(Gpr2Cond.stimulus == StimList(iStim),:);

        % make a figure for all layers
        spikefig = tiledlayout('flow');
        title(spikefig,[Group1 'v' Group2 ' ' CondList{iCond} ' ' ...
            num2str(StimList(iStim)) ' cut spike data'])

        for iLay = 1:length(LayList)

            Grp1Lay = Grp1Stim(matches(Grp1Stim.layer,LayList{iLay}),:);
            Grp2Lay = Grp2Stim(matches(Grp2Stim.layer,LayList{iLay}),:);

            xdat = [[Grp1Lay.avgPREcount{:}]'/ratediv;  [Grp2Lay.avgPREcount{:}]'/ratediv];
            ydat = [repmat({Group1},length(Grp1Lay.avgspikerate),1); ...
                repmat({Group2},length(Grp2Lay.avgspikerate),1)];

            nexttile
            boxplot(xdat,ydat)
            title(Grp1Lay.layer{1})
            ylabel('Spike Count Pre Stim')

            xdat = [[Grp1Lay.FanoPRE{:}]';  [Grp2Lay.FanoPRE{:}]'];
            ydat = [repmat({Group1},length(Grp1Lay.avgspikerate),1); ...
                repmat({Group2},length(Grp2Lay.avgspikerate),1)];

            nexttile
            boxplot(xdat,ydat)
            title(Grp1Lay.layer{1})
            ylabel('Fano factor Pre Stim')

            xdat = [[Grp1Lay.avgONSETcount{:}]'/ratediv;  [Grp2Lay.avgONSETcount{:}]'/ratediv];
            ydat = [repmat({Group1},length(Grp1Lay.avgspikerate),1); ...
                repmat({Group2},length(Grp2Lay.avgspikerate),1)];

            nexttile
            boxplot(xdat,ydat)
            title(Grp1Lay.layer{1})
            ylabel('Spike Count Stim Onset')

            xdat = [[Grp1Lay.FanoONSET{:}]';  [Grp2Lay.FanoONSET{:}]'];
            ydat = [repmat({Group1},length(Grp1Lay.avgspikerate),1); ...
                repmat({Group2},length(Grp2Lay.avgspikerate),1)];

            nexttile
            boxplot(xdat,ydat)
            title(Grp1Lay.layer{1})
            ylabel('Fano factor Stim Onset')

            xdat = [[Grp1Lay.avgPOSTcount{:}]'/postratediv;  [Grp2Lay.avgPOSTcount{:}]'/postratediv];
            ydat = [repmat({Group1},length(Grp1Lay.avgspikerate),1); ...
                repmat({Group2},length(Grp2Lay.avgspikerate),1)];

            nexttile
            boxplot(xdat,ydat)
            title(Grp1Lay.layer{1})
            ylabel('Spike Count Post Onset')

            xdat = [[Grp1Lay.FanoPOST{:}]';  [Grp2Lay.FanoPOST{:}]'];
            ydat = [repmat({Group1},length(Grp1Lay.avgspikerate),1); ...
                repmat({Group2},length(Grp2Lay.avgspikerate),1)];

            nexttile
            boxplot(xdat,ydat)
            title(Grp1Lay.layer{1})
            ylabel('Fano factor Post Onset')
            

        end % layer

        cd(figfold)
        if ~exist('SpikeFigs','dir')
            mkdir('SpikeFigs')
        end
        cd SpikeFigs
        h = gcf;
        savefig(h,[Group1 'v' Group2 '_' CondList{iCond} '_' ...
            num2str(StimList(iStim)) '_cut'])
        close(h)


    end % stimulus
end

cd(homedir)