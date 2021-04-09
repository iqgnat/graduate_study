 x0 = 0;
  x1 = 2;
  h =0.01;
  x_val = [0 1 2];  
  total = 0;
  y_func = exp(2*x_val)*sin(3*x_val);
  totals = (y_func(1) + 4*y_func(2) + y_func(3)) * h /3;
  disp (['Simpson Rule: ' num2str(totals)])
