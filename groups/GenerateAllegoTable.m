%% ADD rows to this table as needed, used for AllegoLookup.m function

% 1 minor possibility, which we have been intentionally avoiding up to this
% point, is that the allego file does not contain the year in the name,
% meaning that technically it's possible for files to share the same name
% across years. As the name does contain time info down to the second, it's
% unlikely that the same number would be run on the exact same date and
% time from one year to the next. However, if an error occurs where a file
% does not seem to have been collected properly, CHECK MANUALLY for this
% case. (copy and find all 'uidmmdd-hh-mm-ss')

tabsize = [100 3]; 
ATab = table(Size=tabsize,VariableNames=["Subject","Measurement","AllegoName"],...
    VariableTypes=["string","string","string"]);

ATab(1,:) = {'VMP06','04','allego_3__uid0213-12-21-21'};
ATab(2,:) = {'VMP06','05','allego_4__uid0213-12-30-28'};
ATab(3,:) = {'VMP06','06','allego_5__uid0213-12-56-41'};
ATab(4,:) = {'VMP06','07','allego_6__uid0213-12-59-08'};
ATab(5,:) = {'VMP06','08','allego_7__uid0213-13-07-03'};
ATab(6,:) = {'VMP06','09','allego_8__uid0213-13-16-20'};
ATab(7,:) = {'VMP06','10','allego_9__uid0213-13-32-52'};
ATab(8,:) = {'VMP06','11','allego_10__uid0213-14-00-07'};

ATab(9,:) = {'AKO02','04','allego_11__uid0513-10-28-14'};
ATab(10,:) = {'AKO02','05','allego_12__uid0513-10-30-59'};
ATab(11,:) = {'AKO02','06','allego_13__uid0513-10-33-06'};
ATab(12,:) = {'AKO02','07','allego_14__uid0513-10-45-52'};
ATab(13,:) = {'AKO02','08','allego_15__uid0513-10-52-06'};
ATab(14,:) = {'AKO02','09','allego_16__uid0513-10-58-52'};

ATab(15,:) = {'AKO03','02','allego_18__uid0513-11-36-05'};
ATab(16,:) = {'AKO03','03','allego_19__uid0513-11-39-41'};
ATab(17,:) = {'AKO03','04','allego_20__uid0513-11-42-07'};
ATab(18,:) = {'AKO03','05','allego_21__uid0513-11-59-02'};
ATab(19,:) = {'AKO03','06','allego_22__uid0513-12-11-57'};
ATab(20,:) = {'AKO03','07','allego_23__uid0513-12-18-18'};

ATab(21,:) = {'AKO04','02','allego_25__uid0513-12-42-34'};
ATab(22,:) = {'AKO04','03','allego_26__uid0513-12-46-13'};
ATab(23,:) = {'AKO04','04','allego_27__uid0513-12-48-17'};
ATab(24,:) = {'AKO04','05','allego_28__uid0513-12-55-02'};
ATab(25,:) = {'AKO04','06','allego_29__uid0513-13-08-13'};
ATab(26,:) = {'AKO04','07','allego_30__uid0513-13-25-09'};
ATab(27,:) = {'AKO04','08','allego_31__uid0513-13-31-20'};

ATab(28,:) = {'AKO05','02','allego_33__uid0513-13-57-03'};
ATab(29,:) = {'AKO05','03','allego_34__uid0513-14-00-35'};
ATab(30,:) = {'AKO05','04','allego_35__uid0513-14-03-11'};
ATab(31,:) = {'AKO05','05','allego_36__uid0513-14-09-24'};
ATab(32,:) = {'AKO05','06','allego_37__uid0513-14-26-26'};
ATab(33,:) = {'AKO05','07','allego_38__uid0513-14-33-11'};
ATab(34,:) = {'AKO05','08','allego_39__uid0513-14-50-58'};

ATab(35,:) = {'AKO06','04','allego_43__uid0513-15-25-31'};
ATab(36,:) = {'AKO06','05','allego_44__uid0513-15-28-15'};
ATab(37,:) = {'AKO06','06','allego_45__uid0513-15-30-36'};
ATab(38,:) = {'AKO06','07','allego_46__uid0513-15-37-29'};
ATab(39,:) = {'AKO06','08','allego_47__uid0513-15-43-47'};
ATab(40,:) = {'AKO06','09','allego_48__uid0513-15-59-18'};
ATab(41,:) = {'AKO06','10','allego_49__uid0513-16-16-12'};

