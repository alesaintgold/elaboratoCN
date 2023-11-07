function [If,nval] = newtoncotesadaptive(fun,a,b,tol,fa,fm,fb,f1,f3)
% [If,nval] = newtoncotes4(fun,a,b,tol,fa,fm,fb,f1,f3)
%
%   Implementa la formula composita adattativa di Newton-Cotes
%   di grado 4 per calcolare il valore dell'integrale della 
%   funzione f nell'intervallo [a,b]
%
%   Input:
%       fun:        funzione integranda
%       a:          estremo sinistro dell'intervallo (a=x0)
%       b:          estremo destro dell'intervallo (b=x4)
%       tol:        tolleranza desiderata dell'errore
%       fa,fb,fm:   (opzionali) valori assunti dalla funzione
%                   nelle ascisse x0, x4, x2 (rispettivamente)
%   Output: 
%       If:         stima dell'integrale
%       nval:       numero di valutazioni funzionali effettuate

if nargin<4, error("Argomenti essenziali mancanti");end
if tol<=0, error("Tolleranza non positiva");end
if b<a,error("Estremi dell'intervallo non validi");end

x2 = a+(b-a)/2;

if nargin==9

    f = [fa,f1,fm,f3,fb];
    nval = 0;
else
    x1 = (a+x2)/2;
    x3 = (x2+b)/2;

    x = [a x1 x2 x3 b];
    f = zeros(1,5);
    for i =1:5
        f(i) = feval(fun,x(i));
    end
    nval = 5;
end
h = (b-a)/4;

w = [14/45 64/45 8/15 64/45 14/45]';
If = h*(f*w);


he = (b-a)/8;
%sottointervallo sinistro
    x5 = (a+x1)/2;
    x6 = (x1+x2)/2;
    f5 = feval(fun,x5);
    f6 = feval(fun,x6);
    
    %vettore delle fi dell'intervallo sinistro
    fL = [f(1),f5,f(2),f6,f(3)];

    IfL = he*(fL*w);

%sottointervallo destro
    x7 = (x2+x3)/2;
    x8 = (x3+b)/2;
    f7 = feval(fun,x7);
    f8 = feval(fun,x8);
    
    fR = [f(3),f7,f(4),f8,f(5)];
    
    IfR = he*(fR*w);

% si contano insieme le valutazioni per entrambi gli intervalli
nval = nval+4;

%intervallo totale
If4 = IfL + IfR;

err = abs((If4-If)/63);

if(err<=tol)
    If = If4;
    return;
end

[IfL,nvalL] = newtoncotesadaptive(fun,a,x2,tol/2,f(1:3),f5,f6);
[IfR,nvalR] = newtoncotesadaptive(fun,x2,b,tol/2,f(3:5),f7,f8);

If = IfL+IfR;
nval = nval + nvalL+nvalR;
return;
end