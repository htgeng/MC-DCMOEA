%EXAɸѡ����
function [ EXA ] = EXA_cut( EXA,max_exa_num )
%EXA_ Summary of this function goes here
%   Detailed explanation goes here
     if size(EXA,2) > max_exa_num                    %���EXAԽ��
        distances = calc_crowd_distance(EXA);
        [EXA_sort,s] = sort(distances);
        m = size(EXA,2) - max_exa_num;
        EXA(s(1:m)) = [];                                %ɾ��EXA�е�ӵ��������С��Ԫ��            
    end
end

