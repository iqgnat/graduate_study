function y = bMF(x, params)
a = params(1); b = params(2); c = params(3); d = params(4);

y1 = zeros(size(x));
y2 = zeros(size(x));

% Compute y1
index = find(x >= b);
if ~isempty(index),
    y1(index) = ones(size(index));
end
index = find(x < a);
if ~isempty(index),
    y1(index) = zeros(size(index));
end
index = find(a <= x & x < b);
if ~isempty(index) & a ~= b,
    y1(index) = (x(index)-a)/(b-a);
end

% Compute y2
index = find(x <= c);
if ~isempty(index),
    y2(index) = ones(size(index));
end
index = find(x > d);
if ~isempty(index),
    y2(index) = zeros(size(index));
end
index = find(c < x & x <= d);
if ~isempty(index) & c ~= d,
    y2(index) = (d-x(index))/(d-c);
end

% Compute y
y = min(y1, y2);