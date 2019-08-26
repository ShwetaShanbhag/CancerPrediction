function [reducedTrainingSet]= trainingSetSelection(refinedTrainingSet)
epochSize=80;
reducedTrainingSet=[];
totalSize=length(refinedTrainingSet);
for i=1:epochSize
    batchSize=floor(totalSize/epochSize);
    lowerBound=(i-1)*batchSize+1;
    higherBound= batchSize *i;
    batchSet=refinedTrainingSet(lowerBound:higherBound,:);
    [IDX,~] = knnsearch(batchSet(:,2:6),batchSet(:,2:6),'K',5,'Distance','euclidean');
    labels= batchSet(:,7);
    neighboursIdx=labels(IDX);
    tempReducedTrainingSet=[];
    for m=1:length(neighboursIdx)  
        if ~(sum(isnan(neighboursIdx(m))))
            neighbours=batchSet(IDX(m,:)',:);
            if (length(unique(neighboursIdx(m)))==1)&&(unique(neighboursIdx(m))~=2)          
                newDataPoint=mean(neighbours(:,2:6));
                tempReducedTrainingSet(end+1,:)=[newDataPoint , labels(m)];                          
            else
                tempReducedTrainingSet(end+1:end+5,:)=neighbours(:,2:7);
            end
            neighboursIdx(IDX(m,:)',:)=NaN;
        end
    end
    reducedTrainingSet=vertcat(reducedTrainingSet,tempReducedTrainingSet);
end