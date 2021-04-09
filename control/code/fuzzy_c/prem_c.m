function premise=prem_c(mf1,mf2)
premise=zeros(7,7);
for i=1:7
    for j=1:7
        premise(i,j)=min(mf1(i),mf2(j));
    end
end