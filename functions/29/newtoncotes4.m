function [If,nval] = newtoncotes4(fun,a,b,tol,fa,fb,fmed)
% Implementa la formula composita adattativa di Newton-Cotes di grado 4 
% per calcolare il valore dell'integrale della funzione f nell'intervallo
% [a,b]
%   Input:
%       fun:        funzione integranda
%       a:          estremo sinistro dell'intervallo (a=x0)
%       b:          estremo destro dell'intervallo (b=x4)
%       tol:        tolleranza desiderata dell'errore
%       fa,fb,fm:   (opzionali) valori assunti dalla funzione
%                   nelle ascisse x0, x4, x2 (rispettivamente)
%   Output: 
%       If:     stima dell'integrale
%       nval:    numero di valutazioni funzionali effettuate
if nargin<4, error("Argomenti essenziali mancanti");end
if tol<=0, error("Tolleranza non positiva");end
if b<a,error("Estremi dell'intervallo non validi");end

f = zeros(5,1);

x1 = a+(b-a)/4;
f(2) = feval(fun,x1);%f1

x3 = a+3*(b-a)/4;
f(4) = feval(fun,x3);%f3

x2 = a+(b-a)/2;
if nargin==4
    f(1) = feval(fun,a);%f0
    f(3) = feval(fun,x2);%f2
    f(5) = feval(fun,b);%f4

    nval = 5;
else
    f(1) = fa;
    f(3) = fmed;
    f(5) = fb;

    nval = 2;
end
h = (b-a)/4;

w = newtonCotesWeights(4);
If = h*(w*f);

err = 8/945*h^7*max(f); 

if(err>tol)
    [IfL,nvalL] = newtoncotes4(fun,a,x2,tol/2,f(1),f(3),f(2));
    [IfR,nvalR] = newtoncotes4(fun,x2,b,tol/2,f(3),f(5),f(4));

    If = IfL+IfR;
    nval = nval + nvalL+ nvalR;
end
return ;
end