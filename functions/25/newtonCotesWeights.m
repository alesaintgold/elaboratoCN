function w = newtonCotesWeights(n)
% w = newtonCotesWeights(n)
%
%   Calcola i pesi della formula di quadratura di Newton-Cotes di grado n
% 
%   Input:
%       n:  grado della formula di Newton-Cotes 
%   Output:
%       w:  vettore dei pesi dei coefficienti

if ~isnumeric(n) || n <= 0 || mod(n, 1) ~= 0
    error("Il grado n deve essere un numero intero positivo");
end

x = 0:n;
w = zeros(1, n + 1);

for i = 1:n+1
    L = 1;
    for j = 1:n+1
        if j ~= i
            L = conv(L, [1, -x(j)]) / (x(i) - x(j));
        end
    end
    w(i) = polyval(polyint(L), n);
end
end