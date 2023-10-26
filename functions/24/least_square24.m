xi_yi = load("data.mat").data;

m_max = 100 ;

xi = xi_yi(:,1);
yi = xi_yi(:,2);
% m<=n
er = zeros(1,m_max);

for m = 1:m_max
    
    px = polyfit(xi,yi,m);
    
    % hormer algorithm with reverse loop
    y = px(1);
    for i = 2:length(px)
        y = y .* xi + px(i);
    end

    er(m) = norm(xi.^m - y);
end 

% view
figure;
semilogy(1:m_max, er, '-');
xlabel('Least-square polynomial degree, m');
ylabel('Error');
grid on;