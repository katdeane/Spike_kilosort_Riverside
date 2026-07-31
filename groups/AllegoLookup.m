% allego / curate output look-up table
function fileout = AllegoLookup(subject,measurement)

%% VMP06
load('AllegoTable','ATab')

% find where the conditions are met
index = (matches(ATab.Subject,subject) & ...
    matches(ATab.Measurement,measurement));

fileout = ATab.AllegoName(index);
