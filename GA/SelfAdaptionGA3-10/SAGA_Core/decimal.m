%% decimal.m
% 解码函数，二进制转十进制
% 输入：chrom, 二进制染色体
% 输出：d, 染色体对应的十进制数

% 2022/03/07    韦希明

%% 函数体
function d = decimal(chrom)
    global lchrom popsize;
    d = 0;
    for j = 1 : lchrom
        d = d +chrom(j) * 2 .^(lchrom - j);     % B2D进制转换编码规则
    end
end