%% 择优方程
% 2022/03/09  韦希明

%% 函数体
function best()
    global maxfit bestfit gen maxgen bestgen;
    bestfit = maxfit(1);
    gen = 2;
    while gen <= maxgen
        if bestfit < maxfit(gen)
            bestfit = maxfit(gen);
            bestgen = gen;
        end
        gen = gen + 1;
    end
%     bestchrom = 
end