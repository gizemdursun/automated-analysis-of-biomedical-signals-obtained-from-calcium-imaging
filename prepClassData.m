function [PixDataTrain,PixDataTest] = prepClassData(MethodStr)
%%------------------------------------------------------------------------
% This code is used for preparation of classification data. Data is prepared using all
% feature images created from 33 calcium imaging videos. In our work, we
% divided 33 calcium imaging videos for training and test as number of 22 and 11, respectively.
% At the end of this code we generate PixDataTrain and PixDataTest for
% training and testing step of classification.
%%------------------------------------------------------------------------

addpath('.\feature images') % feature images file must be include all feature images 
% created from 33 calcium imaging video with 3 projection method for 
% implementing this function. 

ShuffleNum = 200; %how many feature images will be created with row shuffling
NormDimX = 128; %Feature Image width
NormDimY = 32; %Feature Image height

FeatLen = NormDimX * NormDimY;
PixDataTrain = zeros(ShuffleNum*22, FeatLen+1); % 22 patients for training, 15 ALS - 7 non-ALS
PixDataTest = zeros(ShuffleNum*11, FeatLen+1); % 11 patients for testing, 6 ALS - 5 non-ALS
AccTrain = 0;
AccTest = 0;

for k=1:10    
    matFile = ['ALS' num2str(k) '_' MethodStr];
    load([matFile '.mat'], 'featimg');
    for i=1:ShuffleNum
        Shuff = featimg(randperm(size(featimg,1)),:);
        uint8Image = uint8(255 * mat2gray(Shuff));
        resizeImg = imresize(uint8Image, [NormDimY NormDimX]);
        
        
        arrImg = reshape(resizeImg, [1 FeatLen]); 
        
        if k < 8
            PixDataTrain(AccTrain*ShuffleNum+i, 1:FeatLen) = arrImg;
            PixDataTrain(AccTrain*ShuffleNum+i, FeatLen+1) = 1;
        else
            PixDataTest(AccTest*ShuffleNum+i, 1:FeatLen) = arrImg;
            PixDataTest(AccTest*ShuffleNum+i, FeatLen+1) = 1;
        end
        
    end
    if k < 8
        AccTrain = AccTrain + 1;
    else
        AccTest = AccTest + 1;
    end
end

for k=1:2
    matFile = ['HCTRL', num2str(k) '_' MethodStr];
    load([matFile '.mat'], 'featimg');
    for i=1:ShuffleNum
        Shuff = featimg(randperm(size(featimg,1)),:);
        uint8Image = uint8(255 * mat2gray(Shuff));
        resizeImg = imresize(uint8Image, [NormDimY NormDimX]);
        arrImg = reshape(resizeImg, [1 FeatLen]); 
        
        if k == 1
            PixDataTrain(AccTrain*ShuffleNum+i, 1:FeatLen) = arrImg;
            PixDataTrain(AccTrain*ShuffleNum+i, FeatLen+1) = 0;
        else
            PixDataTest(AccTest*ShuffleNum+i, 1:FeatLen) = arrImg;
            PixDataTest(AccTest*ShuffleNum+i, FeatLen+1) = 0;
        end
        
    end
    if k == 1
        AccTrain = AccTrain + 1;
    else
        AccTest = AccTest + 1;
    end
end

for k=3:3
    matFile = ['PDCTRL', num2str(k) '_' MethodStr];
    load([matFile '.mat'], 'featimg');
    for i=1:ShuffleNum
        Shuff = featimg(randperm(size(featimg,1)),:);
        uint8Image = uint8(255 * mat2gray(Shuff));
        resizeImg = imresize(uint8Image, [NormDimY NormDimX]);
        arrImg = reshape(resizeImg, [1 FeatLen]); 
        
        PixDataTrain(AccTrain*ShuffleNum+i, 1:FeatLen) = arrImg;
        PixDataTrain(AccTrain*ShuffleNum+i, FeatLen+1) = 0;
        
    end
    AccTrain = AccTrain + 1;
end

for k=4:5
    matFile = ['PNCTRL', num2str(k) '_' MethodStr];
    load([matFile '.mat'], 'featimg');
    for i=1:ShuffleNum
        Shuff = featimg(randperm(size(featimg,1)),:);
        uint8Image = uint8(255 * mat2gray(Shuff));
        resizeImg = imresize(uint8Image, [NormDimY NormDimX]);
        arrImg = reshape(resizeImg, [1 FeatLen]); 
        
        if k == 4
            PixDataTrain(AccTrain*ShuffleNum+i, 1:FeatLen) = arrImg;
            PixDataTrain(AccTrain*ShuffleNum+i, FeatLen+1) = 0;
        else
            PixDataTest(AccTest*ShuffleNum+i, 1:FeatLen) = arrImg;
            PixDataTest(AccTest*ShuffleNum+i, FeatLen+1) = 0;
        end
        
    end
    if k == 4
        AccTrain = AccTrain + 1;
    else
        AccTest = AccTest + 1;
    end
end

for k=11:21    
    matFile = ['ALS' num2str(k) '_' MethodStr];
    load([matFile '.mat'], 'featimg');
    for i=1:ShuffleNum
        Shuff = featimg(randperm(size(featimg,1)),:);
        uint8Image = uint8(255 * mat2gray(Shuff));
        resizeImg = imresize(uint8Image, [NormDimY NormDimX]);
        arrImg = reshape(resizeImg, [1 FeatLen]); 
        
        if k < 19
            PixDataTrain(AccTrain*ShuffleNum+i, 1:FeatLen) = arrImg;
            PixDataTrain(AccTrain*ShuffleNum+i, FeatLen+1) = 1;
        else
            PixDataTest(AccTest*ShuffleNum+i, 1:FeatLen) = arrImg;
            PixDataTest(AccTest*ShuffleNum+i, FeatLen+1) = 1;
        end
        
    end
    if k < 19
        AccTrain = AccTrain + 1;
    else
        AccTest = AccTest + 1;
    end
end

for k=6:12
    matFile = ['CTRL', num2str(k) '_' MethodStr];
    load([matFile '.mat'], 'featimg');
    for i=1:ShuffleNum
        Shuff = featimg(randperm(size(featimg,1)),:);
        uint8Image = uint8(255 * mat2gray(Shuff));
        resizeImg = imresize(uint8Image, [NormDimY NormDimX]);
        arrImg = reshape(resizeImg, [1 FeatLen]); 
        
        if k < 10
            PixDataTrain(AccTrain*ShuffleNum+i, 1:FeatLen) = arrImg;
            PixDataTrain(AccTrain*ShuffleNum+i, FeatLen+1) = 0;
        else
            PixDataTest(AccTest*ShuffleNum+i, 1:FeatLen) = arrImg;
            PixDataTest(AccTest*ShuffleNum+i, FeatLen+1) = 0;
        end
        
    end
    if k < 10
        AccTrain = AccTrain + 1;
    else
        AccTest = AccTest + 1;
    end
end
end



