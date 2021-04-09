
A1=[4,-1,0,0; -1,4,-1,0; 0,-1,4,-1; 0,0,-1,4]; 
negI=[-1,0,0,0; 0,-1,0,0; 0,0,-1,0; 0,0,0,-1]; 
Emp=[0,0,0,0; 0,0,0,0; 0,0,0,0; 0,0,0,0];
A=[A1,negI,Emp,Emp;negI,A1,negI,Emp;Emp,negI,A1,negI;Emp,Emp,negI,A1]; 
b=[1;2;3;4;5;6;7;8;9;0;1;2;3;4;5;6];

Tol = 0.05; 
x0 = zeros(length(b), 1);
x = x0; % Initialize x
k = 1; 

r = A*x - b; % Initialize residuals 
p = -r;  % Initialize conjugate direction
deltaNew = r'*r; % deltaNew is the square error
delta0 = deltaNew; % initial square error 
OriX = A\b;

while (norm(r,inf)> Tol)
	q = A*p;
	alpha = deltaNew/(p'*q); % update step size
	x = x + alpha*p; % Update x 
	r = r + alpha*q; % update residuals
	deltaOld = deltaNew; % save previous square error
	deltaNew = r'*r; % Update square error
	p = -r + (deltaNew/deltaOld)*p; % Update conjugate direction 
	k = k + 1; % Increment iteration count
end

k

x

% Check tolerence
r




