function Model10

global Model_names Vars Plot_Vars IVs K eqns multiples catalysts constants n;

Model_names(10) = "Quadruple L";

% Number of variables
n = 6;

Vars = cell(n, 1);
IVs = zeros(n, 1);
K = zeros(4, 2);

% Variable names and their initial values
Vars{1} = 'LLLL';      IVs(1) = 1;
Vars{2} = 'R';         IVs(2) = 1;
Vars{3} = 'LLLL_R';    IVs(3) = 0;
Vars{4} = 'LLLL_RR';   IVs(4) = 0;
Vars{5} = 'LLLL_RRR';  IVs(5) = 0;
Vars{6} = 'LLLL_RRRR'; IVs(6) = 0;

% Formal variable names displayed when used to plot graphs. If you would
% like to change any, do so here

Plot_Vars = Create_plot_vars(Vars);

% Define the K values. If no reverse reaction occurs, set the second value
% to zero
K(1, :) = [0.1, 0.1];
K(2, :) = [1, 0.1];
K(3, :) = [10, 0.1];
K(4, :) = [100, 0.1];

% Define the reactions i.e. {[1, 2],  6,  [1, 2]} means variables 1 and 2
% react to make variable 6 with rate constant K(1) and the reverse reaction 
% happens with rate constant K(2)

eqns = cell(1, 3);

%            in           out     k value numbers
eqns{1} = {["R", "LLLL"],     "LLLL_R",    1};
eqns{2} = {["R", "LLLL_R"],   "LLLL_RR",   2};
eqns{3} = {["R", "LLLL_RR"],  "LLLL_RRR",  3};
eqns{4} = {["R", "LLLL_RRR"], "LLLL_RRRR", 4};

eqns = vars2nums(eqns);
    

% Reactions which have multiple possibilities
multiples = cell(1, 2);

multiples{1} = zeros(0, 1);
multiples{2} = zeros(0, 1);
      
%                 Eqn No               Mult
% multiples{1}(1) = 1;  multiples{2}(1) = 4;
% multiples{1}(2) = 2;  multiples{2}(2) = 3;
% multiples{1}(3) = -2; multiples{2}(3) = 2;
% multiples{1}(4) = 3;  multiples{2}(4) = 2;
% multiples{1}(5) = -3; multiples{2}(5) = 3;
% multiples{1}(6) = -4; multiples{2}(6) = 4;
      

% Variables which are not used in a reaction, just used as a catalyst
catalysts = cell(1, 2);

% How many catlysts occur?
catalysts{1} = zeros(0, 1);
catalysts{2} = strings(0, 1);

%                 Eqn number            Var

catalysts{2} = vars2nums(catalysts{2});
      

% Variables which we assume to stay constant
constants = vars2nums(1);
    
end