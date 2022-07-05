%% 适应度函数，求的是适应度函数的最大值，需要保证值非负

function Fit_fun = getFit_fun(varible)
% 输入：varible，一个5维行向量，分别表示theta_1,theta_t1,theta_2,theta_t2,theta_3
% 输出: 值函数，- (Y_ino^2 + Y_ine^2)
%% 初始化， 这些值在主函数中进行定义
A1 = evalin('base', 'A1');          % 绳索现在的长度
L_obj = evalin('base', 'L_obj');    % 目标长度
Cs = evalin('base', 'Cs');

%% 方程的定义

state = [varible(1:6)]';
A1_new = A1;
A1_new(:,1:5) = Get_Rot(state) * A1_new(:,1:5) + kron(ones(1,5), state(1:3));
L_s = get_Ls(A1_new,Cs);
L_s(9) = norm(A1_new(:,1));


%% 适应度函数的定义

Fit_fun = - norm(L_s - L_obj) + 20;
end