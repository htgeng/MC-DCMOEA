%计算拥挤距离
function [ crowdDistance ] = calc_crowd_distance( pop )
%caltype: =0 端点为无穷 1：端点为最近点的两倍
%CALC_CROWD_DISTANCE Summary of this function goes here
%   Detailed explanation goes here
    l_size=size(pop,2);
    crowdDistance = zeros(1,l_size);
    m = size(pop(1).objectVal,2);     %目标函数个数
    for i = 1:m-1
        obj_val_i = zeros(1,l_size);  %生成l_size个空数组，用来存放针对每一个目标函数的所有个体的评估值
        for j = 1:l_size
            obj_val_i(j) = pop(j).objectVal(i); 
        end
        [obj_val_i_sort,s]=sort(obj_val_i);           %对内容进行排序，并且返回原来的下标s
        crowdDistance(s(1)) = Inf;            %头尾设置成无穷大
        crowdDistance(s(l_size)) = Inf;
        crowdDistance(s(2:l_size-1))=crowdDistance(s(2:l_size-1))+obj_val_i(s(3:l_size))-obj_val_i(s(1:l_size-2));
    end
end
