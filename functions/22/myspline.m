function yy = myspline( x, fi, xx, type )
%
%   Se type è uguale a 0 allora calcola la spline cubica interpolante 
%   naturale i punti (xi(i),fi(i)), mentre se type è diverso da 0 allora 
%   calcola quella not-a-knot (default) 
%
%   Input:
%       xi:     vettore delle ascisse di interpolazione 
%       fi:     valori assunti dalla funzione nei rispettivi punti xi
%       xx:     ascisse su cui deve essere calcolata la spline
%       type:   valore che stabilisce il tipo di spline da creare
%   Output: 
%       yy:     valori assunti dalla spline nei rispettivi punti xx 
if nargin < 3, error("argomenti essenziali assenti"); end
if nargin == 3, type = 1; end
if size(xi) ~= size(fi), error("Le quantità di dati forniti per " + ...
        "l'interpolazione non corrispondono"); end
if length(xi) ~= length(unique(xi)), error("Le ascisse di " + ...
        "interpolazione devono essere tutte distinte tra loro");end
% si utilizzerà la fattorizzazione LU per trovare i membri m0...mn 
n = length(xi);
for i = 1:n, h(i) = x(i+1)-x(i);end
for i = 1:n-1, phi(i) = h(i)/(h(i)+h(i+1));end
for i = 1:n-1, xi(i) = h(i+1)/(h(i)+h(i+1));end
if type ==0 % spline naturale 
    m(1)= 0;
    M = diag(2*ones(1,n)) + diag(xi(2:n-2)*ones(1,n-1),1) + ...
        diag(phi(2:n-1)*ones(1,n-1),-1);

    % qui ci vanno le differenze divise 
    % f[x0,x1,x2] f[x1,x2,x3] ... f[xn-2,xn-1,xn]

    % risolvere con fattorizzazione LU il sistema M*m = 6*f e il 
    % risultato è m(2:n)

    m(n+1) = 0;

else %spline not-a-knot
    
    m(1) = 0;

    M = diag(2*ones(1,n)) + diag(xi(2:n-2)*ones(1,n-1),1) + ...
        diag(phi(2:n-1)*ones(1,n-1),-1);
    % la matrice M va un po' modificata (vedere appunti)

    %risolvere il sistema come prima
    
    % m0 = 6f[x0,x1,x2]-m1-m2
    % mn = 6f[x(n-2),x(n-2),xn]-m(n-1)-m(n-2)
end

%eventualmente tirare fuori dall'if-else parti uguali

%utilizzare gli m e gli h per la formula della spline (vedere 
% appunti o libro) e poi calcolare

end