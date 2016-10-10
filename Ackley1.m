function fObj = Ackley1(x)

Nd   = length(x);
fObj  = -20*exp(-0.02*sqrt(sum(x.^2)/Nd)) - exp(sum(cos(2*pi*x))/Nd) + 20 + exp(1);
