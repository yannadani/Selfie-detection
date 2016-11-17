hog=[];
lbp=[];
posname=cell(836,1);
negname=cell(968,1);
count=0;
for i=1:length(SelfieFeat)
    count=count+1;
 if isempty(SelfieFeat(i).hogFeatures)
     count=count-1;
 continue;
 end
hog=[hog SelfieFeat(i).hogFeatures];
lbp=[lbp SelfieFeat(i).LBPFeatures];
posname{count}= SelfieFeat(i).filename;
end
count=0;
for i=1:length(SelfieFeatNeg)
    count=count+1;
 if isempty(SelfieFeatNeg(i).hogFeatures)
     count=count-1;
 continue;
 end
hog=[hog SelfieFeatNeg(i).hogFeatures];
lbp=[lbp SelfieFeatNeg(i).LBPFeatures];
negname{count}=strcat(SelfieFeatNeg(i).filename(1:end-5),'.jpg');
end
[A,B,R,U,V]=canoncorr(hog',lbp');
