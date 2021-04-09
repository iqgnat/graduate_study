function p = bisection(f,a,b)
       
   if f(a)*f(b)>0 
      disp('Wrong choice')
   else
         p = (a + b)/2;
         k=0;
             while (b-a > 1e-8)
                       
                       if f(a)*f(p)<0 
                        b = p;
                       else
                        a = p;          
                       end
            p = (a + b)/2; 
            k=k+1;
             end
         k
   end
end