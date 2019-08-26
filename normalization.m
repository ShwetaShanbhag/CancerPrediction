function normalizedDataMatrix=normalization(dataMatrix)
    featureMeans=mean(dataMatrix(:,2:6));
    featureStd=std(dataMatrix(:,2:6));
    dataMatrix(:,2:6)=(dataMatrix(:,2:6)-featureMeans)./featureStd;
    
    normalizedDataMatrix=dataMatrix;
    
end