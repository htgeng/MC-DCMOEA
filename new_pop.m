%冷热混合启动产生新种群
function [ pop ] = new_pop( pop_cold,pop_hot,tVal)
%NEW_POP Summary of this function goes here
%   Detailed explanation goes here
    pop=[];
    num=size(pop_cold,2);
    temp=[pop_cold,pop_hot];
    temp = calc_objects(temp,tVal);
    while size(pop,2)<num
        indeces = extract_nondominatedset(temp);  %执行非支配排序
        if (size(pop,2)+size(indeces,2))<=num
            pop=[pop,temp(indeces)];
        else            
            m=num-size(pop,2);
            pop=[pop,temp(indeces(1:m))];
        end
        temp(indeces)=[];
    end
end

