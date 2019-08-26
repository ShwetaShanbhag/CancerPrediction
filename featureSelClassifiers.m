function [knnF1ScoreFS,knnAccuracyFS,nmF1ScoreFS,nmAccuracyFS]=featureSelClassifiers(reducedTrainingSet,testSet)
[combinationFeatures,orderMatrix]=FeatureSEL(reducedTrainingSet);
j=1;
for i =1:2:(size(combinationFeatures,2)-1)
    
kKNN=5;
%predLabels = knnclassify(testSet(:,2:2+numOfClassifiers), TrainingSet(:,1:numOfClassifiers), TrainingSet(:,numOfClassifiers+1),kKNN);
X=combinationFeatures(:,i:i+1);
Y=combinationFeatures(:,end);
Mdl = fitcknn(X,Y,'NumNeighbors',kKNN,...
    'NSMethod','exhaustive','Distance','minkowski',...
    'Standardize',1);
[label,~,~] = predict(Mdl,testSet(:,orderMatrix(j,:)+1));
knnConfusionMat=confusionmat(testSet(:,7),label);
knnprecision=knnConfusionMat(2,2)/sum(knnConfusionMat(2,:));
knnRecall=knnConfusionMat(2,2)/sum(knnConfusionMat(:,2));
knnF1ScoreFS(j)=2/(1/knnprecision+1/knnRecall);
knnAccuracyFS(j) =sum(label==testSet(:,7))/ length(testSet);

DATA.TRAINING= horzcat(X,Y);
DATA.CLASSIFICATION=horzcat(testSet(:,(orderMatrix(j,:)+1)),testSet(:,7));
NM_EVAL_MATRIX = mean_classifier(DATA);
nmConfusionMat=confusionmat(NM_EVAL_MATRIX(:,2),NM_EVAL_MATRIX(:,1));
nmPrecision=nmConfusionMat(2,2)/sum(nmConfusionMat(2,:));
nmRecall=nmConfusionMat(2,2)/sum(nmConfusionMat(:,2));
nmF1ScoreFS(j)=2/(1/nmPrecision+1/nmRecall);
nmAccuracyFS(j) =sum(NM_EVAL_MATRIX(:,1)== NM_EVAL_MATRIX(:,2))/ length(testSet);
j=j+1;
end