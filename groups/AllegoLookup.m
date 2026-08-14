% allego / curate output look-up table
function fileout = AllegoLookup(subject,measurement)

%% VMP06
load('AllegoTable','ATab')

% find where the conditions are met
aindex = (matches(ATab.Subject,subject) & ...
    matches(ATab.Measurement,measurement));

if sum(aindex)==1 
    fileout = ATab.AllegoName(aindex);
elseif sum(aindex)==0
    fileout = 'not in allego lookup table';
else
    error('you have an issue here to solve')
end
