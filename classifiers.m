function [testSet]=classifiers(trainingSet,testSet)

kKNN=5;
%predLabels = knnclassify(testSet(:,2:2+numOfClassifiers), TrainingSet(:,1:numOfClassifiers), TrainingSet(:,numOfClassifiers+1),kKNN);
X=trainingSet(:,1:5);
Y=trainingSet(:,6);
Mdl = fitcknn(X,Y,'NumNeighbors',kKNN,...
    'NSMethod','exhaustive','Distance','minkowski',...
    'Standardize',1);
[label,~,~] = predict(Mdl,testSet(:,2:6));
knnConfusionMat=confusionmat(testSet(:,7),label);
knnprecision=knnConfusionMat(2,2)/sum(knnConfusionMat(2,:));
knnRecall=knnConfusionMat(2,2)/sum(knnConfusionMat(:,2));
knnF1Score=2/(1/knnprecision+1/knnRecall);
knnAccuracy =sum(label==testSet(:,7))/ length(testSet);

DATA.TRAINING= trainingSet;
DATA.CLASSIFICATION=testSet(:,2:7);
NM_EVAL_MATRIX = mean_classifier(DATA);
nmConfusionMat=confusionmat(NM_EVAL_MATRIX(:,2),NM_EVAL_MATRIX(:,1));
nmPrecision=nmConfusionMat(2,2)/sum(nmConfusionMat(2,:));
nmRecall=nmConfusionMat(2,2)/sum(nmConfusionMat(:,2));
nmF1Score=2/(1/nmPrecision+1/nmRecall);
nmAccuracy =sum(NM_EVAL_MATRIX(:,1)== NM_EVAL_MATRIX(:,2))/ length(testSet);
%[KNN_EVAL_MATRIX f MODEL] = knn_classifier(DATA,PARAMETERS);

svmStruct = svmtrain(DATA.TRAINING(:,end),DATA.TRAINING(:,1:end-1),'-h', 0);
[predicted_label, svmAccuracy, ~] = svmpredict(DATA.CLASSIFICATION(:,end), DATA.CLASSIFICATION(:,1:end-1), svmStruct);

svmConfusionMat=confusionmat(testSet(:,7),predicted_label);
svmPrecision=svmConfusionMat(2,2)/sum(svmConfusionMat(2,:));
svmRecall=svmConfusionMat(2,2)/sum(svmConfusionMat(:,2));
svmF1Score=2/(1/svmPrecision+1/svmRecall);
testSet(:,end+1)=predicted_label;
classifiersList={'SVM','KNN','NM'};
figure(2);
title('F1Score of the classifiers');
width = 0.5;
barh([svmF1Score knnF1Score nmF1Score],width);
set(gca, 'YTick', 1:3)
set(gca, 'YTickLabel', classifiersList)

