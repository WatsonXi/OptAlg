%% 自适应交叉
% 输入为种群池temp 及其对应的适应度tempfitness
% 输出一个种群temp 
% 2022/03/08   韦希明

%% 函数体
function crossover()
    global temp tempfitness popsize pcross lchrom mp avgfitness maxfit gen;
    
    pc_h = pcross;              % 最高交配概率
    pc_l = pc_h - 0.2;          % 最低交配概率
    % 分配交叉概率
    pc = zeros(popsize - mp);               % 交配概率
    for i = 1 : (popsize - mp)              % 后mp为保优个体，不参与交叉，必定保留
        if tempfitness(i) >= avgfitness     % 优势个体交配概率更大
            pc(i) = pc_l + (pc_h - pc_l) * (tempfitness(i) - avgfitness) / ...
                (maxfit(gen) - avgfitness);
        else
            pc(i) = pc_l;
        end
    end
    
    n = floor(popsize - mp);         % 交叉发生的次数
    % 保证参与交叉的个体为偶数
    if rem(n,2) ~= 0
        n = n - 1;
    end
    
    % 顺序选择要交叉的对象，进行随机配对
    j= 1; 
    m = 0;
    for i = 1 : (popsize - mp)                  % 对于前面个体执行交叉操作
        p = rand;                               % 产生随机数
        if p < pc(i)                           % 满足交叉条件（交叉概率）
            parent(j,:) = temp(i,:);
            % k 记录交叉的个体在种群中的位置，之后，他们的后代便会取代他们
            k(j) = i;                           % 交换的信息 j取值1 2 
            j = j + 1;                          % 父本个数的统计
            if (j == 3) && (m <= n)
                m = m + 1;                          % 杂交次数统计
                pos = round(rand * (lchrom-1))+1;   % 交叉点
                for ii = 1 : pos                        % 保留的染色体
                    child1(ii) = parent(1, ii);         % 子前 = 父前
                    child2(ii) = parent(2, ii);         % 女前 = 母前
                end
                for ii = (pos + 1) : lchrom             % 交叉的染色体
                    child1(ii) = parent(2, ii);         % 子后 = 母后
                    child2(ii) = parent(1, ii);         % 女后 = 父后
                end
                
                ii = k(1);
                jj = k(2);
                temp(ii, :) = child1;                   % 子代代替父辈
                temp(jj, :) = child2;
                j = 1;
            end
        end
    end
end