function fObj = Rastrigin(x)

Nd   = length(x);
fObj = 10*Nd + sum(x.^2 - 10*cos(2*pi*x));

endfunction
