function position = Racing(n, m, laps, varargin)

S = struct();

for i = 1:m     
    name = ['D', num2str(i)];
    S1 = struct('Position', i, 'TrackPos', 21 - i, 'RacingLine', 1, 'Skill', 1 - i * 0.01, 'Lap', 0, 'Tyre', 1, 'TyreWear', 1, 'LapTime', 0);
    eval(strcat("S.", 'D', num2str(i), " = S1"));
end

i = 1;

while i <= length(varargin)
    if varargin{i} == "Tyre"
        S.D1.Tyre = varargin{i + 1};
        i = i + 2;
    end
end

Tyre = zeros(m, 1);

r = rand(m, 1);
Tyre(:) = 3;
Tyre(3 * r <= 2) = 2;
Tyre(3 * r <= 1) = 1;

if exist('STyre', 'var')
    Tyre(1) = STyre;
end

Wear = ones(m, 1);
Wear(Tyre == 2) = 0.9;
Wear(Tyre == 3) = 0.8;

Laptimes = [transpose(1:m), zeros(m, laps)];


Test = [transpose(m:-1:1), ones(m, 1), transpose(1:m), transpose(0.99:-0.01:0.8), zeros(m, 1), Wear, Tyre, zeros(m, 1)];

stats = [transpose(1:m), zeros(m, 10000)];
Position = [transpose(1:m), zeros(m, 10000)];

