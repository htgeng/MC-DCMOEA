%��ʼ����Ⱥ
function [particle] = init_Population(particle,low_array,high_array)
%INIT_POPULATION Summary of this function goes here
%   Detailed explanation goes here
    decisionNum = size(low_array,2);   %���߱�������
    pop_num = size(particle,2);         %��Ⱥ��ģ

    pop(pop_num,decisionNum)=0;    
    for i = 1:decisionNum              %��i�����߱���
        for count = 1:pop_num                    %�������ÿһά��ֵ       
            value = unifrnd(low_array(i),high_array(i));    %������ɵ�range_num���ڵ�һ��ֵ
            pop(count,i) = value;                              %��ֵclc
        end        
    end
    for m = 1:pop_num                         %ת����ʽ��һ��n�е���Ⱥ
        particle(m).pop = pop(m,:);
    end
end