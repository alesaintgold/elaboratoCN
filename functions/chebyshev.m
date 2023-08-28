function x = chebyshev(n,a,b)
%
%
if n <= 0
    error("il grado del polinomio deve essere maggiore di zero");
end
if a >= b
    error("l'estremo inferiore dell' intervallo non può essere " + ...
        "minore o coincidente con quello maggiore");
end
x = cos( (2*(n:-1:0)+1)*pi ./ (2*(n+1)) );
x = x * (b-a)/2 + (a+b)/2;
end