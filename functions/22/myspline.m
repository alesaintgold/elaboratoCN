function yy = myspline(xi, fi, xx, type )
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

n = length(xi)-1;

h = zeros(1,n);
for i=1:n, h(i)=xi(i+1)-xi(i);end
phi = zeros(1,n);
xhi = zeros(1,n);
for i=1:n-1
    phi(i) = h(i)/(h(i)+h(i+1));
    xhi(i) = h(i+1)/(h(i)+h(i+1));
end

f = fi ; %differenze divise
for j = 1 : 2
    for i = n+1 : -1 : j +1
        f(i) = (f(i)-f(i-1))/(xi(i)-xi(i-j));
    end
end
f = f (3: n+1) ; % Calcolo le differenze divise

%definizione diagonali del sistema tridiagonale per trovare m0...mn
if type==0 %spline naturale 
    a = 2*ones(n-1,1);  %size n-1
    b = xhi(1:n-2);     % n-2
    c = phi(2:n-1);      % n-2
    d = 6*f;
else %spline not-a-knot
    a = [1 2-phi(1) 2*ones(n-3,1) 2-xhi(n-1) 1];%size 2+n-3+2=n+1
    b = [0 xhi(i)-phi(i) xhi(2:n-1)];           % 2+n-2=n
    c = [phi(1:n-2) phi(n-1)-xhi(n-1) 0];       % n-2+2 = n
    d = 6*[f(1) f f(end)];
end

%risoluzione sistema tridiagonale
dim = length(d);    
m = zeros(dim,1);
for i = 2:dim
    w = c(i-1)/a(i-1);
    a(i) = a(i)-w*b(i-1);
    d(i) = d(i)-w*d(i-1);
end

m(end) = d(end)/a(end);
for i = (dim-1):(-1):1
    m(i) = (d(i)-b(i)*m(i+1))/a(i);
end

if type == 0 %spline cubica
    m = [0 m' 0];
else % spline not-a-knot
    m(1) = m(1)-m(2)-m(3);
    m(n+1) = m(n+1)-m(n)-m(n-1);
end

yy = zeros(length(xx),1) ;
for j = 1:length(xx)
    for i = 2:length(xi)
        if ((xx(j)>=xi(i-1) && xx(j)<=xi(i)) || xx(j)<xi(1))
            r = fi(i-1)-h(i-1)^2/6*m(i-1) ;
            q = (fi(i)-fi(i-1))/h(i-1)-h(i-1)/6*(m(i)-m(i-1)) ;
            yy (j) =((xx(j)-xi(i-1))^3*m(i)+ ...
                (xi(i)-xx(j))^3*m(i-1))/(6*h(i-1))+...
                q*(xx(j)-xi(i -1))+...
                r;
            break
        end
    end
end
return;
end