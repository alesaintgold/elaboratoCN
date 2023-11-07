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

if tol<0, error("Tolleranza non positiva");end
if a>b, error("Intervallo non valido");end
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

x1 = (a+xm)/2;
x2 = (b+xm)/2;

f1 = feval(fun,x1);
f2 = feval(fun,x2);
nval = nval +2;

I2 = h*(fa + 4*fm + fb)/3;
If = h*(fa + 4*f1 + 2*fm + 4*f2 + fb)/6;

err = abs(If-I2)/15;

if err>tol        
    [IfL,navlL] = simpsonadaptive(fun,a,xm,tol/2,fa,f1,fm);
    [IfR,nvalR] = simpsonadaptive(fun,xm,b,tol/2,fm,f2,fb);
    
    If = IfL + IfR;
    nval = nval + nvalR + navlL;
end

return;
end
