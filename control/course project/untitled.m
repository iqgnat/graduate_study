i=find( ~ isnan(HDR.Classlabel));
j=find(HDR.ArtifactSelection==1);
m=intersect(i,j);
n=setdiff(i,m); % No. of trials labeled and without artifacts
% size(n);
for count=1:149
     x(count)= HDR.Classlabel(n(count));
end
x1=find(x==1);x2=find(x==2);x3=find(x==3);x4=find(x==4);
num1=size(x1);
num2=size(x2);
num3=size(x3);
num4=size(x4);

class_1=[];class_2=[];class_3=[];class_4=[];
for count=1:num1(1,2)
  class_1 = cat(1,class_1,s(HDR.TRIG(x1(1,count)):HDR.TRIG(x1(1,count))+1000,:));
% class_1 = [class_1; s(HDR.TRIG(x1(1,count)):HDR.TRIG(x1(count,:))+1000,:)];
end

for count=1:num2(1,2)
class_2 = [class_2 ; s(HDR.TRIG(x2(1,count)):HDR.TRIG(x2(1,count))+1000,:)];
end

for count=1:num3(1,2)
class_3 = [class_3 ; s(HDR.TRIG(x3(1,count)):HDR.TRIG(x3(1,count))+1000,:)];
end

for count=1:num4(1,2)
class_4 = [class_4; s(HDR.TRIG(x4(1,count)):HDR.TRIG(x4(1,count))+1000,:)];
end

