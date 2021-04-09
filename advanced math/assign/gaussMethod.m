function x=gaussMethod(A,b)
%高斯列主元消去法，要求系数矩阵非奇异的， %
n = size(A,1);
if abs(det(A))<= 1e-8
    error('系数矩阵是奇异的');
    return;
end
%
for k=1:n
       ak = max(abs(A(k:n,k)));
       index = find(A(:,k)==ak);
       if length(index) == 0
           index = find(A(:,k)==-ak);
       end
       %交换列主元
        temp = A(index,:);
        A(index,:) = A(k,:);
        A(k,:) = temp;
        temp = b(index);b(index) = b(k); b(k) = temp;
       %消元过程
   for i=k+1:n
       m=A(i,k)/A(k,k);
       %消除列元素
        A(i,k+1:n)=A(i,k+1:n)-m*A(k,k+1:n);
        b(i)=b(i)-m*b(k);
   end
end
   %回代过程
    x(n)=b(n)/A(n,n);
    for  k=n-1:-1:1;
        x(k)=(b(k)-A(k,k+1:n)*x(k+1:n)')/A(k,k);
    end
    x=x';
end