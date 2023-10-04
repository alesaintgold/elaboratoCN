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
for i = n:2
    fi(i) = (fi(i) - fi(i-1)) / (xi(i) - xi(i-1));
end
for j = 1:n-1
    for i = n:-1:j+1
        f1i(i) = (f1i(i) - fi(i)) / (xi(i) - xi(i-j));
        fi(i) = (fi(i) - f1i(i-1)) / (xi(i-1) - xi(i-j));
    end
end

end

