function [out]=scale(inp,mind,maxd)
[sz1,sz2]=size(inp);
out=zeros(sz1,sz2);
minval=min(min(inp));
maxval=max(max(inp));
for num=1:sz1
   for num2=1:sz2
       out(num,num2)=mind+((inp(num,num2)-minval)*(maxd-mind)/(maxval-minval));
   end
end
end