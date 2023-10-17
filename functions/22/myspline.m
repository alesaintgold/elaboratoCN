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
fprintf("n = " +n +"\n");

for i=1:n, h(i)=xi(i+1)-xi(i);end
for i=1:n-1
    phi(i) = h(i)/(h(i)+h(i+1));
    xhi(i) = h(i+1)/(h(i)+h(i+1));
end
disp(phi)
disp(xhi)

f = fi; % differenza divise
for j = 1:2
    for i = 3:-1:j+1
        f(i) = (f(i)-f(i-1))/(xi(i)-xi(i-j));
    end
end
f = f(1:n-1);
if type == 0 %spline naturale 
    m(1) = 0;
  
    M = diag(2*ones(1,n-1))+...
        diag(xhi(1:n-2),1)+...
        diag(phi(2:n-1),-1);
    
    disp(M)
    disp(f);

    m(2:n-2) = mialu(M,6*f);
    m(n-1)=0;
end
print(m);
end