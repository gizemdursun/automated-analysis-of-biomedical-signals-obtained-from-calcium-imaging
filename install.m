function [sROI,numROI,video,imgstk] = install()

% load calcium imaging video data
% you can download .stk data from the link. (https://drive.google.com/file/d/1mZyr9v3jlzoGX8fRKKc_LsXr4K06COS3/view?usp=share_link)
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
