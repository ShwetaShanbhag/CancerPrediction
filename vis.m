
function visualise(testSet)

ids=unique(testSet(:,1));
for i= 1:length(ids)
patient1= testSet(testSet(:,1)==ids(i),6:end);
rows=max(patient1(:,4))-min(patient1(:,4))+1;
cols=max(patient1(:,5))-min(patient1(:,5))+1;
slices=max(patient1(:,6))-min(patient1(:,6))+1;
Image = zeros([rows,cols,slices]);
mask=zeros([rows,cols,slices]);
mask_real=zeros([rows,cols,slices]);
patient1(:,4)=patient1(:,4)-min(patient1(:,4))+1;
patient1(:,5)=patient1(:,5)-min(patient1(:,5))+1;
patient1(:,6)=patient1(:,6)-min(patient1(:,6))+1;
for m=1:length(patient1)
    Image(patient1(m,4),patient1(m,5),patient1(m,6))=patient1(m,1);
    
    if patient1(m,end)==1
        %SData{1,1}.dData(end+1)=patient1(m,1);
        %SData{1,1}.lMask(end+1)=patient1(m,end);
       
    else
        %SData{2,1}.dData(end+1)=patient1(m,1);
        %SData{2,1}.lMask(end+1)=patient1(m,end); 
        mask(patient1(m,4),patient1(m,5),patient1(m,6))=patient1(m,1);
    end
     if patient1(m,2)==1
        %SData{1,1}.dData(end+1)=patient1(m,1);
        %SData{1,1}.lMask(end+1)=patient1(m,end);
       
    else
        %SData{2,1}.dData(end+1)=patient1(m,1);
        %SData{2,1}.lMask(end+1)=patient1(m,end); 
        mask_real(patient1(m,4),patient1(m,5),patient1(m,6))=patient1(m,1);
    end
end



h=figure(i);
%h.resize='on';
set(gcf,'title',['prediction', i]);
subplot(3,3,1)
imshowpair(Image(:,:,1), mask(:,:,1))
subplot(3,3,2)
imshowpair(Image(:,:,2), mask(:,:,2))
subplot(3,3,3)
imshowpair(Image(:,:,3), mask(:,:,3))
subplot(3,3,4)
imshowpair(Image(:,:,4), mask(:,:,4))

subplot(3,3,5)
imshowpair(Image(:,:,5), mask(:,:,5))
subplot(3,3,6)
imshowpair(Image(:,:,6), mask(:,:,6))
subplot(3,3,7)
imshowpair(Image(:,:,7), mask(:,:,7))
subplot(3,3,8)
imshowpair(Image(:,:,8), mask(:,:,8))

h2=figure(i*10);
%h2.resize='on';
set(gcf,'title',['Actual', i]);
subplot(3,3,1)
imshowpair(Image(:,:,1), mask_real(:,:,1))
subplot(3,3,2)
imshowpair(Image(:,:,2), mask_real(:,:,2))
subplot(3,3,3)
imshowpair(Image(:,:,3), mask_real(:,:,3))
subplot(3,3,4)
imshowpair(Image(:,:,4), mask_real(:,:,4))

subplot(3,3,5)
imshowpair(Image(:,:,5), mask_real(:,:,5))
subplot(3,3,6)
imshowpair(Image(:,:,6), mask_real(:,:,6))
subplot(3,3,7)
imshowpair(Image(:,:,7), mask_real(:,:,7))
subplot(3,3,8)
imshowpair(Image(:,:,8), mask_real(:,:,8))
end
