%% Cuckoo Search via L'evy Flight Algorithm method [1]
%
% CS - performs a metaheuristic procedure to solve a simple-constrained
%        optimisation problem, such as:
%
%                min FOBJ(x),    where X = [X_1, X_2, ..., X_Nd]',
%                 X
%                 subject to     X_lb <= X <= X_ub,
%
% XOPT = CS(FOBJ,BOUNDARIES) searchs a simple-constrained minimal XOPT of
% the fitness function (or objective function) FOBJ. The feasible region is
% drawn by the simple constraints given by BOUNDARIES. BOUNDARIES is a
% matrix of Nd-by-2, where Nd is the number of dimensions or variables.
% Elements of the first column of BOUNDARIES are lower boundaries of each
% design variable, and the elements of the second one are upper boundaries
% of each design variable.
%
% XOPT = CS(FOBJ,BOUNDARIES,PARAMETERS) searchs a simple-constrained
% minimal XOPT of the FOBJ function using a different set of tune parameters
% of the method. PARAMETERS contains tune parameters for CS and it is a
% struct defined as follows:
%
%                                      (default values)
%     PARAMETERS = struct(...
%                           'NAG'       ,   25   , ...  % Number of nests
%                           'BETA'      ,   1.5  , ...  % l'evy distr.
%                           'ALPHA'     ,   0.1  , ...  % step size scale factor
%                           'PD'        ,   0.25  , ...  % probability of discover eggs
%
%                           'EPS1'      ,   0.5  , ...  % historical eps.
%                           'EPS2'      ,   1e-3 , ...  % population eps.
%                           'MSAT'      ,   10   , ...  % max. saturation
%                           'MITE'      ,   1e12 , ...  % max. iteration
%                           'UNCONST'   ,   false  ...  % unconstrained
%                         );
%
% [XOPT,FOPT,DETAILS] = CS(FOBJ,BOUNDARIES,PARAMETERS) performs the above
% process but in this case the final value of fitness function (FOPT) and
% some additional information (DETAILS) are returned. DETAILS is also a
% struct which contains:
%
%       DETAILS.time    - time required (in seconds) to find XOPT
%              .fevs    - evaluations of fitness function done
%              .steps   - number of steps or iterations performed
%              .outmsg  - flag of convergence (1 is convergence)
%
% --------------------------------------------------------------------------
% Reference:
% [1] Yang, X.-S., & Suash Deb. (2009). Cuckoo Search via Levy flights.
%     In 2009 World Congress on Nature & Biologically Inspired Computing
%     (NaBIC) (pp. 210�214). IEEE. http://doi.org/10.1109/NABIC.2009.5393690
% --------------------------------------------------------------------------
%
% {Copyright (c) Jorge M. Cruz-Duarte. All rights reserved.}
%
% Departamento de Ingenier�a El�ctrica,
% Divisi�n de Ingenier�as, Campus Irapuato-Salamanca,
% Universidad de Guanajuato, Salamanca, Guanajuato, M�xico.
%
% Grupo de Investigaci�n CEMOS,
% Escuela de Ingenier�as El�ctrica, Electr�nica y de Telecomunicaciones,
% Universidad Industrial de Santander, Bucaramanga, Santander, Colombia.
%
% Modifications:
%                   2015-jul ver :: v0
%                   2016-apr ver :: v1
%
% Contact us: jorge.cruz@ugto.mx

function [BestNest,fBest,details] = CS_oct(fObj,bnd,parameters)

% Read parameters
if nargin < 3,
    Na      = 25;                   % Number of nests
    pD      = 0.25;                 % Probability of discover eggs
    Xi    = 1.5;                     % Xi parameter to calculate sigma
    Delta   = 0.1;                 % Step size scale factor

    eps1    = 1e-1;
    eps2    = 1e-3;
    M       = 1e3;
    msat    = 20;

    unconst = false;
else
    Na      = parameters.NAG;
    pD      = parameters.PD;
    Xi    = parameters.XI;
    Delta   = parameters.DELTA;

    eps1    = parameters.EPS1;
    eps2    = parameters.EPS2;
    M       = parameters.MITE;
    msat    = parameters.MSAT;

    unconst = parameters.UNCONST;
end

% ------------------------------------------------------------- Initialise Block
% Read problem's dimensions
Nd          = size(bnd,1);

% Sort and make-up boundaries
bnd         = [min(bnd,[],2) max(bnd,[],2)];
bnd_1       = ones(Na,1)*bnd(:,1)';
bnd_2       = ones(Na,1)*bnd(:,2)';

% Initialise nests
Nests       = bnd_1 + rand(Na,Nd).*(bnd_2 - bnd_1);

% ------------------------------------------------------ Evaluate Function Block
Fitness     = evaluateFunction(Na,fObj,Nests);

% --------------------------------------------------------- Rank Positions Block
[fBest,g]   = min(Fitness);
BestNest    = Nests(g,:);

% Set auxiliar variables
steps       = 1;

%% Main process
do

    % Get a cuckoo randomly by L'evy flight
    Nests_       = LevyFlight(Nests,Delta,Xi,BestNest);

    % Check if the particle is in search space
    Nests_       = simpleConstraints(Nests_,bnd_1,bnd_2);

    % Found the best position for each particle
    [Nests,Fitness] = updatePositions(Na,Nd,fObj,Fitness,Nests_,Nests);

    % A fraction (pD) of worse nests are abandoned and new ones are built
    Nests_           = randomlyDiscoveringEggs(Na,Nd,pD,Nests,Fitness);
    %Nests_           = proportionallyDiscoveringEggs(Na,Nd,pD,Nests,Fitness);

     % Check if the particle is in search space
    Nests_       = simpleConstraints(Nests_,bnd_1,bnd_2);

    % Found the best position for each particle
    [Nests,Fitness] = updatePositions(Na,Nd,fObj,Fitness,Nests_,Nests);

    % Find the Nest best position (initial step)
    [fBest,g] = min(Fitness); BestNest = Nests(g,:);

until steps++ >= M,
--steps,

endfunction
