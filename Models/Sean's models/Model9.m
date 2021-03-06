function Model9

global Model_names Vars Plot_Vars IVs K eqns multiples catalysts constants n;

Model_names(9) = "Triple L";

% Number of variables
n = 5;

Vars = cell(n, 1);
IVs = zeros(n, 1);
K = zeros(3, 2);

% Variable names and their initial values
Vars{1} = 'LLL';      IVs(1) = 1;
Vars{2} = 'R';        IVs(2) = 1;
Vars{3} = 'LLL_R';    IVs(3) = 0;
Vars{4} = 'LLL_RR';   IVs(4) = 0;
Vars{5} = 'LLL_RRR';  IVs(5) = 0;

% Formal variable names displayed when used to plot graphs. If you would
% like to change any, do so here

Plot_Vars = Create_plot_vars(Vars);

% Define the K values. If no reverse reaction occurs, set the second value
% to zero
K(1, :) = [0.1, 0.1];
K(2, :) = [1, 0.1];
K(3, :) = [10, 0.1];

% Define the reactions i.e. {[1, 2],  6,  [1, 2]} means variables 1 and 2
% react to make variable 6 with rate constant K(1) and the reverse reaction 
% happens with rate constant K(2)

eqns = cell(1, 3);

%            in           out     k value numbers
eqns{1} = {["R", "LLL"],    "LLL_R",   1};
eqns{2} = {["R", "LLL_R"],  "LLL_RR",  2};
eqns{3} = {["R", "LLL_RR"], "LLL_RRR", 3};

eqns = vars2nums(eqns);
    

% Reactions which have multiple possibilities
multiples = cell(1, 2);

multiples{1} = zeros(0, 1);
multiples{2} = zeros(0, 1);
      
%                 Eqn No               Mult
% multiples{1}(1) = 1;  multiples{2}(1) = 3;
% multiples{1}(2) = 2;  multiples{2}(2) = 2;
% multiples{1}(3) = -2; multiples{2}(3) = 2;
% multiples{1}(4) = -3; multiples{2}(4) = 3;


% Variables which are not used in a reaction, just used as a catalyst
catalysts = cell(1, 2);

% How many catlysts occur?
catalysts{1} = [];
catalysts{2} = [];

%                 Eqn number            Var

catalysts{2} = vars2nums(catalysts{2});
      

% Variables which we assume to stay constant
constants = vars2nums(1);
    
end