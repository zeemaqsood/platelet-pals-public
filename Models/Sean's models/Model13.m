function Model13

global Model_names Vars Plot_Vars IVs K eqns multiples catalysts constants n;

Model_names(13) = "Double L, mouse";

n = 4;

Vars = cell(4, 1);
IVs = zeros(4, 1);
K = zeros(2, 2);

% Variable names and their initial values
Vars{1} = 'LL';     IVs(1) = 100;
Vars{2} = 'R';      IVs(2) = 6.445 * 10^-3;
Vars{3} = 'LL_R';    IVs(3) = 0;
Vars{4} = 'LL_RR';   IVs(4) = 0;

% Formal variable names displayed when used to plot graphs. If you would
% like to change any, do so here

Plot_Vars = Create_plot_vars(Vars);

% Define the K values. If no reverse reaction occurs, set the second value
% to zero
K(1, :) = [10^-3, 0]; % nM^-1s^-1, s^-1
K(2, :) = [10^4, 10^-2]; % nM^-1s^-1, s^-1

% Define the reactions i.e. {[1, 2],  6,  [1, 2]} means variables 1 and 2
% react to make variable 6 with rate constant K(1) and the reverse reaction 
% happens with rate constant K(2)

eqns = cell(1, 2);

%            in           out     k value numbers
eqns{1} = {["LL", "R"],  "LL_R",  1};
eqns{2} = {["R", "LL_R"], "LL_RR", 2};

eqns = vars2nums(eqns);
    

% Reactions which have multiple possibilities
multiples = cell(1, 2);

multiples{1} = zeros(0, 1);
multiples{2} = zeros(0, 1);
      
%                 Eqn No               Mult
% multiples{1}(1) = 1;  multiples{2}(1) = 2;
% multiples{1}(2) = -2;  multiples{2}(2) = 2;
      
% Variables which are not used in a reaction, just used as a catalyst
catalysts = cell(1, 2);

% How many catlysts occur?
catalysts{1} = []; % zeros(2, 1);
catalysts{2} = []; % strings(2, 1);

%                 Eqn number            Var
% catalysts{1}(1) = 1; catalysts{2}(1) = "LL";

catalysts{2} = vars2nums(catalysts{2});
      
% Variables which we assume to stay constant
constants = vars2nums(1);
    
end