%��Ⱥ����
function [ result_pop ] = updatePopulation( pop,EXA,pop_num,operation_chooseProb,selectOpNum,cross_rate,decision_low_array,decision_high_array,tVal )
%UPDATEPOPULATION Summary of this function goes here
%   Detailed explanation goes here
    num = size(EXA,2);
    result_pop=[];
    for i = 1:pop_num                %ѭ������num�������
        operationIndex = selectOpNum(random_operationIndex(operation_chooseProb));   %���ѡ��һ�ֽ������
        OperationPop = [];                    %ѡ����н����������Ⱥ
        OperationPop = [OperationPop,{pop(i).pop}];        %��pop(i)Ϊ��
        random2 = randi(size(EXA,2));
        OperationPop = [OperationPop, {EXA(random2).pop}];
        if operationIndex > 2
            random3 = randi(size(EXA,2));
            OperationPop = [OperationPop, {EXA(random3).pop}];
        end
        offspring = CrossOperation(OperationPop,operationIndex,cross_rate,decision_low_array,decision_high_array,tVal); %���н������
        result_pop=[result_pop,offspring];
    end
    %����
    result_pop = Pop_mutation(result_pop,decision_low_array,decision_high_array);   %������Ⱥ  
end

