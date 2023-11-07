function ll = lebesgue(a, b, nn, type)
% ll = lebesgue(a, b, nn, type)
%   
%   Approssima la costante di Lebesgue per l'interpolazione 
%   polinomiale sull intervallo [a,b], per i polinomi di 
%   grado specificato nel vettore nn utilizzando le ascisse 
%   equidistanti se type è uguale a 0 e quelle di chebyshev 
%   se type è uguale a uno
%
%   Input:
%       a,b:    intervalli sui quali calcolare le ascisse
%       nn:     grado dei polinomi
%       type:   se 0 usa le ascisse equidistante
%               se 1 usa le ascisse di Chebyshev
%
%   Output:
%       ll:     stima della costante di Lebesgue

if a >= b
    error("l'estremo inferiore dell' intervallo non può essere " + ...
        "minore o coincidente con quello maggiore");
end

n = length(nn);  
ll = ones(length(n));
xq = linspace(a, b, 10001);

for i = 1:n
    if type == 0
        x = linspace(a, b, nn(i)+1);
    elseif type == 1
        x = chebyshev(nn(i), a, b);
    else
        error("il valore di type può essere soltanto 0 o 1");
    end

    L = zeros(size(xq));
    m = length(x);    
    for k = 1:m
        Lkn = ones(size(xq));
        for j = 1:m
            if k ~= j
                Lkn = Lkn .* ((xq - x(j))/(x(k) - x(j)));
            end
        end
        L = L + abs(Lkn);     
    end
    ll(i) = max(abs(L));
end
end