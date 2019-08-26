function [dataMatrix,dataMatrixVars]= extractData(dataset)
    dataMatrix=[];
    featureList=dataset{1,1}.featureList;
    dataMatrixVars={'patientIdx',featureList{:},'labelsA','labelsB','positionX', 'positionY','positionZ', 5};
    
    for i=1:length(dataset) 
        start=1;
        [rows,cols,slices]=size(dataset{i,1}.LabelsA);
        %[positionX,positionY,labels]=find((dataset{i,1}.LabelsA >0) & (dataset{i,1}.LabelsB>0) & (dataset{i,1}.LabelsA == dataset{i,1}.LabelsB)  );
        [positionX,positionY,~]=find((dataset{i,1}.LabelsA >0) &(dataset{i,1}.LabelsB>0));
        positionZ=ceil(positionY/cols);
        positionY=positionY-(positionZ-1)*cols;
        for featureIdx=1:length(featureList)
            temp=dataset{i,1}.Image(:,:,:,featureIdx);
            tempA=dataset{i,1}.LabelsA;
            tempB=dataset{i,1}.LabelsB;
            for pixelIdx=1:length(positionX)
                features(pixelIdx,featureIdx)=temp(positionX(pixelIdx),positionY(pixelIdx),positionZ(pixelIdx));
                if (start)
                    labelsA(pixelIdx,1)=tempA(positionX(pixelIdx),positionY(pixelIdx),positionZ(pixelIdx));
                    labelsB(pixelIdx,1)=tempB(positionX(pixelIdx),positionY(pixelIdx),positionZ(pixelIdx));
                end
                
            end
             start=0;
        end
        patientIdx= ones(length(positionX),1)*dataset{i,1}.patientIdx ;
        try
            dataMatrix=vertcat(dataMatrix,horzcat(patientIdx,features,labelsA,labelsB,positionX,positionY,positionZ));
        catch
            fprintf('%d',i);
        end
        clear features patientIdx positionX positionY positionZ labelsA labelsB;
    end