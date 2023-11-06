function  [If,nval] = simpsonadaptive(fun,a,b,tol,fa,fm,fb)
%
%   [If,nval] = simpsonadaptive(fun,a,b,tol,fa,fm,fb)
% 
%   Ricerca l'integrale definito di una funzione mediante la 
%   formula adattativa di Simpson
%  
%   Input:
%       fun:        fuzione integranda
%       a,b:        estremi dell'intervallo di integrazione      
%       tol:        tolleranza dell'errore di quadratura 
%       fa,fm,fb:   (opzionali) valutazioni funzionali negli estremi 
%                   e nel punto mediano dell'intervallo di integrazione
%   Output:
%       If:         Stima dell'integrale
%       nval:       Numero di valutazioni funzionali effettuate
if b<=a, error("Intervallo di integrazione non valido");end
if tol<=0, error("Tolleranza non positiva");end

xm = (a+b)/2;
if nargin ==4
    fa = feval(fun,a);
    fm = feval(fun,xm);
    fb = feval(fun,b);
    
    nval = 3;
else
    nval= 0;
end

h = (b-a)/2;
w = [1 4 1]'/3;

f = [fa fm fb];

I2 = h*(f*w);

xl = (a+xm)/2;
xr = (b+xm)/2;

fmL = feval(fun,xl);
fmR = feval(fun,xr);

If = h*(fmL*w + fmR*w);

err = abs(If-I2)/15;

if err<tol,return;end

[IfL,navlL] = simpsonadaptive(fun,a,xm,tol/2,fa,fmL,fm);
[IfR,nvalR] = simpsonadaptive(fun,xm,b,tol/2,fm,fmR,fb);

If = IfL + IfR;
nval = nval + nvalR + navlL;

end
