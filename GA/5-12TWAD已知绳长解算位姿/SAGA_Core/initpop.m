%% initpop.m
% 初始化种群的函数，采用二进制编码
% version-1.0
% 2022/03/07   韦希明

%% 函数体
function initpop()
    global lchrom oldpop popsize chrom;
    for i = 1 : popsize
        chrom = rand(1, lchrom);            % 染色体 \in R^{lchrom}
        % 规整
        for j = 1 : lchrom
            if chrom(j) < 0.5
                chrom(j) = 0;
            else
                chrom(j) = 1;
            end
        end
    
    oldpop(i,1:lchrom) = chrom;             % 种群 \in R^{popsize x lchrom}
    end
end