% OPTIMISATION PROBLEMS, taken from:
%     1. Jamil, M. & Yang, X. S. A literature survey of benchmark functions for
%        global optimisation problems. Int. J. Math. Model. Numer. Optim. 4, 150
%        (2013).
%     2. Soneji, H. & Sanghvi, R. C. Towards the improvement of Cuckoo search
%        algorithm. Int. J. Comput. Inf. Syst. Ind. Manag. Appl. 6, 77–88 (2014).
%     3. Rakhshani, H. & Rahati, A. Intelligent Multiple Search Strategy Cuckoo
%        Algorithm for Numerical and Engineering Optimization Problems. Arab. J.
%        Sci. Eng. (2016). doi:10.1007/s13369-016-2270-8

% Benchmark functions:
% --
% 1. Ackley 1 from [1]
%Nd          = 2;
%[optX,optF] = CS_oct(@(x) Ackley1(x),ones(Nd,1)*[-35 35])

% 2. Beale from [1]
[optX,optF] = CS_oct(@(x) Beale(x),ones(2,1)*[-35 35])

% 3. Bird from [1]
[optX,optF] = CS_oct(@(x) Bird(x),ones(2,1)*[-2*pi 2*pi])

% 4. Rosenbrock from [1]
[optX,optF] = CS_oct(@(x) Rosenbrock(x),ones(2,1)*[-30 30])

% 5. Rastrigin from [2]
%[optX,optF] = CS_oct(@(x) Rastrigin(x),ones(2,1)*[-1 1])

% Benchmark problems:
% --
% 1. Welded Beam Design from [3]
%[optX,optF] = CS_oct(@(x) WeldedBeamDesign(x),ones(4,1)*[0.1 10])
