m = 20;
S = struct();

for i = 1:m     
    name = ['D', num2str(i)];
    S1 = struct('Position', i, 'TrackPos', 21 - i, 'RacingLine', 1, 'Skill', 1 - i * 0.01, 'Lap', 0, 'Tyre', 1, 'TyreWear', 1, 'LapTime', 0);
    eval(strcat("S.", 'D', num2str(i), " = S1"));
end
