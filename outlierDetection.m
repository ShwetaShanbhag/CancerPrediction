function [refinedDataMatrix]=outlierDetection(normalizedDataMatrix, numOfLabelledPatients)

[sig, mu, md , outliers]=robustcov(normalizedDataMatrix(:,2:6));
numOfOutliers=length(find(outliers));

%patientIDs=[1:numOfLabelledPatients]';
%numOfOutliers=nnz(outliers(ismember( normalizedDataMatrix(:,1),patientIDs)));

percentOfOutliers=numOfOutliers/size(normalizedDataMatrix,1)*100;

end