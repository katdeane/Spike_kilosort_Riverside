%% ADD rows to this table as needed, used for AllegoLookup.m function

% 1 minor possibility, which we have been intentionally avoiding up to this
% point, is that the allego file does not contain the year in the name,
% meaning that technically it's possible for files to share the same name
% across years. As the name does contain time info down to the second, it's
% unlikely that the same number would be run on the exact same date and
% time from one year to the next. However, if an error occurs where a file
% does not seem to have been collected properly, CHECK MANUALLY for this
% case. (copy and find all 'uidmmdd-hh-mm-ss')

tabsize = [250 3]; 
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

ATab(93,:) = {'AWT01','03','allego_2__uid0530-14-38-12'};
ATab(94,:) = {'AWT01','04','allego_3__uid0530-14-41-00'};
ATab(95,:) = {'AWT01','05','allego_4__uid0530-14-43-21'};
ATab(96,:) = {'AWT01','06','allego_5__uid0530-14-49-33'};
ATab(97,:) = {'AWT01','07','allego_6__uid0530-15-06-28'};
ATab(98,:) = {'AWT01','08','allego_7__uid0530-15-19-19'};

ATab(99,:) = {'AWT02','02','allego_1__uid0531-10-52-40'};
ATab(100,:) = {'AWT02','03','allego_2__uid0531-10-56-17'};
ATab(101,:) = {'AWT02','04','allego_3__uid0531-10-58-29'};
ATab(102,:) = {'AWT02','05','allego_4__uid0531-11-11-14'};
ATab(103,:) = {'AWT02','06','allego_5__uid0531-11-17-25'};
ATab(104,:) = {'AWT02','07','allego_6__uid0531-11-24-12'};
ATab(105,:) = {'AWT02','08','allego_7__uid0531-11-41-07'};

ATab(106,:) = {'AWT06','02','allego_0__uid0621-11-26-14'};
ATab(107,:) = {'AWT06','03','allego_1__uid0621-11-29-40'};
ATab(108,:) = {'AWT06','04','allego_2__uid0621-11-32-36'};
ATab(109,:) = {'AWT06','05','allego_3__uid0621-11-39-24'};
ATab(110,:) = {'AWT06','06','allego_0__uid0621-11-47-32'};
ATab(111,:) = {'AWT06','07','allego_1__uid0621-12-00-26'};
ATab(112,:) = {'AWT06','08','allego_2__uid0621-12-17-25'};

ATab(113,:) = {'AWT07','02','allego_4__uid0621-12-34-05'};
ATab(114,:) = {'AWT07','03','allego_5__uid0621-12-36-58'};
ATab(115,:) = {'AWT07','04','allego_6__uid0621-12-39-50'};
ATab(116,:) = {'AWT07','05','allego_7__uid0621-12-46-32'};
ATab(117,:) = {'AWT07','06','allego_8__uid0621-13-03-39'};
ATab(118,:) = {'AWT07','07','allego_9__uid0621-13-09-48'};
ATab(119,:) = {'AWT07','08','allego_10__uid0621-13-23-37'};

ATab(120,:) = {'AWT08','02','allego_12__uid0621-13-44-04'};
ATab(121,:) = {'AWT08','03','allego_14__uid0621-13-48-29'};
ATab(122,:) = {'AWT08','04','allego_15__uid0621-13-50-35'};
ATab(123,:) = {'AWT08','05','allego_16__uid0621-14-07-42'};
ATab(124,:) = {'AWT08','06','allego_17__uid0621-14-15-45'};
ATab(125,:) = {'AWT08','07','allego_18__uid0621-14-30-35'};
ATab(126,:) = {'AWT08','08','allego_19__uid0621-14-37-25'};

ATab(127,:) = {'AWT13','01','allego_24__uid0906-13-13-17'};
ATab(128,:) = {'AWT13','02','allego_25__uid0906-13-16-54'};
ATab(129,:) = {'AWT13','03','allego_26__uid0906-13-19-26'};
ATab(130,:) = {'AWT13','04','allego_27__uid0906-13-37-08'};
ATab(131,:) = {'AWT13','05','allego_28__uid0906-13-50-34'};
ATab(132,:) = {'AWT13','06','allego_29__uid0906-13-57-51'};
ATab(133,:) = {'AWT13','07','allego_30__uid0906-14-04-15'};

