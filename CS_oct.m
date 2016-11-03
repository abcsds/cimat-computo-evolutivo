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
%     (NaBIC) (pp. 210-214). IEEE. http://doi.org/10.1109/NABIC.2009.5393690
% --------------------------------------------------------------------------
%
%
% Contact us: jorge.cruz@ugto.mx

function [BestNest,fBest,details] = CS_oct(the_function,bnd,parameters)

% Read parameters
if nargin < 3,
    Na      = 25;                   % Number of nests
    pD      = 0.25;                 % Probability of discover eggs
    Xi    = 1.5;                     % Xi parameter to calculate sigma
    Delta   = 0.1;                 % Step size scale factor

    eps1    = .5e0;
    eps2    = 1e-12;
    mIte    = 1e12;
    mSat    = 100;

    unconst = false;
else
    Na      = parameters.NAG;
    pD      = parameters.PD;
    Xi    = parameters.XI;
    Delta   = parameters.DELTA;

    eps1    = parameters.EPS1;
    eps2    = parameters.EPS2;
    mIte    = parameters.MITE;
    mSat    = parameters.MSAT;

    unconst = parameters.UNCONST;
end

% Function's Nature
if ischar(the_function) == 1,
  fObj  = str2func(the_function);
else
  fObj  = the_function;
endif

% ------------------------------------------------------------- Initialise Block
[Nd,bnd_1,bnd_2,Nests] = initialise(bnd,Na);

% ------------------------------------------------------ Evaluate Function Block
Fitness     = evaluateFunction(Na,fObj,Nests);

% ------------------------------------------------------ Rank Positions Block
[fBest,g]   = min(Fitness);
BestNest    = Nests(g,:);

% Set auxiliar variables
steps       = 1;
saturation  = 0;

%data        = [steps,fBest,mean(Fitness),std(Fitness)]; % <----

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

    % Check convergence
    [condition,saturation] = stopCriteria(fBest,BestNest,Fitness,...
                              Nests,saturation,eps1,eps2,mSat);

    % Increase steps
    steps++;

%    data        = [data;[steps,fBest,mean(Fitness),std(Fitness)]]; % <----
until (steps > mIte) || condition,
--steps,
%figure,
%plot(data(:,1),data(:,3),'.k'), hold on,
%plot(data(:,1),data(:,3)-1*data(:,4),'.','Color',[.75 .75 .75]),
%plot(data(:,1),data(:,2),'.r'), hold off,
%ylim([0 10])

endfunction
