addpath(genpath('../25'));
addpath(genpath('../26'));
% Definizione della funzione da integrare
fun = @(x) fun_to_int(x);

% Intervallo di integrazione
a = 0;
b = 1;

% Gradi delle formule di Newton-Cotes
k_values = [1, 2, 3, 6];

% Numero di sottointervalli
n = 12;

If = zeros(size(k_values));
err = zeros(size(k_values));

i=1;
for k = k_values
    % Calcola l'approssimazione dell'integrale
    [If(i), err(i)] = composita(fun, a, b, k, n);
    i = i+1;
end

t = table(If', err', 'VariableNames', ["Stima dell'Integrale", "Stima dell'errore"],'RowNames',{'1','2','3','6'});
disp(t);
function y = fun_to_int(x)
y = 0;
for i=1:5
    y = y + (i .* cos(2 * pi * i .* x) - exp(i) .* sin(2 *( pi * i + 0.1).* x));
end
end
