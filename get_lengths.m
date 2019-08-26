function [TRAINING_LENGTH, CLASSIFICATION_LENGTH, EMTS_LENGTH, EMTS, FEATURE_LENGTH, CLASSIFICATION_COL] = get_lengths(DATA, PARAMETERS)
%GET_LENGTHS - calculates the number of training and classification sets and the index of the column, that is used
% to classify the data.
%
% these calculations are needed for all classifiers
if exist('PARAMETERS','var') == 0 || isfield(PARAMETERS,'METHA_LENGTH') == 0
    if isfield(DATA,'METHA_LENGTH')
        METHA_LENGTH = DATA.METHA_LENGTH;
    else
        METHA_LENGTH = 1;
    end
else
    METHA_LENGTH = PARAMETERS.METHA_LENGTH;
end

if exist('DATA','var') == 1 && isfield(DATA,'TRAINING') == 1
    TRAINING_LENGTH = size(DATA.TRAINING,1);
    FEATURE_LENGTH  = size(DATA.TRAINING,2) - METHA_LENGTH;
else
    TRAINING_LENGTH = 0;
end

if exist('DATA','var') == 1 && isfield(DATA,'CLASSIFICATION') == 1 && ~isempty(DATA.CLASSIFICATION)
    CLASSIFICATION_LENGTH = size(DATA.CLASSIFICATION,1);
    FEATURE_LENGTH  = size(DATA.CLASSIFICATION,2) - METHA_LENGTH;
else
    CLASSIFICATION_LENGTH = 0;
end

if exist('DATA','var') == 1 && isfield(DATA,'FEATURES') == 1
    FEATURE_LENGTH = size(DATA.FEATURES,2) - METHA_LENGTH;
end

if exist('PARAMETERS','var') == 0 || isfield(PARAMETERS,'CLASSIFICATION_COL') == 0
    CLASSIFICATION_COL = FEATURE_LENGTH + 1;
else
    CLASSIFICATION_COL = FEATURE_LENGTH + PARAMETERS.CLASSIFICATION_COL;
end

%% Determine EMTS and EMTS_LENGTH
EMTS = [];
if exist('DATA','var') == 1 && isfield(DATA,'TRAINING') == 1
    EMTS = double(unique(full(DATA.TRAINING(:,CLASSIFICATION_COL))));
end

if exist('DATA','var') == 1 && isfield(DATA,'FEATURES') == 1
    EMTS = double(unique(full(DATA.FEATURES(:,CLASSIFICATION_COL))));
end

%if exist('DATA','var') == 1 && isfield(DATA,'CLASSIFICATION') == 1
%    EMTS = unique([EMTS;DATA.CLASSIFICATION(:,CLASSIFICATION_COL)]);
%end

EMTS_LENGTH = length(EMTS);