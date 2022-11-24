function [featimg] = createfeatimg(video,mltimg)
 
bw = mltimg;
nframe = size(video,3);
regionofmax=regionprops(bw,'all');
syc=0;

for nn = 1:length(regionofmax)
    x = regionofmax(nn).Area;
    if x==0
        syc=syc+1;
    end
end
featimg = zeros((length(regionofmax)-syc),nframe);
syc1=0;
for num = 1:length(regionofmax)
    pixellist = regionofmax(num).PixelList;
    if (length(pixellist)~=0)
        syc1=syc1+1;
        for num1 = 1:length(pixellist(:,1))
            for num2 = 1:nframe
                celltrace(num1,num2) = video(pixellist(num1,2),pixellist(num1,1),num2);
            end
        end
        featimg(syc1,:)=mean(celltrace);
        clearvars pixellist celltrace
    end
end

clearvars regionofmax 
end
