%���ѡ�񽻲����
function [ operationIndex ] = random_operationIndex( operation_chooseProb )
%RANDOM_OPERATIONINDEX Summary of this function goes here
%   Detailed explanation goes here
    random = unifrnd(0,1);                        %���ѡ��һ�ֽ������
    opNum=size(operation_chooseProb,2);
    k = 1;
    while (k <=opNum )&&(random > operation_chooseProb(k))
        k = k+1;
    end
    operationIndex = k;
end

