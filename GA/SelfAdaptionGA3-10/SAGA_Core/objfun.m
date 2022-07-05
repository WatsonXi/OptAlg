%% objfun.m
% 适应度函数，相当于目标函数
% 注意！！！！这个目标函数应该是最大化的即（arg_max obj）
% 问题域：arg max f(x);  f(x) = x * sin(8*x)+3   x \in [-1,+2]
% 2022/03/07   韦希明
% 输入为一个种群oldpop，种群的结构为，每一行为一个个体
% 输出为oldpop对应的fitness表；平均适应度avgfitness；最大适应度（每一个代数对应一个）


%% 函数体
function objfun()
    global lchrom oldpop fitness popsize chrom maxfit gen varible;
    global avgfitness savgfitness;
    
    a = -1;                     % 个体下限
    b = 1;                      % 个体上限
    for i = 1 : popsize
        chrom = oldpop(i,:);    % 取个体
        c = decimal(chrom);     % 解码，此处为二进制转十进制
        
        % 解码并计算个体的适应度
        % 这个很重要，要根据问题域进行设计
        varible(i) = a + c * (b - a) / (2 .^ lchrom - 1);   % 按照占比赋值
        % 目标函数
        fitness(i) = varible(i) * sin (7 * pi * varible(i)) + 20;
    end
    avgfitness = sum(fitness) / popsize;
    lsort;                      % 排序
    maxfit(gen) = max(fitness);             % 最大适应度
    
end