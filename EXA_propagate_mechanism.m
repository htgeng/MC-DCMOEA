%EXA扩充机制
function [ EXA ] = EXA_propagate_mechanism(EXA,max_exa_num,cross_rate,decision_low_array,decision_high_array,operation_chooseProb,selectOpNum,tVal)
%EXA_PROPAGATE_MECHANISM Summary of this function goes here
%   Detailed explanation goes here
        if size(EXA,2) <=2
            EXA_new = new_EXA( EXA,max_exa_num,decision_low_array,decision_high_array,tVal);%扩充的精英解            
            EXA = updateEXA( EXA,EXA_new,max_exa_num ); %对EXA执行非支配排序,选择首层
        else
            EXA_new = [];
            sw = CreateRouletteWheel( EXA);                  %创建赌轮
            for j = 1:max_exa_num                            %循环产生max_exa_num个新个体
                operationIndex = selectOpNum(random_operationIndex(operation_chooseProb));    %随机选择一种交叉操作    
                OperationPop = Select_pop(EXA,sw,operationIndex);                    %选择进行重组操作的种群
                offspring = CrossOperation(OperationPop,operationIndex,cross_rate,decision_low_array,decision_high_array,tVal);   %交叉操作产生新个体
                EXA_new = [EXA_new,offspring];        %添加新产生的个体
            end
            %种群变异
            EXA_new=Pop_mutation(EXA_new,decision_low_array,decision_high_array);
            EXA_new = calc_objects(EXA_new,tVal);          %评估新个体
            EXA = updateEXA( EXA,EXA_new,max_exa_num ); 
        end
end

%当EXA中的个体小于等于两个时，随机扩充
function [EXA_new] = new_EXA( EXA,max_exa_num,decision_low_array,decision_high_array,tVal) 
    EXA_new=[];
    for k = 1:max_exa_num
        i = randi(size(EXA,2));           %随机选择EXA中的一个解
        j = randi(size(EXA(i).pop,2));    %随机选择解i的某一维数 整数
        num3=EXA(i);
        num3.pop(j) = unifrnd(decision_low_array(j),decision_high_array(j));   %生成一个新个体
        EXA_new = [EXA_new, num3];
    end  
    EXA_new = calc_objects(EXA_new,tVal); 
end


%设计赌盘
function [ sWheel ] = CreateRouletteWheel( EXA)
    crowdDistance = calc_crowd_distance(EXA);
    maxValue=max(crowdDistance(crowdDistance~=Inf))*2;%?????暂时用2倍处理
    %如果拥挤距离都等于Inf，则
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

%轮盘赌选择个体
function [ OperationPop ] = Select_pop(EXA,sWheel,operationIndex)
    random1 = unifrnd(0,1);                %随机选择一个个体
    random2 = unifrnd(0,1);
    OperationPop{1} = EXA(select(sWheel,random1)).pop;
    OperationPop{2} = EXA(select(sWheel,random2)).pop;   
    if operationIndex>2
        random3 = unifrnd(0,1);
        OperationPop{3} = EXA(select(sWheel,random3)).pop;
    end
end
%选择个体
function [index]=select(sWheel,random)
    sumCP=0;
    for index = 1:size(sWheel,2)             %这里有问题
           if random <= (sumCP + sWheel(index))
                break;
            else
                sumCP = sumCP + sWheel(index);
            end
    end
end
