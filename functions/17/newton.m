function l = newton(x,y,xq)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
n = length(x);
if n ~= length(y)
    error("il numero di punti sulle ascisse x non è coerente con il numero di quelli sulle ordinate");
end
if n ~= length(unique(x))
    error("ad una stessa ascissa non possono corrispondere più punti")
end
DD = y;
for k = 1:n-1
    for r = n:-1:k+1
        DD(r) = (DD(r) - DD(r-1)) ./ (x(r) - x(r-k));
    end
end
l = ones(size(xq)) * DD(n);
for k = n-1:-1:1
    l = l .* (xq - x(k)) + DD(k);
end
end
