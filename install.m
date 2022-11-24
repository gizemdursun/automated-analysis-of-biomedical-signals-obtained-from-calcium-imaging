function [sROI,numROI,video,imgstk] = install()

% load calcium imaging video data
[filename,pathname] = uigetfile({'*.stk'},'Open TIFF file with imaging video', 'MultiSelect', 'off');
fileVideo=fullfile(pathname,filename);

% read .stk file 
imgstk = tiffread2(fileVideo);

numframe = length(imgstk);
for num1=1:numframe
    video(:,:,num1)=imgstk(num1).data;
end

% load ground truth data
[filename,pathname] = uigetfile({'*.zip'},'Open TIFF file with imaging video', 'MultiSelect', 'off');
fileGT=fullfile(pathname,filename);
[sROI] = ReadImageJROI(fileGT);
numROI = length(sROI);

end