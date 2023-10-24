addpath(genpath('16'));
addpath(genpath('17'));
addpath(genpath('19'));
addpath(genpath('18'));

% Gradi dei polinomi interpolanti
degrees = 2:2:100;

n = @newton;
l = @lagrange;
h = @hermite;
errors_ne = eval_error(n,degrees,0,false);
errors_nc = eval_error(n,degrees,1,false);
errors_le = eval_error(l,degrees,0,false);
errors_lc = eval_error(l,degrees,1,false);

errors_he = eval_error(h,degrees,0,true);
errors_hc = eval_error(h,degrees,1,true);


% Grafico dell'errore in scala semilogaritmica
figure;
semilogy(degrees, errors_ne, '-o',"Color","Red");
hold on;
semilogy(degrees, errors_nc, '-o',"Color","Blue");
semilogy(degrees, errors_le, '-x',"Color","Green");
semilogy(degrees, errors_lc, '-x',"Color","Magenta");
semilogy(degrees, errors_he, '-^',"Color","Black");
semilogy(degrees, errors_hc, '-^',"Color","Cyan");

grid on;

title('Errore di Interpolazione della Funzione di Runge');
xlabel('Grado del Polinomio Interpolante');
ylabel('Errore in Scala Semilogaritmica');

legend("newton equidistante","newton chebyshev", "lagrange equidistante", " lagrange chebyshev");

function errors = eval_error(interpol_fun, degrees, type, d)
% Funzione di Runge
fun = @(x) 1 ./ (1 + x.^2);

% Ascisse equidistanti nell'intervallo [-5, 5]
n_points = 10001;
x_interpol = linspace(-5, 5, n_points);

% Inizializza il vettore per l'errore
errors = zeros(1, length(degrees));

for i = 1:length(degrees)
    degree = degrees(i);

    if type == 0
        % Calcola i punti di interpolazione equidistanti
        x = linspace(-5, 5, degree + 1);
    elseif type == 1
        % Calcola i punti di interpolazione chebyshev
        x = chebyshev(degree + 1, -5, 5);
    end
    y = fun(x);

    % Calcola il polinomio interpolante
    if d == true
        y1 = -2 * x ./ ((1 + x.^2).^2);
        p = interpol_fun(x, y, y1, x_interpol);
    else
        p = interpol_fun(x, y, x_interpol);
    end
        % Calcola l'errore di interpolazione
        true_values = fun(x_interpol);
        errors(i) = max(abs(p - true_values));
end
end

