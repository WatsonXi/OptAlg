%% 适应度函数，求的是适应度函数的最大值，需要保证值非负

function Fit_fun = getFit_fun(varible)
% 输入：varible，一个5维行向量，分别表示theta_1,theta_t1,theta_2,theta_t2,theta_3
% 输出: 值函数，- (Y_ino^2 + Y_ine^2)
%% 初始化， 这些值在主函数中进行定义
Y1 = evalin('base', 'Y1');          % 复数，导纳
Y2 = evalin('base', 'Y2');
Y3 = evalin('base', 'Y3');
f = evalin('base', 'f');            % 频率
c_t1 = evalin('base', 'c_t1');        % 变容二极管电容值1
c_t2 = evalin('base', 'c_t2');        % 变容二极管电容值2

%% 方程的定义
Y_ino = i * (Y1 * tan(varible(1) - varible(2) )  ) + ...
    (i * (2 * pi * f * c_t1 *(- i * (Y1 * cot(varible(2)) ) ) )) / ...
    (i * (2*pi*f*c_t1) - i * (Y1*cot(varible(2))) );

Y_ine11 = i*(2*pi*f*c_t1* (i * (Y1*tan(varible(1)-varible(2)) )) )/ ...
    i*2*pi*f*c_t1 + i * (Y1*tan(varible(1)-varible(2)));

Y_ine1 = Y1 *( (Y_ine11 + i * Y1 * tan(varible(2)))/ ...
    Y1 + i * Y_ine11 * tan(varible(2)));

Y_ine21 = i*(2*pi*f*c_t2* (i * (Y2 / 2*tan(varible(3)-varible(4)) )) )/ ...
    i*2*pi*f*c_t2 + i * (Y2 / 2*tan(varible(3)-varible(4)));

Y_ine2 = Y2 / 2 *( (Y_ine21 + i * Y2 / 2 * tan(varible(4)))/ ...
    Y2 / 2 + i * Y_ine21 * tan(varible(4)));

Y_ine3 = - i *  Y3 / 2 * cot(varible(5));

Y_ine = Y_ine1 +  Y_ine2 + Y_ine3;

%% 适应度函数的定义

Fit_fun = - abs(Y_ine) - abs(Y_ino);
end