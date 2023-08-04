function x_n = newtonMethod(f,df, x0, tol)
%
%   x = newtonMefuncthod(f,df,x0,tol, itmax)
%   
%   Ricerca la radice di una funzione di cui è nota la derivata a partire
%   da un approssimazione iniziale mediante il metodo di Newton
%
%   Input:
%       f: funzione di cui si ricercano gli 0
%       df: derivata della funzione f
%       x0: approssimazione iniziale della radice
%       tol: errore assoluto ammissibile 
%   Output: 
%       x: approssimazione della radice di f
%       n: numero di iterazioni eseguite 

%controllo valori input
if nargin ~= 4, error("Missing arguments"); end
if tol<0, error("Invalid arguments: tolerance must be non negative"); end
%if itmax<=0, error("Invalid argument: iterations number must be positive");end 

fx = feval(f, x0);
dfx = feval(df,x0);

x = x0 - fx/dfx;

n = 0;
while abs(x-x0) > tol*( 1 + abs(x0))
    n = n + 1;

    x0 = x;

    fx = feval(f,x0);  
    dfx = feval(df, x0);
    
    if dfx==0
        error("Value of derivative function is 0, invalid first approximation"); 
    end
    
    x = x0 - fx     /dfx; %calcolo effettivo 
end
%if n>=itmax, warning("Max number of iterations reached");end
x_n= [x,n];
return
end