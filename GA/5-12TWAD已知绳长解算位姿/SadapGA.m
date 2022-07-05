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
lchrom = 60;                % 染色体长度
popsize = 100;               % 种群数量
pcross = 0.8;               % 交叉概率(最高)，j大于0.2小于1
pmutation = 0.08;           % 变异概率（最高）
maxgen = 2000;               % 最大代数
po = 0.1;                   % 淘汰概率
pp = 0.1;                   % 保护概率

%% 求解问题的参数初始化
% a和b表示设计变量的上下限，这里必须对每一个设计变量给出其范围
% a和b是一个列向量
a = [-0.001 -0.01 -0.1 -0.001 -0.001 -1.5]';                      % 个体取值下限
b = [0.001 0.01 0.1 0.001 0.001 1.5]';                      % 个体取值上限

%        1      2       3       4      5       6       7       8       9  (节点)
A1 = [    0,     0,      0, -0.096, 0.096,      0,      0, -0.043,  0.043;
          0,  0.05, -0.039,  0.007, 0.007,  0.073, -0.065,  0.035,  0.035;
      0.153, 0.153,  0.153,      0,     0,  0.057,  0.023,  0.005,  0.005];   % R(3X9)
  
%       0   1   2   3   4   5   6   7   8(节点)
Cs = [  0,  1,  0,  0,  0, -1,  0,  0,  0;      % s1
        0,  0,  1,  0,  0,  0, -1,  0,  0;      % s2
        0,  0,  0,  1,  0, -1,  0,  0,  0;      % s3
        0,  0,  0,  0,  1, -1,  0,  0,  0;      % s4
        0,  0,  0,  1,  0,  0, -1,  0,  0;      % s5
        0,  0,  0,  0,  1,  0, -1,  0,  0;      % s6
        0,  0,  0,  1,  0,  0,  0, -1,  0;      % s7
        0,  0,  0,  0,  1,  0,  0,  0, -1];     % s8    R(8X9)
Cb = [  1, -1,  0,  0,  0,  0,  0,  0,  0;      % b01
    1,  0, -1,  0,  0,  0,  0,  0,  0;      % b02
    1,  0,  0, -1,  0,  0,  0,  0,  0;      % b03
    1,  0,  0,  0, -1,  0,  0,  0,  0;      % b04 structure1
    0,  0,  0,  0,  0,  1,  0,  -1, 0;      % b3
    0,  0,  0,  0,  0,  1,  0,   0,-1;      % b4
    0,  0,  0,  0,  0,  0,  1,  -1, 0;      % b5
    0,  0,  0,  0,  0,  0,  1,  0, -1];     % b6    R(8X8)
C = [Cs; Cb];       % R((8+6)X7)    
L_obj = 0.01 * [9.341,12.63105,12.602745,12.602745,11.74474,11.74474,5.50103,5.50103,14.68895]';


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

%% 记录长度
state = bestindivial';
A1_new = A1;
A1_new(:,1:5) = Get_Rot(state) * A1_new(:,1:5) + kron(ones(1,5), state(1:3));
L_s = get_Ls(A1_new,Cs)
l_actuator = norm(A1_new(:,1))
%% 绘图
f1 = figure(1);
gen = 1 : maxgen;
p1 = plot(gen, maxfit(1,gen));   % 进化曲线
hold on;
p2 = plot( bestgen, bestfit);
xlabel('Generation');
ylabel('Fitness');

% f2 = figure(2);
x = A1_new(1,:);y = A1_new(2,:);z = A1_new(3,:);
% Plot
rad = 0.001;
labelsOn = 1;
% labelsOn = 0;       % with no number
f2 = plotTensegrity3d(C, x, y, z, 8, rad, labelsOn);