function y = cMF(x, params)

a = params(1); b = params(2); c = params(3);
y = zeros(size(x));

% Left and right shoulders (y = 0)
index = find(x <= a | c <= x);
y(index) = zeros(size(index));

% Left slope
if (a ~= b)
    index = find(a < x & x < b);
    y(index) = (x(index)-a)/(b-a);
end

% right slope
if (b ~= c)
    index = find(b < x & x < c);
    y(index) = (c-x(index))/(c-b);
end

% Center (y = 1)
index = find(x == b);
y(index) = ones(size(index));
