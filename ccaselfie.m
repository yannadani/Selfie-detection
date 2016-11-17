%selfiefeat=struct('filename','hogcan','lbpcan');
addpath('Y:\matlab_codes\efficientLBP\');
addpath('Y:\matlab_codes\vlfeat-0.9.20\');
filelist=dir('C:\Users\annadani\Downloads\Dataset\Dataset\Selfie_negatives');
for i=1:length(filelist)
    file=filelist(i).name;
    try
    img=imread(strcat('C:\Users\annadani\Downloads\Dataset\Dataset\Selfie_negatives\',file));
    catch ME
         SelfieFeatNeg(i-2,1)=struct('filename',file,'hogFeatures',[],'LBPFeatures',[],'keypoints',[]);
        continue;
    end
   if size(img,3)==3     
   img=rgb2gray(img);
   
   end
   img=imresize(img,[227,227]);
    keypoints = vl_sift(single(img));
   % keypoints=keypoints(:,1:100);
    hogFeat=extractHOGFeatures(img);
    %hogFeatpop(:,i-2)=hogFeat(:);
    %LBPFeat=extractLBPFeatures(im2gray(img));
    LBP=pixelwiseLBP(img, 'filtR', generateRadialFilterLBP(8, 1), 'isRotInv', true,...
        'isChanWiseRot', false);
    %LBPFeatpop(:,i-2)=LBP(:);
    SelfieFeatNeg(i-2,1)=struct('filename',file,'hogFeatures',hogFeat(:),'LBPFeatures',LBP(:),'keypoints',keypoints);
if rem(i,100)==0
    save SelfieFeatNeg SelfieFeatNeg;
end
end
