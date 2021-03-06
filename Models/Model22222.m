function Model22222

global Model_names Vars Plot_Vars IVs K K_units K_unit unit eqns multiples catalysts constants n PlotVars;

Model_names(22222) = "22222";

% Number of variables
n = 4;

Vars = cell(n, 1);
IVs = zeros(n, 1);
unit = "u";
PlotVars = cell(n, 1);

Var_unit = strings(n, 1);

% Variable names and their initial values
Vars{1} = 'LL';          IVs(1) = 1000;             Var_unit(1) = "u"; % 'L', 1, any of the following ["p", "n", "u", "m", "", "K", "M", "G", "T"]
Vars{2} = 'R';           IVs(2) = 1;                Var_unit(2) = "u";
Vars{3} = 'LL_R';        IVs(3) = 0;                Var_unit(3) = "u";
Vars{4} = 'LL_RR';       IVs(4) = 0;                Var_unit(4) = "u";

PlotVars{1} = 'LL';
PlotVars{2} = 'R';
PlotVars{3} = 'LLR';
PlotVars{4} = 'LLRR';

IVs = equiv(IVs, Var_unit, unit);
% disp(IVs(1,2));

% Formal variable names displayed when used to plot graphs. If you would
% like to change any, do so here

Plot_Vars = Create_plot_vars(PlotVars);

% Define the reactions i.e. {[1, 2],  6,  [1, 2]} means variables 1 and 2
% react to make variable 6 with rate constant K(1) and the reverse reaction 
% happens with rate constant K(2)

eqns = cell(2);


%            in           out     k value numbers
eqns{1} = {["LL", "R"], "LL_R", 1}; % {["R", "LL_R"], "LL_RR", 2}
eqns{2} = {["LL_R", "R"], "LL_RR", 2}; % {["R", "LL_R"], "LL_RR", 2}
% eqns{3} = {"L_R0_Syk", "L_R1_Syk", 3}; % {["R", "LL_R"], "LL_RR", 2}

eqns = vars2nums(eqns);   

% Define the K values. If no reverse reaction occurs, set the second value
% to zero
K = zeros(2, 2);
K_unit = "u"; % any of the following ["p", "n", "u", "m", "", "K", "M", "G", "T"]

K(1, :) = [1, 1];
K(2, :) = [1, 0.0001];

% Reactions which have multiple possibilities
multiples = cell(1, 2);

multiples{1} = zeros(1, 1);
multiples{2} = zeros(1, 1);
      
%                 Eqn No               Mult
multiples{1}(1) =  1; multiples{2}(1) = 2; % 1, 4
multiples{1}(2) = -2; multiples{2}(2) = 2; % 1, 4
      
% Variables which are not used in a reaction, just used as a catalyst
catalysts = cell(1, 2);

% How many catlysts occur?
catalysts{1} = zeros(0, 1);
catalysts{2} = cell(0, 1);

%                 Eqn number            Var
% catalysts{1}(1) = 3; catalysts{2}{1} = "L_R0_Syk"; % 1, "LL"

catalysts{2} = vars2nums(catalysts{2});
  
K_units = K_Var_units;

% Variables which we assume to stay constant
constants = vars2nums(1); % [1, 2]
    
end