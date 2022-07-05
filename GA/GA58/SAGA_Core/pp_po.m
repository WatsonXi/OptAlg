%% 保护基因操作
% 个体为列向量，每一列为一个染色体
% 2022/03/08   韦希明
% 03/08修改：此处的基因除了淘汰前np个基因外，还增加的操作为，将np之后的个体片段
% 组合并重新排列成popsize个，设popsize = np + rp + mp;则基因被更替为：
% popsize = rp + mp + (- mp + np),括号内的这一段表示将rp +mp整体置顶之后，剩下
% np个位置，这部分位置是原封不动的，mp的，末尾片段，是适应度最高的片段。
% 当然，对应的适应度列表也进行交换

%% 函数体
function pp_po
    global popsize oldpop np fitness;
    i = np + 1;                     % 淘汰的个数np
    j = 1;
    % 把np之后的种群放在toldpop中
    while i <= popsize
        toldpop(j , :) = oldpop(i , :);
        tfitness(j) = fitness(i);               % 3/8
        j = j + 1;
        i = i + 1;
    end
    % 前np个体的基因被淘汰
    for i = 1 : (popsize - np)
        oldpop(i, :) = toldpop(i, :);
        fitness(i) = tfitness(i);               % 3/8
    end
end