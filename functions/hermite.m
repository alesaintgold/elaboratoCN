function yy = hermite( xi, fi, f1i, xx )
%
n = length(xi);
if n ~= length(fi) 
    error("il numero di punti sulle ascisse xi non è coerente con il numero di quelli sulle ordinate fi"); % ---
end
if n ~= length(f1i)
    error("il numero di punti sulle ascisse xi non è coerente con il numero di quelli sulle ordinate fi"); % ---
end
if n ~= length(unique(xi))
    error("le ascisse di interpolazione non sono tutte distinte");
end
for i = n:2
    fi(i) = (fi(i) - fi(i-1)) / (xi(i) - xi(i-1));
end
for j = 1:n-1
    for i = n:-1:j+1
        f1i(i) = (f1i(i) - fi(i)) / (xi(i) - xi(i-j));
        fi(i) = (fi(i) - f1i(i-1)) / (xi(i-1) - xi(i-j));
    end
end

end

