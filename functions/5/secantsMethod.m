function [x,i] = secantsMethod(f, x0, x1, tol)
%   [x,i] = secantsMethod(f,df,x0,tol, itmax)
%   
%   Ricerca la radice di una funzione di cui è nota la derivata a partire
%   da un approssimazione iniziale mediante il metodo delle secanti
%
%   Input:
%       f: funzione di cui si ricercano gli 0
%       x0: prima approssimazione iniziale della radice
%       x1: seconda approssimazione iniziale della radice
%       tol: errore assoluto ammissibile 
%   Output: 
%       x: approssimazione della radice di f
%       i: numero di iterazioni eseguite

if nargin ~= 4, error("Missing arguments"); end
if tol<0, error("Invalid arguments: tolerance must be non negative"); end

fx0 = feval(f,x0);
fx1= feval(f,x1);

x = x1-(fx1*(x1-x0))/(fx1-fx0);

i = 1;
while abs(x-x1) > tol*( 1 + abs(x1))
    i = i+1;

    x0 = x1;
    x1 = x;
    fx0 = fx1;
    fx1 = feval(f,x1);
    if fx0 == fx1, 
        error("Invalid initial approximations: "+ ...
            "function assume same value in different points");
    end 
    x = x1-(fx1*(x1-x0)/(fx1-fx0));
end
return
end