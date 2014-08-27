%种群更新
function [ result_pop ] = updatePopulation( pop,EXA,pop_num,operation_chooseProb,selectOpNum,cross_rate,decision_low_array,decision_high_array,tVal )
%UPDATEPOPULATION Summary of this function goes here
%   Detailed explanation goes here
    num = size(EXA,2);
    result_pop=[];
    for i = 1:pop_num                %循环产生num个子孙解
        operationIndex = selectOpNum(random_operationIndex(operation_chooseProb));   %随机选择一种交叉操作
        OperationPop = [];                    %选择进行交叉操作的种群
        OperationPop = [OperationPop,{pop(i).pop}];        %以pop(i)为主
        random2 = randi(size(EXA,2));
        OperationPop = [OperationPop, {EXA(random2).pop}];
        if operationIndex > 2
            random3 = randi(size(EXA,2));
            OperationPop = [OperationPop, {EXA(random3).pop}];
        end
        offspring = CrossOperation(OperationPop,operationIndex,cross_rate,decision_low_array,decision_high_array,tVal); %进行交叉操作
        result_pop=[result_pop,offspring];
    end
    %变异
    result_pop = Pop_mutation(result_pop,decision_low_array,decision_high_array);   %变异种群  
end

