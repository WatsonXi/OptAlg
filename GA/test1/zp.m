% 目标函数
function f = zp(x)
    a = [0, 49, 98, 147, 196, 294, 391, 489, 587, 685];
    y1 = [6.39, 9.48, 12.46, 14.33, 17.10, 21.94, ...
        22.64, 21.43, 22.07, 24.53];
    n = size(a, 2);
    f = 0;
    for i = 1 : n
        y = x(1) * (a(i) + x(2)) / (x(3) + a(i) + x(2));
        f = f + ((y1(i) - y).^2);
    end
end