% ga main

%% workspace
    close all;
    clear;
    clc;
    addpath('D:\汇报文件\GA\test1');
    
    options = gaoptimset('PopulationSize', 100, 'Generations', 5000, 'PlotFcns', @gaplotbestf);
    [x, feval, ~, output,~] = ga(@zp, 3, options)