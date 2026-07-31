
%% ADD rows to this table as needed, used for AllegoLookup.m function

tabsize = [100 3]; 
ATab = table(Size=tabsize,VariableNames=["Subject","Measurement","AllegoName"],...
    VariableTypes=["string","string","string"]);

ATab(1,:) = {'VMP06','04','allego_3__uid0213-12-21-21'};
ATab(2,:) = {'VMP06','05','allego_4__uid0213-12-30-28'};

save('AllegoTable','ATab') % make sure this overwrites the table in the 
                            % groups folder (you could do that
                            % automatically by bringing in the home
                            % directory and assigning the save folder but
                            % I'm being lazy right now)