%% SadapGA.m
    % 自适应遗传算法的主函数，其根据当前群体的适应度情况，自动修改交叉概率和
    % 变异概率，在保护最优个体的同时，加快淘汰较差个体，尽快得到最优解。
    % version 1.0
    % 2022/03/08  韦希明   用于求解TWAD的最优设计
    
%% 工作空间
close all;
clear global;
clear;
clc;

addpath(genpath('../SAGA_Core'));

global chrom lchrom oldpop newpop varible fitness popsize sumfitness;
global pcross pmutation temp bestfit maxfit gen bestgen tempfitness;
global maxgen po pp mp np bestchrom bestindivial;

%% 初始化变量
lchrom = 50;                % 染色体长度
popsize = 100;               % 种群数量
pcross = 0.8;               % 交叉概率(最高)，j大于0.2小于1
pmutation = 0.08;           % 变异概率（最高）
maxgen = 1000;               % 最大代数
po = 0.1;                   % 淘汰概率
pp = 0.1;                   % 保护概率

%% 求解问题的参数初始化
% a和b表示设计变量的上下限，这里必须对每一个设计变量给出其范围
% a和b是一个列向量
a = [0.5 0.2 0.5 0.2 0.02]';                      % 个体取值下限
b = [4 2 4 2 1];                      % 个体取值上限

Y1 = 0.02+0i;          % 复数，导纳
Y2 = 0.02+0i;
Y3 = 0.02+0i;
f = 3750e+6;            % 频率
c_t1 = 2e-12;        % 变容二极管电容值1
c_t2 = 2e-12;        % 变容二极管电容值2


%% 计算
mp = floor(pp * popsize);   % 保护的个数
np = floor(po * popsize);   % 淘汰的个数

%% GA迭代
% 没有进行判断，直接进行200次迭代择优
initpop;                    % 初始化种群

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%很重要的注释
% 如果要自定义一个问题，请重新定义一个适应度函数objfun.m
% 这个函数是求最大化的（arg_max objfun）
for gen = 1 : maxgen
    objfun(a,b);                 % 计算适应度
    pp_po;                  % 执行保优操作
    select;                 % 选择
    crossover;              % 交叉
    selfmutation;           % 自变异
end

%% 择优输出
best
bestfit                    % 最优个体适应度
bestgen                     % 最优个体所处代数
bestindivial

%% 绘图
f1 = figure(1);
gen = 1 : maxgen;
p1 = plot(gen, maxfit(1,gen));   % 进化曲线
hold on;
p2 = plot( bestgen, bestfit);
xlabel('Generation');
ylabel('Fitness');