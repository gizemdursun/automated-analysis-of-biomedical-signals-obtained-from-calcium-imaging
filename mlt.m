function [mltimg]= mlt(video,segimg,thresh,thstop,thelim)
[numr,numc,~] = size(video);
mltimg = zeros(numr,numc,length(thresh));
for tt1=1:length(thresh)
    numfilt =5;
    mm=0;
    list = zeros(1,numr*numc);
    imgm = segimg;
    ff = (1/(numfilt*numfilt))*ones(numfilt);
    imgmfilt = uint8(imfilter(imgm,ff));
    
    for num = 255:-1:1
        seg_I = imbinarize(imgmfilt,num/255);
        cc1 = regionprops(seg_I,'all');
        cc =length(cc1);
        if cc~=0
            for i =1:cc
                if mm==0
                    mm=mm+1;
                    list(cc1(i).PixelIdxList)=mm;
                else
                    for j = 1:length(ja)
                        [d,y]=find(list==ja(j));
                        array(j)= ~isempty(intersect(cc1(i).PixelIdxList,y));
                    end
                    if sum(array)==1
                        [d1,y1]=find(array==1);
                        [d3,y3]=find(list==ja(y1));
                        if ((length(y3)+cc1(i).Area)<thstop)
                        list(cc1(i).PixelIdxList)= ja(y1);
                        end
                    elseif sum(array)==0
                            mm=mm+1;
                        list(cc1(i).PixelIdxList)=mm;
                    else
                        [d1,y1]=find(array==1);
                        for nn = 1:length(y1)
                            [dd,yy]=find(list==ja(y1(nn)));
                            ll(nn)=length(yy);
                        end
                        list1 =list;
                        if (sum(ll>thresh(1,tt1))<=1) 
                            list(cc1(i).PixelIdxList)= min(ja(y1));
                        end
                        [d2,y2]=find(list==min(ja(y1)));
                        if length(y2)>thstop
                            list=list1;
                        end
                    end
                    clear d y array d1 y1 dd yy ll arrayd dd1 yy1 d2 y2 d3 y3
                end
                gi = 1:max(list);
                mm=max(intersect(gi,list));
                ja=intersect(gi,list);
            end
        end
    end
    segr = regionprops(reshape(list,512,512),'all');
    for nn2 = 1:length(segr)
        if segr(nn2).Area<thelim
            list(segr(nn2).PixelIdxList)=0;
        end
    end
    gi = 1:max(list);
    mm=max(intersect(gi,list));
    if isempty(mm)
        mm=0;
    end
    ja=intersect(gi,list);
    clear seg segr cellseg cc1 segx gi
    segim=reshape(list,512,512);
            imshow(segim);title('Multi-level Thresholded Image')
mltimg(:,:,tt1) = segim;
end