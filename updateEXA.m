%EXA更新机制
function [ EXA ] = updateEXA( EXA,pop,max_exa_num )
%UPDATEEXA Summary of this function goes here
%   Detailed explanation goes here
    EXA = [EXA,pop];                              %把新非支配解添加到EXA中
    indeces = extract_nondominatedset(EXA);         %对EXA执行非支配排序
    EXA = EXA(indeces);
    EXA = EXA_cut( EXA,max_exa_num );               %如果EXA越界  删除EXA中的拥挤距离最小的元素
end

