function l = newton(x,y,xq)
% l = newton(x,y,xq) 	
%
%   Implementa in modo vettoriale, la forma di Newton del polinomio 
%   interpolante una funzione
%   
%   Input:
%       x:  vettore contenente le ascisse di interpolazione 
%       y:  valori assunti dalla funzione sulle ascisse di 
%           interpolazione 
%       xq: punti su cui si vuole calcolare la funzione
%   Output:
%       l:  approsimazione dei valori della funzione secondo 
%           il polinomio interpolante 

n = length(x);
if n ~= length(y)
    error("il numero di punti sulle ascisse x non è coerente con il numero" + ...
        " di quelli sulle ordinate");
end
if n ~= length(unique(x))
    error("ad una stessa ascissa non possono corrispondere più punti")
end
f = y; %differenze divise
for k = 1:n-1  
    for r = n:-1:k+1
        f(r) = (f(r) - f(r-1)) ./ (x(r) - x(r-k));
    end
end
l = ones(size(xq)) * f(n);
for k = n-1:-1:1
    l = l .* (xq - x(k)) + f(k);
end
end
