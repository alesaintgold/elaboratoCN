function [If,err] = composita( fun, a, b, k, n )
% [If,err] = composita( fun, a, b, k, n )
%
%   Calcola l' integrale della funzione fun mediante l'utilizzo della 
%   formula composita di Newton-Cotes di grado k su n intervalli 
%   equidistanti
%
%   Input:
%       fun:    la funzione integranda
%       a,b:    intervalli di integrazione
%       k:      grado della formula di Newton-Cotes
%       n:      numero di intervalli
%
%   Output:
%       If:     stima dell'integrale
%       err:    stima dell'errore di quadratura

if b < a
    error("L'intervallo specificato non è corretto " + ...
        "l'estremo superiore non può essere minore di quello inferiore");
end

if mod(n,2)~=0 || mod(n,k)~=0
    error("n deve essere un multiplo pari di k");
end

if (mod(k,2) == 0) 
    m=2;
else 
    m=1;
end

w = newtonCotesWeights(k);

If = 0;
Ie = 0;
h = (b-a)/n;
he = (b-a)/(n/2);

for i=0:n-1
    x = linspace(a+i*h, a+(i+1)*h, k+1);
    y = feval(fun,x);
    If = If + (h/k)*sum(y.*w);
end
for i = 0:n/2-1
    x = linspace(a+i*he, a+(i+1)*he,k+1);
    y = feval(fun,x);
    Ie = Ie + (he/k)*sum(y.*w);
end
err = abs((If-Ie)/(2^(k+m)-1));
end