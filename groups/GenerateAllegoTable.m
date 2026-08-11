
%% ADD rows to this table as needed, used for AllegoLookup.m function

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

save('AllegoTable','ATab') % make sure this overwrites the table in the 
                            % groups folder (you could do that
                            % automatically by bringing in the home
                            % directory and assigning the save folder but
                            % I'm being lazy right now)