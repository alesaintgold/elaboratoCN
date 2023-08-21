function l = lagrange(x,y,xq)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

n = length(x);
if n ~= length(y)
    error("il numero di punti sulle ascisse x non è coerente con il numero di quelli sulle ordinate");
end
if n ~= length(unique(x))
    error("ad una stessa ascissa non possono corrispondere più punti")
end
l = zeros(length(xq));
for k = 1:n
    Lkn = ones(size(xq));
    for j = 1:n
        if k ~= j
            Lkn = Lkn .* ((xq - x(j))/(x(k) - x(j)));
        end
    end
    l = l + y(k)*Lkn;
end
