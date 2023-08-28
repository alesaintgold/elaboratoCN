function ll = lebesgue(a, b, nn, type)
%
%
if a >= b
    error("l'estremo inferiore dell' intervallo non può essere " + ...
        "minore o coincidente con quello maggiore");
end

n = length(nn);  
ll = ones(length(n));
xq = linspace(a, b, 10001);

for i = 1:n
    if type == 0
        x = linspace(a, b, nn(i)+1);
    elseif type == 1
        x = chebyshev(nn(i), a, b);
    else
        error("il valore di type può essere soltanto 0 o 1");
    end

    L = zeros(size(xq));
    m = length(x);    
    for k = 1:m
        Lkn = ones(size(xq));
        for j = 1:m
            if k ~= j
                Lkn = Lkn .* ((xq - x(j))/(x(k) - x(j)));
            end
        end
        L = L + abs(Lkn);     
    end
    ll(i) = max(abs(L));
end
end