%% objfun.m
% 适应度函数，相当于目标函数
% 注意！！！！这个目标函数应该是最大化的即（arg_max obj）
% 问题域：arg max f(x);  f(x) = x * sin(8*x)+3   x \in [-1,+2]
% 2022/03/07   韦希明
% 输入为一个种群oldpop，种群的结构为，每一行为一个个体
% 输出为oldpop对应的fitness表；平均适应度avgfitness；最大适应度（每一个代数对应一个）


%% 函数体
function objfun(a,b)
    % a ,b 对应下限与上限
    global lchrom oldpop fitness popsize chrom maxfit gen varible;
    global avgfitness savgfitness bestchrom;
    
    len_chrom = length(oldpop(1,:)) / size(a,1); % 每一个设计变量的长度
    for i = 1 : popsize
        chrom = oldpop(i,:);    % 取个体
        for j = 1 : size(a,1)
        c = decimal(chrom((j - 1) * len_chrom + 1 : j * len_chrom));     % 解码，此处为二进制转十进制
        
%         x = a(j) + c * (b(j) - a(j)) / (2 .^ (lchrom/7) - 1);
        varible(i,j) = a(j) + c * (b(j) - a(j)) / (2 .^ len_chrom - 1);   % 按照占比赋值实数向量
        % varible这个向量，行表示个体的编号，列表示对应设计变量的具体值
        
        end
        % 目标函数,包含罚函数
        fitness(i) = getFit_fun(varible(i,:))+10;
    end
    avgfitness = sum(fitness) / popsize;
    lsort;                      % 排序
    [maxfit(gen),position] = max(fitness);             % 最大适应度,及最大适应的个体的位置
    bestchrom(gen,:) = varible(position,:);                % 最优个体 
end