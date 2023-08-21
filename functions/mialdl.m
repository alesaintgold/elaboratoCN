function x = mialdl(A,b)
%
% x = mialdl(A,b)
%
% presa in input una matrice ed un vettore calcola la soluzione del
% corrispondente sistema lineare utilizzando il metodo di fattorizzazione
% LDL
%
% Input:
% A = matrice dei coefficienti
% b = vettore dei termini noti
%
% Output:
% x = soluzione del sistema lineare
%
[m,n] = size(A);
if m ~= n
    error("la matrice non è quadrata");
end
if n ~= length(b)
    error("la lunghezza del vettore dei termini noti " + ...
        "non è coerente con quella della matrice");
end
if A(1,1) <= 0
    error("la matrice non è sdp");
end
% la matrice non è memorizzata in forma compressa! (cit. libro)
A(2:n,1) = A(2:n,1)/A(1,1);
for i = 2:n
    v = (A(i,1:i-1).') .* diag(A(1:i-1,1:i-1));
    A(i,i) = A(i,i) - A(i,1:i-1)*v;
    if A(i,i) <= 0
        error("la matrice non è sdp");
    end
    A(i+1:n,i) = (A(i+1:n,i) - A(i+1:n,1:i-1) * v) / A(i,i);
end
x = b;
for i = 2:n
    x(i:n) = x(i:n) - A(i:n,i-1) * x(i-1);
end
x = x ./ diag(A);
for i = n-1:-1:1
    x(1:i) = x(1:i) - A(i+1,1:i) .'* x(i+1);
end
end