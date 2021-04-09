function u=ucr_c(imps,rule,center)
num=0;
den=0;
for i=1:7
    for j=1:7
      num=num+imps(i,j)*center(rule(i,j));
      den=den+imps(i,j);
    end
end
u=num/den;