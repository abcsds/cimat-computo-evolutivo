function fObj = Rosenbrock(x)

Nd   = size(x,1);
fObj = sum(100*(x(2:end) - x(1:end-1).^2).^2 + (x(1:end-1) - 1).^2);
