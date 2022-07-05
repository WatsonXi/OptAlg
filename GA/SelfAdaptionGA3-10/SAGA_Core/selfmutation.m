%% 自适应变异
% 2022/03/08   韦希明
% 03/09：此处修改为修改交叉，交叉过程会破坏染色体的都成，同样的，其计算的适应度函数不再适用
% 但交叉不更改适应度的顺序，为了减少适应度的计算（这个过程往往会带来恐怖的计算量），仍采用原
% 适应度表tempfitness，认为，适应度低的后代中想保留下来，必须要以更高的概率进行变异

%% 函数体
function selfmutation()
    global i popsize lchrom pmutation temp newpop oldpop mp;
    global avgfitness maxfit tempfitness gen;
    m = lchrom * (popsize - mp);            % 参与变异的基因总数，此处保留优势个体
    pm1 = pmutation;                        % 变异概率，在main中初始化
    pm2 = 0.005;                            % 变异概率下限
    a = -1;                                 % 下限
    b = 2;                                  % 上限
    
%% 自适应变异概率：变异概率根据其适应度函数决定，比平均适应度高的，变异概率小
    for i = 1 : (popsize- mp)

        if tempfitness(i) >= avgfitness
            pm(i) = pm1 - (pm1 - pm2) * (tempfitness(i) - avgfitness) / ...
                (maxfit(gen) - avgfitness);
        else
            pm(i) = pm1;
        end
    end
    
%% 变异操作
    for i = 1 : (popsize - mp)
        for j = 1 : lchrom
            if (rand < pm(i))
                temp(i,j) = double(~temp(i,j));
            end
        end
    end
    
%% 新的种群
    newpop = temp;
    oldpop = newpop;
end
















