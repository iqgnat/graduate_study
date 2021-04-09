function [poly]=polyadd(poly1,poly2)
if length(poly1)<length(poly2)
    short=poly1;
    long=poly2;
else 
    short=poly2;
    long=poly1;
end
    mz=length(long)-length(short);
if mz>0
    poly=[zeros(1,mz),short]+long;
else
    poly=long+short;
end