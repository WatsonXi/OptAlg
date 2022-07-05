%% 排序算法
% 比较排序,小到大排序
% 2022/03/07

%% 函数体
function lsort()
    global popsize fitness oldpop
    for i = 1 : popsize
        j = i + 1;
        while j <= popsize
            if fitness(i) > fitness(j)          % 比较适应度值
                tf = fitness(i);                % 中间变量
                tc = oldpop(i,:);
                fitness(i) = fitness(j);        % 对应的适应度互换
                oldpop(i,:) = oldpop(j,:);      % 对应基因互换
                fitness(j) = tf;
                oldpop(j,:) = tc;
            end
            j = j + 1;
        end
    end
end