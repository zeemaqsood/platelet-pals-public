function S = Steady_States(model)

if model
    Models(model, 'N');
end

dydt = Write_Eqns("Stable");

global Vars;

n = size(Vars, 1);

for i = 1:n
    eval(strcat(Vars{i},' = sym(Vars{i})', ';'));
end

eqns = sym('eqns', [1, n + size(dydt, 1)]);

for i = 1:n
    eqns(2 * i - 1) = eval(dydt(i));
    eqns(2 * i) = eval(Vars{i}) >= 0;
end

for i = 1:size(dydt, 1) - n
    eqns(2 * n + i) = eval(dydt(n + i));
end

S = solve(eqns, Vars, 'ReturnConditions', true);



for i = 1:size(Vars, 1)
    eval(strcat("S." , Vars(i), " = eval(", strcat("vpa(S.", Vars(i), ")"), ");"));
end

disp(struct2table(S));
end
