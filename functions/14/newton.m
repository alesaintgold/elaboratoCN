function [x,nit] = newton(fun,jacobian,x0,tol,maxit)
%   [x,nit] = newton(fun,jacobian,x0,tol,maxit)
%
%   Utilizza il metodo di Newton per risolvere sistemi di equazioni
%   nonlineari
%
%   Input: 
%       fun: vettore delle funzioni del sistema 
%       jacobian: matrice jacobiana di fun
%       x0: approssimazione iniziale
%       tol: tolleranza aspettata
%       maxit: numero massimo di iterazioni ammesso
%   Output:
%       x: approssimazione della funzione
%       nit: numero delle iterazioni del metodo

if(nargin<4), tol = eps; end
if(nargin<5), maxit = 1e3; end
if(tol<=0),   error("La tolleranza deve essere positiva"); end 
if(maxit<=0), error("Il numero di iterazioni deve essere positivo"); end
x = x0;
nit = 0;
while(nit<maxit&&norm(x-x0)<=tol*(1+norm(x0)))
    x0 = x;
    fx0 = feval(fun,x0);
    jx0 = feval(jacobian,x0);
    x = x0 - fx0\jx0;
end
if(nit == maxit)
    disp("Il numero di iterazioni specificato non ha permesso " + ...
        "di raggiungere la tolleranza desiderata");
end
return;
end