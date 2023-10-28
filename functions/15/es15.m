clear;
addpath(genpath("../14"));

e = 1e-2*(1:100)';
Q = 2*eye(100)+ diag(ones(99,1),1) + diag(ones(99,1),-1);
f = @(x) 1/2*x'*Q*x-e'*(sin((pi/2)*x)+x);
J = @(x) Q+e'*(sin((pi/2)*x));
delta  = @(x) Q*x-e'*(1+cos((pi/2)*x));
x0 = zeros(100,1);

x = zeros(100,1);
tol = [1e-3; 1e-8;1e-13];
nit = [0 0 0]';

for i = 1:3
	[x(:), nit(i)] = newton(delta,J,x0,tol(i));
	writetable(...
	    table((1:100)',x(:),'VariableNames',{'Indice','Valore'}), ...
	    "tab"+i+".xlsx");
	figure;
	plot(1:100,x(:));
	title("Tolleranza = " + num2str(tol(i)));
end

writetable(table(tol,nit,'VariableNames',{'tol','nit'}),'nit.xlsx');
