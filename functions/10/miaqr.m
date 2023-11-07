function [x,nr] = miaqr(A,b)
%   [x, nr] = miaqr(A,b)
%
%   Calcola la soluzione del sistema lineare sovradimensioanto Ax = b 
%   nel senso dei minimi quadrati e restituisce la norma del
%   corrispondente vettore residuo
%
%   Input: 
%       A:  matrice dei coefficienti del sistema
%       b:  vettore dei termini noti 
%   Output: 
%       x:  soluzione nel senso dei minimi quadrati
%       nr: norma del vettore resiudo

[m,n] = size(A);
if(n>=m), errror("Il sistema non è sovradimensionato"); end 
if(m~=length(b))
    error("Le dimensioni della matrice e del vettore non sono coerenti");
end
for i=1:n
    alfa = norm( A(i:m,i));
    if alfa==0,error("La matrice A non ha rango massimo");end
    if(A(i,i)>=0), alfa = -alfa; end
    v = A(i,i) - alfa;
    A(i,i) = alfa;
    A(i+1:m,i) = A(i+1:m,i)/v;
    beta = -v/alfa;
    A(i:m,i+1:n) = A(i:m,i+1:n)-(beta*[1;A(i+1:m,i)])*...
        ([1;A(i+1:m,i)]'*A(i:m,i+1:n));
end
for i=1:n
    v = [1;A(i+1:m,i)];
    beta = 2/(v'*v);
    b(i:end) = b(i:end)-(beta*(v'*b(i:end)))*v;
end
for i=n:-1:1
    b(i) = b(i)/A(i,i);
    b(1:i-1) = b(1:i-1)-A(1:i-1,i)*b(i);
end
x = b(1:n);
nr = norm(b(n+1:m));
return ;
end