function premise=prem(mf1,mf2)
premise=zeros(5,5);
for i=1:5
    for j=1:5
        premise(i,j)=min(mf1(i),mf2(j));
    end
end