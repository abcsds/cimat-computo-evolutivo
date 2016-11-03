function fObj = Bird(x)

fObj = sin(x(1))*exp((1 - cos(x(2)))^2) + cos(x(2))*exp((1 - sin(x(1)))^2) + ...
        (x(1) - x(2))^2;

endfunction
