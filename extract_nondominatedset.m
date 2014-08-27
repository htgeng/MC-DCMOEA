function [ indeces ] = extract_nondominatedset( pop )    %执行非支配排序集
%EXTRACT_NONDOMINATEDSET Summary of this function goes here
%   Detailed explanation goes here
    indeces=[];             %存储非支配解的下标
    for i = 1:size(pop,2)
        b = pop(i).objectVal;            %b为等待排序的种群个体
        j = 1;
        is_add = 1;
        while (j <= size(indeces,2))&&(is_add == 1)
            a = pop(indeces(j)).objectVal;     %选择非支配解集中的个体
            is_dom = compare_indivuals(a,b);
            if is_dom == 1
                is_add = 0;
            end
            if is_dom == 2
                indeces = [indeces(1:j-1),indeces(j+1:size(indeces,2))];
                j=j-1;
            end
            j = j + 1;
        end
        if is_add == 1
            indeces = [indeces,i];
        end
    end
end
       