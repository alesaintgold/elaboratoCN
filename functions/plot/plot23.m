addpath(genpath('22'));

fun = @(x) 1 ./ (1 + x.^2);

% Ascisse equidistanti nell'intervallo [-5, 5]
n_points = 10001;
x_interpol = linspace(-5, 5, n_points);
degrees=4:4:400;

% Inizializza il vettore per l'errore
err_nat = zeros(1, length(degrees));
err_nak = zeros(1, length(degrees));
for i=1:length(degrees)
    n = degrees(i);
    x = linspace(-5, 5, n + 1);
    y = fun(x);

    p_nat = myspline(x,y,x_interpol,0);
    p_nak = myspline(x,y,x_interpol,1);

    tv = fun(x_interpol);
    err_nat(i) = max(abs((p_nat).' - tv));
    err_nak(i) = max(abs((p_nak).' - tv));
end

figure;
semilogy(degrees, err_nat, '-', "Color", "Red");
hold on;
semilogy(degrees, err_nak, '-', "Color", "Blue");
grid on;
legend('spline naturale','spline not-a-knot');