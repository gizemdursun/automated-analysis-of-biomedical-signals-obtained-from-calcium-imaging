function [maxintimg,stdimg,stdimg_scale] = projection(imgstk)
%% maximum intensity projection
%%-------------------------------------------------------------------------
numframe = length(imgstk);
for num1=1:numframe
    video(:,:,num1)=imgstk(num1).data;
end

maxintimg = zeros(imgstk(1).width,imgstk(1).height);
maxint = zeros(1,numframe);
% syc=0;
for num1 = 1:imgstk(1).height
    for num2 = 1:imgstk(1).width
%         syc = syc+1;
        for num3 = 1:numframe
            maxint(1,num3) = video(num1,num2,num3);
        end
        maxintimg(num1,num2) = max(maxint);
    end
end
figure, imshow(uint16(maxintimg));title('Maximum Intensity Projected Image')

maxintimg=uint8(maxintimg/257);

%% standard deviation projection
%%-------------------------------------------------------------------------
stdimg = zeros(imgstk(1).width,imgstk(1).height);
int = zeros(1,numframe);
% syc=0;
for num1 = 1:imgstk(1).height
    for num2 = 1:imgstk(1).width
%         syc = syc+1;
        for num3 = 1:numframe
            int(1,num3) = video(num1,num2,num3);
        end
        stdimg2(num1,num2) = std(int);
    end
end
figure, imshow(uint16(stdimg2));title('Standard Deviation Projected Image')
stdimg=uint8(stdimg2/257);
% linear scaling on std. dev. proj. image
%%---------------------------------------
[stdimg_scale]=scale(stdimg2,0,65535);
figure, imshow(uint16(stdimg_scale));title('Standard Deviation Projected with Linear Scaling Image')
stdimg_scale=uint8(stdimg_scale/257);
end