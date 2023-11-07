function [x,n] = newtonMethod(f,df, x0, tol)
%   [x,n] = newtonMethod(f,df,x0,tol, itmax)
%   
%   Ricerca la radice di una funzione di cui è nota la derivata a partire
%   da un approssimazione iniziale mediante il metodo di Newton
%
%   Input:
%       f: funzione di cui si ricercano le radici
%       df: derivata della funzione f
%       x0: approssimazione iniziale della radice
%       tol: errore assoluto ammissibile 
%   Output: 
%       x: approssimazione della radice di f
%       n: numero di iterazioni eseguite 

if nargin ~= 4, error("Missing arguments"); end
if tol<0, error("Invalid arguments: tolerance must be non negative"); end
x = x0;
fx = feval(f,x);
dfx =  feval(f,x);

x = x0- fx/dfx;

n = 1;
while abs(x-x0) > tol*( 1 + abs(x0))
   
    x0 = x;

    fx = feval(f,x0);  
    dfx = feval(df, x0);
    
    if dfx==0
        error("Value of derivative function is 0," + ...
            "invalid first approximation"); 
    end
    n = n+1;
    x = x0 - fx/dfx; 
end
return
end