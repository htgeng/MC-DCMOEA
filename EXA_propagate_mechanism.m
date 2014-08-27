%EXA�������
function [ EXA ] = EXA_propagate_mechanism(EXA,max_exa_num,cross_rate,decision_low_array,decision_high_array,operation_chooseProb,selectOpNum,tVal)
%EXA_PROPAGATE_MECHANISM Summary of this function goes here
%   Detailed explanation goes here
        if size(EXA,2) <=2
            EXA_new = new_EXA( EXA,max_exa_num,decision_low_array,decision_high_array,tVal);%����ľ�Ӣ��            
            EXA = updateEXA( EXA,EXA_new,max_exa_num ); %��EXAִ�з�֧������,ѡ���ײ�
        else
            EXA_new = [];
            sw = CreateRouletteWheel( EXA);                  %��������
            for j = 1:max_exa_num                            %ѭ������max_exa_num���¸���
                operationIndex = selectOpNum(random_operationIndex(operation_chooseProb));    %���ѡ��һ�ֽ������    
                OperationPop = Select_pop(EXA,sw,operationIndex);                    %ѡ����������������Ⱥ
                offspring = CrossOperation(OperationPop,operationIndex,cross_rate,decision_low_array,decision_high_array,tVal);   %������������¸���
                EXA_new = [EXA_new,offspring];        %����²����ĸ���
            end
            %��Ⱥ����
            EXA_new=Pop_mutation(EXA_new,decision_low_array,decision_high_array);
            EXA_new = calc_objects(EXA_new,tVal);          %�����¸���
            EXA = updateEXA( EXA,EXA_new,max_exa_num ); 
        end
end

%��EXA�еĸ���С�ڵ�������ʱ���������
function [EXA_new] = new_EXA( EXA,max_exa_num,decision_low_array,decision_high_array,tVal) 
    EXA_new=[];
    for k = 1:max_exa_num
        i = randi(size(EXA,2));           %���ѡ��EXA�е�һ����
        j = randi(size(EXA(i).pop,2));    %���ѡ���i��ĳһά�� ����
        num3=EXA(i);
        num3.pop(j) = unifrnd(decision_low_array(j),decision_high_array(j));   %����һ���¸���
        EXA_new = [EXA_new, num3];
    end  
    EXA_new = calc_objects(EXA_new,tVal); 
end


%��ƶ���
function [ sWheel ] = CreateRouletteWheel( EXA)
    crowdDistance = calc_crowd_distance(EXA);
    maxValue=max(crowdDistance(crowdDistance~=Inf))*2;%?????��ʱ��2������
    %���ӵ�����붼����Inf����
    maxValue=100;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	sumCrowdDis = 0;    
    for i = 1:size(EXA,2)       
        if crowdDistance(i)== Inf
            crowdDistance(i)=maxValue;
        end
        sumCrowdDis = sumCrowdDis + crowdDistance(i);
    end
    sWheel = crowdDistance./sumCrowdDis;
end

%���̶�ѡ�����
function [ OperationPop ] = Select_pop(EXA,sWheel,operationIndex)
    random1 = unifrnd(0,1);                %���ѡ��һ������
    random2 = unifrnd(0,1);
    OperationPop{1} = EXA(select(sWheel,random1)).pop;
    OperationPop{2} = EXA(select(sWheel,random2)).pop;   
    if operationIndex>2
        random3 = unifrnd(0,1);
        OperationPop{3} = EXA(select(sWheel,random3)).pop;
    end
end
%ѡ�����
function [index]=select(sWheel,random)
    sumCP=0;
    for index = 1:size(sWheel,2)             %����������
           if random <= (sumCP + sWheel(index))
                break;
            else
                sumCP = sumCP + sWheel(index);
            end
    end
end