ATab(42,:) = {'AKO08','03','allego_10__uid0516-10-23-34'};
ATab(43,:) = {'AKO08','04','allego_11__uid0516-10-27-09'};
ATab(44,:) = {'AKO08','05','allego_12__uid0516-10-44-06'};
ATab(45,:) = {'AKO08','06','allego_13__uid0516-10-50-17'};
ATab(46,:) = {'AKO08','07','allego_14__uid0516-11-03-29'};
ATab(47,:) = {'AKO08','08','allego_15__uid0516-11-10-16'};

ATab(48,:) = {'AKO09','03','allego_18__uid0516-11-41-02'};
ATab(49,:) = {'AKO09','04','allego_19__uid0516-11-43-47'};
ATab(50,:) = {'AKO09','05','allego_20__uid0516-11-45-53'};
ATab(51,:) = {'AKO09','06','allego_21__uid0516-11-52-04'};
ATab(52,:) = {'AKO09','07','allego_22__uid0516-12-04-51'};
ATab(53,:) = {'AKO09','08','allego_23__uid0516-12-11-41'};
ATab(54,:) = {'AKO09','09','allego_24__uid0516-12-28-49'};

ATab(55,:) = {'AKO10','06','allego_5__uid0612-09-53-18'};
ATab(56,:) = {'AKO10','07','allego_6__uid0612-09-56-14'};
ATab(57,:) = {'AKO10','08','allego_7__uid0612-09-58-36'};
ATab(58,:) = {'AKO10','09','allego_8__uid0612-10-04-52'};
ATab(59,:) = {'AKO10','10','allego_9__uid0612-10-17-43'};
ATab(60,:) = {'AKO10','11','allego_10__uid0612-10-34-43'};
ATab(61,:) = {'AKO10','12','allego_11__uid0612-10-41-30'};

ATab(62,:) = {'AKO11','02','allego_13__uid0612-11-10-22'};
ATab(63,:) = {'AKO11','03','allego_14__uid0612-11-13-37'};
ATab(64,:) = {'AKO11','04','allego_15__uid0612-11-15-44'};
ATab(65,:) = {'AKO11','05','allego_16__uid0612-11-28-37'};
ATab(66,:) = {'AKO11','06','allego_17__uid0612-11-45-35'};
ATab(67,:) = {'AKO11','07','allego_18__uid0612-11-52-22'};
ATab(68,:) = {'AKO11','08','allego_19__uid0612-11-58-34'};

ATab(69,:) = {'AKO12','02','allego_1__uid1025-13-20-41'};
ATab(70,:) = {'AKO12','03','allego_2__uid1025-13-25-32'};
ATab(71,:) = {'AKO12','04','allego_3__uid1025-13-28-02'};
ATab(72,:) = {'AKO12','05','allego_4__uid1025-13-34-38'};
ATab(73,:) = {'AKO12','06','allego_5__uid1025-13-52-06'};
ATab(74,:) = {'AKO12','07','allego_6__uid1025-14-05-24'};
ATab(75,:) = {'AKO12','08','allego_7__uid1025-14-12-18'};

ATab(76,:) = {'VMA01','02','allego_2__uid0413-14-11-34'};
ATab(77,:) = {'VMA01','03','allego_3__uid0413-14-15-30'};
ATab(78,:) = {'VMA01','04','allego_5__uid0413-14-18-25'};
ATab(79,:) = {'VMA01','05','allego_6__uid0413-14-24-59'};
ATab(80,:) = {'VMA01','06','allego_7__uid0413-14-48-34'};
ATab(81,:) = {'VMA01','07','allego_8__uid0413-14-54-48'};
ATab(82,:) = {'VMA01','08','allego_9__uid0413-15-12-00'};
ATab(83,:) = {'VMA01','09','allego_10__uid0413-15-24-52'};

ATab(84,:) = {'VMA04','02','allego_25__uid0505-13-58-57'};
ATab(85,:) = {'VMA04','03','allego_26__uid0505-14-04-01'};
ATab(86,:) = {'VMA04','04','allego_27__uid0505-14-08-28'};
ATab(87,:) = {'VMA04','05','allego_28__uid0505-14-12-23'};
ATab(88,:) = {'VMA04','06','allego_29__uid0505-14-18-48'};
ATab(89,:) = {'VMA04','07','allego_30__uid0505-14-25-06'};
ATab(90,:) = {'VMA04','08','allego_31__uid0505-14-38-24'};
ATab(91,:) = {'VMA04','09','allego_32__uid0505-15-02-15'};
ATab(92,:) = {'VMA04','10','allego_33__uid0505-15-20-24'};


save('AllegoTable','ATab') % make sure this overwrites the table in the 
                            % groups folder (you could do that
                            % automatically by bringing in the home
                            % directory and assigning the save folder but
                            % I'm being lazy right now)