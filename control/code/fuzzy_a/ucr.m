function u=ucr(imps,rule,center)
num=0;
den=0;
for i=1:5
    for j=1:5
      num=num+imps(i,j)*center(rule(i,j));
      den=den+imps(i,j);
    end
end
u=num/den;