lap = 0;
i = 1;
while lap < laps
    new_Test = Test;
    dist = 5 * ones(m, 1);
    r = rand(m, 1);
    dist(r > 0.5) = 4;
    dist(all([r > 0.5, Test(:, 6) .* Test(:, 4) > 2 * r - 1], 2)) = 6;
    
    for j = 1:size(Test, 1)
        [l, v] = ismember([mod((Test(j, 1) + transpose(1:dist(j))), n), Test(j, 2) * ones(dist(j), 1)], [mod(Test(:, 1), n), Test(:, 2)], 'rows');
        
        v = v(l);
        
        % Should the car pit
        if 4 * Test(j, 6) < rand && Test(j, 1) + dist(j) > n
            new_Test(j, 2) = 3;
            new_Test(j, 1) = n + 2;
            
        % If the car is in the pitlane
        elseif new_Test(j, 2) == 3
            if Test(j, 1) == 40
                r = rand;
                if r * 3 <= 1
                    new_Test(j, 7) = 1;
                    new_Test(j, 6) = 1;
                    
                elseif r * 3 <= 2
                    new_Test(j, 7) = 2;
                    new_Test(j, 6) = 0.9;
                    
                else
                    new_Test(j, 7) = 3;
                    new_Test(j, 6) = 0.8;
                end
                
                k = 0;
                
                while k >= 0
                    f = new_Test(new_Test(:, 1) == Test(j, 1) + dist(j) - k, 2);
                    
                    if length(f) == 3
                        k = k + 1;
                        
                    else
                        new_Test(j, 1) = Test(j, 1) + dist(j) - k;
                        
                        k = -1;
                        if ~ismember(1, f)
                            new_Test(j, 2) = 1;
                            
                        else
                            new_Test(j, 2) = 2;
                        end
                    end
                end
            else
                new_Test(j, 1) = Test(j, 1) + 2;
            end
            
        % If there is a car right in front and the car is going quicker than the one in front    
        elseif l(1) && dist(j) > dist(v(1))
            
            if Test(j, 2) == 1 && ~ismember([Test(j, 1), Test(j, 2) + 1], [Test(:, 1), Test(:, 2)], 'rows')
                new_Test(j, 2) = Test(j, 2) + 1;
                
            else
                new_Test(j, 2) = Test(j, 2);
            end
            
            if Test(j, 1) + dist(j) > n
                new_Test(j, 1) = Test(j, 1) + dist(j);
            else
                
                new_Test(j, 1) = min([new_Test(new_Test(1:j - 1, 2) == new_Test(j, 2)) - 1; Test(j, 1) + dist(j)]);
            end
            
        % Are any cars in front close which the car is going quicker than?
        elseif any(l) && dist(j) > dist(v(1))
            if Test(j, 1) + dist(j) > n
                new_Test(j, 1) = Test(j, 1) + dist(j);
            else
                
                new_Test(j, 1) = min(min(new_Test(v, 1)) - 1, Test(j, 1) + dist(j));
            end
            
            new_Test(j, 2) = Test(j, 2);
 
        % Are any cars in front close?
        elseif any(ismember([(Test(j, 1) + transpose(1:dist(j))), Test(j, 2) * ones(dist(j), 1)], [new_Test(:, 1), new_Test(:, 2)], 'rows'))
            [~, v] = ismember([(Test(j, 1) + transpose(1:dist(j))), Test(j, 2) * ones(dist(j), 1)], [new_Test(:, 1), new_Test(:, 2)], 'rows');
            
            new_Test(j, 1) = min(min(new_Test(nonzeros(v), 1)) - 1, Test(j, 1) + dist(j));
            new_Test(j, 2) = Test(j, 2);
            
        % Is the car not  on the racing line and are there any cars on the racing line?
        elseif Test(j, 2) ~= 1 && ~any(ismember([Test(j, 1) + transpose(0:dist(j)), ones(dist(j) + 1, 1)], [new_Test(:, 1), new_Test(:, 2)], 'rows'))
            new_Test(j, 1) = Test(j, 1) + dist(j);
            new_Test(j, 2) = 1;
            
        else
            new_Test(j, 1) = Test(j, 1) + dist(j);
            new_Test(j, 2) = Test(j, 2);
        end
    end
    
    new_Test(:, 8) = Test(:, 8) + 1;
    
    f = find(new_Test(:, 1) > n);
    
    for j = 1:length(f)
        Laptimes(Test(f(j), 3), Test(f(j), 5) + 2) = new_Test(f(j), 8) + 1 - ((new_Test(f(j), 1) - n)/dist(f(j)));
        new_Test(f(j), 8) = (new_Test(f(j), 1) - n)/dist(f(j));
        
        if new_Test(f(j), 2) == 4
            new_Test(f(j), 1) = 2;
        else
            
            g = n;
            row = new_Test(f(j), 2);
            g = min(new_Test(new_Test(:, 2) == new_Test(f(j), 2)) - 1);
            
            new_Test(f(j), 1) = min(mod(new_Test(f(j), 1), n), g);
        end
        
        if new_Test(f(j), 1) < Test(f(j), 1)
            new_Test(f(j), 5) = Test(f(j), 5) + 1;
            lap = max(lap, new_Test(f(j), 5));
        end
        
%         if Test(j, 7) == 3
%             new_Test(j, 6) = Test(j, 6) * 0.95;
%             
%         elseif Test(j, 7) == 2
%             new_Test(j, 6) = Test(j, 6) * 0.93;
%             
%         else
%             new_Test(j, 6) = Test(j, 6) * 0.91;
%         end
        
    end
    
    Test = sortrows(new_Test, 'descend');
    %     Draw(Test, n)
    
    dum = Test(:, [1, 2, 3, 5]);
    dum(:, 5) = dum(:, 1) + n * dum(:, 4);
    dum = [sortrows(dum, 5, 'descend'), transpose(1:m)];
    dum = sortrows(dum, 3);
    
    
    
    stats(:, 1 + i) = dum(:, 5);
    Position(:, i + 1) = dum(:, 6);
    
    i = i + 1;
end

for j = 1:m
    plot(1:i - 1, stats(j, 2:i))
    hold on;
end

for j = 0:n:max(max(stats))
    plot(1:i - 1, j * ones(1, i - 1), 'LineStyle', '--');
end

legend(string(1:m))
hold off;

position = Position(1:m, 1:i - 1);
end
