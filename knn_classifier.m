function [EVAL_MATRIX f MODEL] = knn_classifier(DATA,PARAMETERS)
% uses the KNNSEARCH method from matlab to implement the kNN classifier
% parameter:
% PARAMETERS.DISTANCE - see KNNSEARCH for a full list, default 'euclidean'
% PARAMETERS.K        - the number of nearest neighbors, default 10.

if ~exist('PARAMETERS','var') 
    PARAMETERS = struct();
end

[TRAINING_LENGTH, CLASSIFICATION_LENGTH, CLASSES_LENGTH, CLASSES, FEATURE_LENGTH, CLASSIFICATION_COL] = get_lengths(DATA, PARAMETERS);

if ~isfield(PARAMETERS,'DISTANCE')
    PARAMETERS.DISTANCE = 'euclidean';
end

if ~isfield(PARAMETERS,'K')
    PARAMETERS.K = 10;
end

MODEL.knn.X = DATA.TRAINING(:,1:FEATURE_LENGTH);
MODEL.knn.y = DATA.TRAINING(:,CLASSIFICATION_COL);
MODEL.knn.labels = CLASSES;
MODEL.knn.K = PARAMETERS.K;
MODEL.knn.dist = PARAMETERS.DISTANCE;
MODEL.FEATURE_LENGTH = FEATURE_LENGTH;
MODEL.TRAIN_ALGORITHM = @knn_classifier;
MODEL.TEST_ALGORITHM = @knn_classify;
MODEL.TRAIN_PARAMETERS = PARAMETERS;
MODEL.CLASSES = CLASSES;
MODEL.INFO = sprintf('kNN Classifier with K=%d',MODEL.knn.K);

[EVAL_MATRIX f] = knn_classify(MODEL,DATA,CLASSIFICATION_COL);

end

function [EM f] = knn_classify(model,data,classification_col)
    [dummy, test_len, dummy, dummy, feature_len] = get_lengths(data, struct());

    if model.FEATURE_LENGTH ~= feature_len
        error('Incorrect feature length for the given model');
    end

    EM = NaN(test_len,2);
    if exist('classification_col','var') && ~isempty(classification_col)
        EM(:,2) = data.CLASSIFICATION(:,classification_col);
    elseif feature_len < size(data.CLASSIFICATION,2)
        EM(:,2) = data.CLASSIFICATION(:,feature_len+1);
    end
    
    idx = knnsearch(model.knn.X,data.CLASSIFICATION(:,1:feature_len),'dist',model.knn.dist,'k',model.knn.K);
    if model.knn.K == 1
        EM(:,1) = model.knn.y(idx);
        f = bsxfun(@eq,EM(:,1),model.knn.y(:)');
    else
        f = hist(model.knn.y(idx'),model.knn.labels)';

        [dummy ind] = max(f,[],2);

        EM(:,1) = model.knn.labels(ind);
    end
end

% simple function to replace the KNNSEARCH of the statistics toolbox
function idx = knnsearch(X_tr,X_te,type_s,type_str,k_str,K)
assert(strcmp(type_str,'euclidean'),'The replacement KNNSEARCH only supports the euclidean distance');

idx = zeros(size(X_te,1),K);
for i=1:size(X_te,1);
    dist = bsxfun(@minus,X_tr,X_te(i,:));
    dist = sum(dist.*dist,2);
    [dummy srt] = sort(dist,'ascend');
    idx(i,:) = srt(1:K);
end

end


