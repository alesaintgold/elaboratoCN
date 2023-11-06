addpath(genpath("../28"));
addpath(genpath("../29"));

f = @(x) cos(-log(x))/x;
tol = [1e-2 1e-3 1e-4 1e-5 1e-6 1e-7 1e-8 1e-9];
result = sin((log(1e5)));

nval = zeros(8,3);

err = zeros(8,3);
for i = 1:8
    nval(i,1) = tol(i);
    err(i,1) = tol(i);
    [resultS,nval(i,2)] = simpsonadaptive(f,1e-5,1,tol(i));
    [resultNC,nval(i,3)] = newtoncotesadaptive(f,1e-5,1,tol(i));
    err(i,2) = abs(resultS-result);
    err(i,3) = abs(resultNC -result);
end

nval_table = array2table(nval, ...
    "VariableNames",{'Tolleranza','Simpson','Newton-Cotes'});

err_table = array2table(err,...
    "VariableNames",{'Tolleranza','Errore Simpson','Errore Newton Cotes'});

disp(nval_table);
disp(err_table);

writetable(nval_table, "num_feval.txt");
writetable(err_table, "err.txt");