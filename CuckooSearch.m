%% Cuckoo Search via L'evy Flight method [1]
%
% CS - performs a metaheuristic procedure to solve a simple-constrained
%        optimisation problem, such as:
%
%                min FOBJ(X),    where X = [X_1, X_2, ..., X_Nd]',
%                 X
%                 subject to     X_lb <= X <= X_ub,
%
% XOPT = cuckooSearch(FOBJ,BOUNDARIES) searchs a simple-constrained minimal
% XOPT of the fitness function (or objective function) FOBJ. The feasible
% region is drawn by the simple constraints given by BOUNDARIES. BOUNDARIES
% is a matrix of Nd-by-2, where Nd is the number of dimensions or variables.
% Elements of the first column of BOUNDARIES are lower boundaries of each
% design variable, and the elements of the second one are upper boundaries
% of each design variable.
%
% --------------------------------------------------------------------------
% Reference:
% [1] Yang, X.-S., & Suash Deb. (2009). Cuckoo Search via Levy flights.
%     In 2009 World Congress on Nature & Biologically Inspired Computing
%     (NaBIC) (pp. 210-214). IEEE. http://doi.org/10.1109/NABIC.2009.5393690
% --------------------------------------------------------------------------

function [BestNest,fBest,details] = CuckooSearch(the_function,bnd)

% Parameters of Cuckoo Search
Na      = 25;         % Number of nests (Population) (default value = 25)
pD      = 0.25;       % Probability of discovering eggs (default value = 0.25)
Delta   = 1.0;        % Step size scale factor (default value = 1.0)

% Parameters for stop criteria
eps1    = 1e-2;       % Fitness value's tolerance (default value = 1e-2)
eps2    = 1e-12;      % Design variables' tolerance (default value = 1e-12)
mSat    = 100;        % Maximum number of saturated steps (default value = 1e2)

mIte    = 1e12;       % Maximum number of iterations (default value = 1e12)

% Parameter for the Mantegna's algorithm
Xi      = 1.5;        % (default value = 1.5) NOTE: Do not modify it!

% Detect the function's Nature
if ischar(the_function) == 1,
  fObj  = str2func(the_function);
else
  fObj  = the_function;
endif

% ------------------------------------------------------------------------------
% Insert here the Initialise Block
% ------------------------------------------------------------------------------

% ------------------------------------------------------------------------------
% Insert here the Evaluate Function Block
% ------------------------------------------------------------------------------

% -----------------------------------------------------------------------------
% Insert here the Rank Positions Block
% -----------------------------------------------------------------------------

% ------------------------------------------------------------------------------
% Initialise the auxiliar variables

do
    % --------------------------------------------------------------------------
    % Insert here the L'evy Flight Block
    % --------------------------------------------------------------------------

    % --------------------------------------------------------------------------
    % Insert here the Simple Constraints Block
    % --------------------------------------------------------------------------

    % --------------------------------------------------------------------------
    % Insert here the Update Positions Block
    % --------------------------------------------------------------------------

    % --------------------------------------------------------------------------
    % Insert here the Discovering Eggs Block
    % --------------------------------------------------------------------------

    % --------------------------------------------------------------------------
    % Insert here the Simple Constraints Block
    % --------------------------------------------------------------------------

    % --------------------------------------------------------------------------
    % Insert here the Update Positions Block
    % --------------------------------------------------------------------------

    % --------------------------------------------------------------------------
    % Insert here the Rank Positions Block
    % --------------------------------------------------------------------------

    % --------------------------------------------------------------------------
    % Insert here the Stop Criteria Block
    % --------------------------------------------------------------------------

    % Update auxiliar variables

until % what?,

% Write here a code to print things

endfunction
