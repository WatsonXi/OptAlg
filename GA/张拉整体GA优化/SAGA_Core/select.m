%% 轮盘法选择
% 个体被选中的概率取决于个体的相对适应度，体现适者生存（在更迭时保留）
% 2022/03/07 韦希明
% 03/08 修改
% 输入为保优淘汰后的种群oldpop，及其对应的适应度表fitness
% 输出为种群池temp，以及其对应的适应度表 tempfitness

%% 函数体
function select()
    global fitness popsize sumfitness oldpop temp mp np tempfitness
    sumfitness = 0;                         % 适应度函数的和
    % 计算适应度的总和
    for i = 1 : (popsize - mp - np)         % 剩余的个数
        sumfitness = sumfitness + fitness(i);
    end
    % 选择概率，贡献适应度多的概率高
    for i = 1 : (popsize - mp - np)
        p(i) = fitness(i) / sumfitness;     % 按照占比分配概率
    end
    q = cumsum(p);                          % 累积概率，刻画轮盘
    % 产生随机算子,除去保护的个体外，其余按照概率进行popsize-mp次选择
    % 可能存在重复选择
    % 种群池为temp，前popsize - mp个从中间种群选取
    b = sort(rand(1, (popsize - mp)));      
    j= 1;
    k = 1;
    while j <= (popsize - mp)
        if b(j) < q(k)
            temp(j,:) = oldpop(k,:);
            tempfitness(j) = fitness(k); 
            j = j + 1;
        else
            k = k + 1;
        end
    end
    % 所有的优秀群体全部被选入种群池temp
    j = popsize - np - mp + 1; 
    for i = (popsize - mp + 1) : popsize
        temp(i, :) = oldpop(j, :);
        tempfitness(i) = fitness(j);
        j = j + 1;
    end
end