% compile.m should work for Linux and Mac.
% To Windows users:
% If you are using a Windows machine, please use the basic convolution (fconv.cc).
% This can be done by commenting out line 13 and uncommenting line 15 in
% compile.m
%compile;

% load and visualize model
% Pre-trained model with 146 parts. Works best for faces larger than 80*80
load face_p146_small.mat

% % Pre-trained model with 99 parts. Works best for faces larger than 150*150
% load face_p99.mat

% % Pre-trained model with 1050 parts. Give best performance on localization, but very slow
% load multipie_independent.mat

% disp('Model visualization');
% visualizemodel(model,1:13);
% disp('press any key to continue');
% pause;


% 5 levels for each octave
model.interval = 5;
% set up the threshold
model.thresh = min(-0.65, model.thresh);

% define the mapping from view-specific mixture id to viewpoint
if length(model.components)==13 
    posemap = 90:-15:-90;
elseif length(model.components)==18
    posemap = [90:-15:15 0 0 0 0 0 0 -15:-15:-90];
else
    error('Can not recognize this model');
end

ims1 = dir('C:\Users\annadani\Downloads\Dataset\Dataset\Selfie_negatives');
ims2 = dir('C:\Users\annadani\Downloads\Dataset\Dataset\Selfie_positives');
outputFolderneg='Y:\Data_blur\negatives';
outputFolderpos='Y:\Data_blur\positives';
for i = 3:length(ims1),
    fprintf('fetching: %d/%d\n', i, length(ims1));
    im = imread(fullfile('C:\Users\annadani\Downloads\Dataset\Dataset\Selfie_negatives',ims1(i).name));
    %clf; imagesc(im); axis image; axis off; drawnow;
    if size(im,3)==3
    tic;
    bs = detect(im, model, model.thresh);
    bs = clipboxes(im, bs);

    bs = nms_face(bs,0.3);
    dettime = toc;
    
    % show highest scoring one
    if length(bs)~=0
        for j=1:length(bs)
    tx1=round(min(bs(j).xy(:,2)));
    tx2=round(max(bs(j).xy(:,4)));
    ty1=round(min(bs(j).xy(:,1)));
    ty2=round(max(bs(j).xy(:,3)));
    im(tx1:tx2,ty1:ty2,:)=0;
        end
    end
    end
    imwrite(im,fullfile(outputFolderneg,strcat(ims1(i).name(1:end-5),'.jpg')))                                                                                              ;
    
        
    % show all
    %figure,showboxes(im, bs,posemap),title('All detections above the threshold');
%     if length(bs)==0
%         imwrite(
%         continue;
%     fprintf('Detection took %.1f seconds\n',dettime);
%     disp('press any key to continue');
%     pause;
%     close all;
end
% for i = 3:length(ims2),
%     fprintf('fetching: %d/%d\n', i, length(ims2));
%     im = imread(fullfile('C:\Users\annadani\Downloads\Dataset\Dataset\Selfie_negatives',ims2(i).name));
%     %clf; imagesc(im); axis image; axis off; drawnow;
%     
%     tic;
%     bs = detect(im, model, model.thresh);
%     bs = clipboxes(im, bs);
% 
%     bs = nms_face(bs,0.3);
%     dettime = toc;
%     
%     % show highest scoring one
%     if length(bs)~=0
%         for j=1:length(bs)
%     tx1=round(min(bs(j).xy(:,2)));
%     tx2=round(max(bs(j).xy(:,4)));
%     ty1=round(min(bs(j).xy(:,1)));
%     ty2=round(max(bs(j).xy(:,3)));
%     im(tx1:tx2,ty1:ty2,:)=0;
%         end
%     end
%     imwrite(im,fullfile(outputFolderneg,ims2(i).name));
%     
%         
%     % show all
%     %figure,showboxes(im, bs,posemap),title('All detections above the threshold');
% %     if length(bs)==0
% %         imwrite(
% %         continue;
% %     fprintf('Detection took %.1f seconds\n',dettime);
% %     disp('press any key to continue');
% %     pause;
% %     close all;
% end
% disp('done!');
