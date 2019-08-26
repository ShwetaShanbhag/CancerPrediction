function [CombinationMatrix_Labels,sort_Ch]=featureSelection (reducedTrainingSet)
Ch=combnk(1:5,2);
sort_Ch=sortrows(Ch,1);
CombinationMatrix=(reducedTrainingSet(:,sort_Ch(1,1:2)));
for i=2:1:10
Temp_twoselectionfeatures=(reducedTrainingSet(:,sort_Ch(i,1:2)));
CombinationMatrix=cat(2,CombinationMatrix,Temp_twoselectionfeatures);
end
CombinationMatrix_Labels=cat(2,CombinationMatrix,reducedTrainingSet(:,6));