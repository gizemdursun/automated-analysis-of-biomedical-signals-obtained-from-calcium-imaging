%%-------------------------------------------------------------------------
% Combined segmentation and classification-based approach to automated
% analysis of biomedical signals obtained from calcium imaging,2022.

% This MATLAB code to implement a segmentation and classification-based approach
% for assembling an automated screening system for the analysis of calcium
% imaging.

% writen by Gizem Dursun Demir under H2020-MSCA-RISE-2017 Automated Functional Screening of
% IgGs for Diagnostics of Neurodegenerative Diseases (AUTOIGG) project.

% Contributions:
%   Abdulkerim Capar, ITU.
%   Ufuk Ozkaya, SDU.

% If you have any trouble using this code, report any bugs, or want to 
% request a feature please use the GitHub issues.
%
% Gizem Dursun Demir
% A member of OPTIMA research group and research assistant at EEE
% department of Faculty of Engineering, Suleyman Demirel University,
% Isparta, Turkey
% gizemdursun@sdu.edu.tr
% https://www.optima-lab.com/
%%-------------------------------------------------------------------------

clear all
close all
clc

%% Installation
[sROI,numROI,video,imgstk] = install;

%% Projection
[maxintimg,stdimg,stdimg_scale] = projection(imgstk);

%% Segmentation Process
% MLT

imgtype = {maxintimg stdimg stdimg_scale};
thresh = 500;
thstop = 3000;
thelim = 500;


for num = 1:length(imgtype)
    [mltimg(:,:,num)]= mlt(video,imgtype{1,num},thresh,thstop,thelim);
    [precision(num,:),recall(num,:),fscore(num,:),~] = calcmetrics(video,mltimg(:,:,num),numROI,sROI);
end

%% Classification Process
% Create Feature Image

for num1 = 1:3
    [featimg] = createfeatimg(video,mltimg(:,:,num1));
    switch num1
        case 1
            save(['./','maxint_featimg'],'featimg')
        case 2
            save(['./','stdimg_featimg'],'featimg')
        case 3
            save(['./','stdscale_featimg'],'featimg')
    end
    clear featimg
end

% Preparation of Classification Data

MethodStr = 'maxint'; %this variable must be change as stdimg and stdscale 
[PixDataTrain,PixDataTest] = prepClassData(MethodStr);

load('PixDataTrain.mat')
load('PixDataTrest.mat')

% Classification

classificationLearner