ATab(134,:) = {'AWT14','01','allego_31__uid0906-14-27-04'};
ATab(135,:) = {'AWT14','02','allego_32__uid0906-14-32-17'};
ATab(136,:) = {'AWT14','03','allego_33__uid0906-14-35-35'};
ATab(137,:) = {'AWT14','04','allego_34__uid0906-14-42-58'};
ATab(138,:) = {'AWT14','05','allego_35__uid0906-14-50-23'};
ATab(139,:) = {'AWT14','06','allego_36__uid0906-15-04-31'};
ATab(140,:) = {'AWT14','07','allego_37__uid0906-15-22-13'};

ATab(141,:) = {'AWT26','04','allego_3__uid0424-10-51-47'};
ATab(142,:) = {'AWT26','05','allego_4__uid0424-10-55-44'};
ATab(143,:) = {'AWT26','06','allego_5__uid0424-10-58-25'};
ATab(144,:) = {'AWT26','07','allego_6__uid0424-11-04-45'};
ATab(145,:) = {'AWT26','08','allego_7__uid0424-11-17-46'};
ATab(146,:) = {'AWT26','09','allego_8__uid0424-11-34-51'};
ATab(147,:) = {'AWT26','10','allego_9__uid0424-11-41-45'};

ATab(148,:) = {'AWT27','07','allego_16__uid0424-12-54-51'};
ATab(149,:) = {'AWT27','08','allego_17__uid0424-12-59-05'};
ATab(150,:) = {'AWT27','09','allego_18__uid0424-13-02-30'};
ATab(151,:) = {'AWT27','10','allego_19__uid0424-13-18-16'};
ATab(152,:) = {'AWT27','11','allego_20__uid0424-13-24-59'};
ATab(153,:) = {'AWT27','12','allego_21__uid0424-13-31-47'};
ATab(154,:) = {'AWT27','13','allego_22__uid0424-13-49-19'};

ATab(155,:) = {'AWT28','08','allego_31__uid0424-14-43-16'};
ATab(156,:) = {'AWT28','09','allego_32__uid0424-14-47-26'};
ATab(157,:) = {'AWT28','10','allego_33__uid0424-14-50-24'};
ATab(158,:) = {'AWT28','11','allego_34__uid0424-14-57-11'};
ATab(159,:) = {'AWT28','12','allego_35__uid0424-15-14-35'};
ATab(160,:) = {'AWT28','13','allego_36__uid0424-15-21-00'};
ATab(161,:) = {'AWT28','14','allego_37__uid0424-15-33-47'};

ATab(162,:) = {'CKH01','02','allego_1__uid0206-10-15-38'};
ATab(163,:) = {'CKH01','03','allego_2__uid0206-10-21-19'};
ATab(164,:) = {'CKH01','04','allego_3__uid0206-10-28-51'};
ATab(165,:) = {'CKH01','05','allego_4__uid0206-10-46-16'};
ATab(166,:) = {'CKH01','06','allego_5__uid0206-10-59-42'};
ATab(167,:) = {'CKH01','07','allego_6__uid0206-11-06-10'};
ATab(168,:) = {'CKH01','08','allego_7__uid0206-11-08-36'};

ATab(169,:) = {'CKH02','02','allego_4__uid0213-09-58-17'};
ATab(170,:) = {'CKH02','03','allego_5__uid0213-10-02-50'};
ATab(171,:) = {'CKH02','04','allego_6__uid0213-10-05-32'};
ATab(172,:) = {'CKH02','05','allego_7__uid0213-10-22-57'};
ATab(173,:) = {'CKH02','06','allego_8__uid0213-10-29-14'};
ATab(174,:) = {'CKH02','07','allego_9__uid0213-10-36-14'};
ATab(175,:) = {'CKH02','08','allego_10__uid0213-10-49-27'};

