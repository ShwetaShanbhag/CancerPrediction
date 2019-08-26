function [trainingSet, testSet]=dataPartitioning(refinedDataMatrix, numOfLabelledPatients)

patientIDs=[1:numOfLabelledPatients]';
trainingSet=refinedDataMatrix(ismember( refinedDataMatrix(:,1),patientIDs),:);
testSet=refinedDataMatrix(length(trainingSet)+1:end,:);
end