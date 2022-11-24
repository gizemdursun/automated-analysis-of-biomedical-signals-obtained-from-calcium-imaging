function [precision,recall,fscore,performmat1] = calcmetrics(video,segimg,numROI,sROI) 
    warning off
    [numr,numc,~] = size(video);
    x = 1:numr;y = 1:numc;
    [xx,yy]=meshgrid(x,y);
    segtable = regionprops(segimg,'all');
    numseg = length(segtable);
    syc=0;list=[];
    for nn =1:numseg
        if segtable(nn).Area==0
            syc=syc+1;
            list(syc)=nn;
        end
    end
    segtable(list)=[];
    numseg = length(segtable);
    performmat = zeros(numROI,numseg);
    in = zeros(numr,numc);
    
    for num1 = 1:numROI
        cellxy = sROI{1,num1}.mnCoordinates;
        polyin = polyshape(cellxy(:,1),cellxy(:,2));
        in = inpolygon(xx,yy,cellxy(:,1),cellxy(:,2));
        segtable2 = regionprops(in,'all');
        for num2 = 1:numseg
            ins = zeros(numr,numc);
            xa = round(segtable(num2).BoundingBox(1,2));
            xb = round(segtable(num2).BoundingBox(1,4));
            ya = round(segtable(num2).BoundingBox(1,1));
            yb = round(segtable(num2).BoundingBox(1,3));
            ins(xa:xa+xb-1,ya:ya+yb-1) = segtable(num2).FilledImage;
            segtable3 = regionprops(ins,'all');
            if ((length(segtable2)==1) && (length(segtable3)==1))
                iou = sum(sum(in.*ins))/min(segtable3.Area,segtable2.Area);
            else
                for nn1 = 1:length(segtable2)
                    alan(nn1) = segtable2(nn1).Area;
                end
                [dal,yal]=max(alan);
                for nn2 = 1:length(segtable3)
                    alan2(nn2) = segtable3(nn2).Area;
                end
                [dal2,yal2]=max(alan2);
                iou = sum(sum(in.*ins))/min(segtable3(yal2).Area,segtable2(yal).Area);
            end
            performmat(num1,num2) = iou;
            clearvars xa xb ya yb segtable3
        end
        clearvars cellxy in polyin cellseg polyin polyseg ins segtable2
    end
    
    performmat1 = performmat;
    tps = 0;
    fns = 0;
    th = [0.1 0.2 0.3 0.4 0.5 0.7];
    for num5 = 1 : 6
        for num4 = 1:numROI
            [d,y] = max(performmat(num4,:));
                if d>=th(num5)
                    tps = tps+1;
                    performmat(:,y) = 0;
                else
                    fns = fns+1;
                end
        end
        tp(num5) = tps;
        fn(num5) = fns;
        tps = 0;
        fns = 0;
        performmat = performmat1;
    end
    
    recall(1,:) = tp./(tp+fn);
    
    tps = 0;
    fps = 0;
    for num6 = 1 : 6
        for num7 = 1:numseg
            [d,y] = max(performmat(:,num7));
                if d>=th(num6)
                    tps = tps+1;
                    performmat(y,:) = 0;
                else
                    fps = fps+1;
                end
        end
        tp(num6) = tps;
        fp(num6) = fps;
        tps = 0;
        fps = 0;
        performmat = performmat1;
    end
    
    precision(1,:) = tp./(tp+fp);
    fscore = (2*precision.*recall)./(precision+recall);
    clearvars segtable
end