ATab(176,:) = {'CKH03','03','allego_1__uid0306-09-41-31'};
ATab(177,:) = {'CKH03','04','allego_2__uid0306-09-46-36'};
ATab(178,:) = {'CKH03','05','allego_3__uid0306-09-49-02'};
ATab(179,:) = {'CKH03','06','allego_4__uid0306-10-02-25'};
ATab(180,:) = {'CKH03','07','allego_5__uid0306-10-09-20'};
ATab(181,:) = {'CKH03','08','allego_6__uid0306-10-15-36'};
ATab(182,:) = {'CKH03','09','allego_7__uid0306-10-32-38'};

ATab(183,:) = {'CKH05','02','allego_1__uid0620-09-23-22'};
ATab(184,:) = {'CKH05','03','allego_2__uid0620-09-28-03'};
ATab(185,:) = {'CKH05','04','allego_3__uid0620-09-30-54'};
ATab(186,:) = {'CKH05','05','allego_4__uid0620-09-47-58'};
ATab(187,:) = {'CKH05','06','allego_5__uid0620-09-54-10'};
ATab(188,:) = {'CKH05','07','allego_6__uid0620-10-07-00'};
ATab(189,:) = {'CKH05','08','allego_7__uid0620-10-13-45'};

ATab(190,:) = {'CKH06','02','allego_1__uid0626-10-57-54'};
ATab(191,:) = {'CKH06','03','allego_2__uid0626-11-02-39'};
ATab(192,:) = {'CKH06','04','allego_3__uid0626-11-06-23'};
ATab(193,:) = {'CKH06','05','allego_4__uid0626-11-13-26'};
ATab(194,:) = {'CKH06','06','allego_5__uid0626-11-30-43'};
ATab(195,:) = {'CKH06','07','allego_6__uid0626-11-44-11'};
ATab(196,:) = {'CKH06','08','allego_7__uid0626-11-50-36'};

ATab(197,:) = {'CKH07','08','allego_7__uid0918-09-32-37'};
ATab(198,:) = {'CKH07','10','allego_9__uid0918-09-38-19'};
ATab(199,:) = {'CKH07','11','allego_10__uid0918-09-40-27'};
ATab(200,:) = {'CKH07','12','allego_0__uid0918-09-54-44'};
ATab(201,:) = {'CKH07','13','allego_1__uid0918-10-12-11'};
ATab(202,:) = {'CKH07','14','allego_2__uid0918-10-25-11'};
ATab(203,:) = {'CKH07','15','allego_3__uid0918-10-32-00'};

ATab(204,:) = {'CKH09','06','allego_4__uid1017-10-11-44'};
ATab(205,:) = {'CKH09','07','allego_5__uid1017-10-15-52'};
ATab(206,:) = {'CKH09','08','allego_6__uid1017-10-18-13'};
ATab(207,:) = {'CKH09','09','allego_7__uid1017-10-35-17'};
ATab(208,:) = {'CKH09','10','allego_8__uid1017-10-42-07'};
ATab(209,:) = {'CKH09','11','allego_9__uid1017-10-55-16'};
ATab(210,:) = {'CKH09','12','allego_10__uid1017-11-01-30'};

ATab(211,:) = {'CKH10','06','allego_0__uid1031-09-58-37'};
ATab(212,:) = {'CKH10','07','allego_1__uid1031-10-02-25'};
ATab(213,:) = {'CKH10','08','allego_2__uid1031-10-04-33'};
ATab(214,:) = {'CKH10','09','allego_3__uid1031-10-17-30'};
ATab(215,:) = {'CKH10','10','allego_4__uid1031-10-24-10'};
ATab(216,:) = {'CKH10','11','allego_5__uid1031-10-30-29'};
ATab(217,:) = {'CKH10','12','allego_6__uid1031-10-47-21'};

save('AllegoTable','ATab') % make sure this overwrites the table in the 
                            % groups folder (you could do that
                            % automatically by bringing in the home
                            % directory and assigning the save folder but
                            % I'm being lazy right now)