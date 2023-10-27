addpath(genpath('../25'));

n = [1:7 9];

table = zeros(length(n), max(n) + 1);

for i = 1:length(n)
    weights = newtonCotesWeight(n(i));
    table(i, 1:n(i)+1) = weights;
end
T = array2table(table,"VariableNames",{'c0','c1','c2','c3','c4','c5','c6','c7','c8','c9'}, ...
    "RowNames",{'1','2','3','4','5','6','7','9'});
%format = '%.2f';
%writetable(T,'../../tables/table25.txt','Delimiter', '\t', 'WriteVariableNames', true, 'Format', format);
disp(table);
