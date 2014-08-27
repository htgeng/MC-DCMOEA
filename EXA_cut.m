%EXA筛选机制
function [ EXA ] = EXA_cut( EXA,max_exa_num )
%EXA_ Summary of this function goes here
%   Detailed explanation goes here
     if size(EXA,2) > max_exa_num                    %如果EXA越界
        distances = calc_crowd_distance(EXA);
        [EXA_sort,s] = sort(distances);
        m = size(EXA,2) - max_exa_num;
        EXA(s(1:m)) = [];                                %删除EXA中的拥挤距离最小的元素            
    end
end

