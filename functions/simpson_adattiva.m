function [If, err] = simpson_adattiva(fun, a, b, tol)
%
%
if b < a
    error("L'intervallo specificato non è corretto " + ...
        "l'estremo superiore non può essere minore di quello inferiore");
end
if tol<0
    error("la tolleranza specificata deve essere maggiore di 0");
end

fa = feval(fun, a);
fb = feval(fun, b);
fm = feval(fun, (b-a)/2);

If = (b-a)/6 * (fa + 4*fm + fb);

if err > tol
    

end