function EVAL_MATRIX = mean_classifier(DATA)
% implements a simple mean classifier
% returns:
% EVAL_MATRIX - a matrix containing the true and estimated labels for every
%               test sample in the CLASSIFICATION field of the DATA structure.

% % % % % % % % % %
% % Training Phase
% % % % % % % % % %

X_train = DATA.TRAINING(:,1:end-1);
y_train = DATA.TRAINING(:,end);
N_TRAIN = length(y_train);

% todo: trainings phase based on X and y
d = size(X_train,2);
labels = unique(y_train);
mu = zeros(numel(labels),d);
for c=1:numel(labels)
    mu(c,:) = mean(X_train(y_train==labels(c),:));
end


% % % % % % % % % %
% % Testing Phase
% % % % % % % % % %

X_test = DATA.CLASSIFICATION(:,1:end-1);
N_TEST = size(X_test,1);

% will contain the estimated labels in the first column and the true
% labels in the second column
EVAL_MATRIX = zeros(N_TEST,2);
EVAL_MATRIX(:,2) = DATA.CLASSIFICATION(:,end);

% todo: estimate the labels for the samples of the test set

dist = zeros(N_TEST,numel(labels));
for c=1:numel(labels)
    tmp = bsxfun(@minus,X_test,mu(c,:));
    dist(:,c) = sum(tmp.*tmp,2);
end

[dummy ind] = min(dist,[],2);
EVAL_MATRIX(:,1) = labels(ind);

