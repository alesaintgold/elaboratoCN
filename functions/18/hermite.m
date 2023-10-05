function yy = hermite( xi, fi, f1i, xx )
%   Implementa in modo vettoriale il polinomio interpolante di Hermite
%
%   Input:
%       xi:     vettore delle ascisse di interpolazione
%       fi:     valori assunti dalla funzione sulle ascisse 
%               di interpolazione
%       fii:    valori assunti dalla derivata della funzione sulle ascisse 
%               di interpolazione
%       xx:     vettore di ascisse su cui si vuole calcolare il polinomio
%   Output:
%       yy:     valori assunti dal polinomio sui punti specificati

n = length(xi);
if n ~= length(fi) 
    error("il numero di punti sulle ascisse xi " + ...
        "non è coerente con il numero di quelli sulle ordinate fi");
end
if n ~= length(f1i)
    error("il numero di punti sulle ascisse xi non è coerente" + ...
        " con il numero di quelli sulle ordinate fi"); % ---
end
if n ~= length(unique(xi))
    error("le ascisse di interpolazione non sono tutte distinte");
end
x = repelem(xi,2);
%differenze divise 
f(1:2:2*n-1)=f1;
f(2:2:2*n) = f1i;
% algortimo 4.2 libro
n = length(f)/2-1;
for i = (2*n-1):-2:3
    f(i)= (f(i)-f(i-2))/(x(i)-x(i-1));
end
for j = 2:2*n-1
    for i = (2*n):-1:j+1
        f(i) = (f(i)-f(i-1))/(x(i)- x(i-j));
    end
end
%algoritmo di horner
n = length(f)-1;
yy = f(n+1)*ones(size(xx));
for i = n:-1:1
    yy = yy .* (xx-x(i))+f(i);
end
end