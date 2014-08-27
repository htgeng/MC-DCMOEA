%初始化种群
function [particle] = init_Population(particle,low_array,high_array)
%INIT_POPULATION Summary of this function goes here
%   Detailed explanation goes here
    decisionNum = size(low_array,2);   %决策变量个数
    pop_num = size(particle,2);         %种群规模

    pop(pop_num,decisionNum)=0;    
    for i = 1:decisionNum              %第i个决策变量
        for count = 1:pop_num                    %随机生成每一维的值       
            value = unifrnd(low_array(i),high_array(i));    %随机生成第range_num段内的一个值
            pop(count,i) = value;                              %赋值clc
        end        
    end
    for m = 1:pop_num                         %转换格式成一行n列的种群
        particle(m).pop = pop(m,:);
    end
end