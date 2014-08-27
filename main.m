tic
run_num=30;%独立运行的次数
% EXA__R=cell(1,run_num);
%测试函数参数设置
decisionNum = 10;                          %决策变量个数
%decision_low_array(1:decisionNum)=[0,-5,-5,-5,-5,-5,-5,-5,-5,-5];  %上界
%decision_high_array(1:decisionNum)=[1,5,5,5,5,5,5,5,5,5];  %下界
decision_low_array(1:decisionNum)=0;  %dMOP1上界
decision_high_array(1:decisionNum)=1;  %dMOP1下界

max_generation=200;           %进化代数
pop_num=100;                  %种群规模
max_u_num=100;                %精英种群最大规模
cross_rate=0.9;               %交叉操作概率
mute_rate=1/decisionNum;      %变异操作的变异率
selectOpNum=[1,2,5];

% Initialization
% 生成初始化种群           种群规模,决策变量分段数,上界 ,下界 
particle = CreateEmptyParticle(pop_num); %生成pop_num个新个体种群
pop1 = init_Population(particle,decision_low_array,decision_high_array);  
% save('C:\calculate result\dMOP1-pop','pop1');
% load  ('C:\calculate result\dMOP1-pop')

for i=1:run_num
    T=3;
    tVal=0;%环境变量
    temp_result=[];
    pop=pop1;
     %初始化五种操作的选择概率
    %  1:BLX(2:1)    2:SBX(2:2)   3:SPX(3:1)    4:PCX(3:)    5:DE(3:1)
    operation_chooseProb(1:size(selectOpNum,2)) =[0.33,0.67,1] ;
    pop = calc_objects(pop,tVal);                                            %评估种群中的解
    while tVal<=T
        %算法的循环内容
        gen_count=1;
        EXA=[];
        while gen_count <= max_generation 
            indeces = extract_nondominatedset(pop);  %执行非支配排序
            EXA =[EXA, pop(indeces)];                %初始化EXA
            %EXA进行局部搜索
            EXA = EXA_propagate_mechanism(EXA,max_u_num,cross_rate,decision_low_array,decision_high_array,operation_chooseProb,selectOpNum,tVal);
            %全局搜索 EXA和POP
            pop = updatePopulation(pop,EXA,pop_num,operation_chooseProb,selectOpNum,cross_rate,decision_low_array,decision_high_array,tVal);
            pop = calc_objects(pop,tVal);                                            %评估种群中的解
            fprintf('gen_count=%d     EXA=%d\n',gen_count,size(EXA,2));
            gen_count = gen_count + 1;
        end
        tVal=tVal+1;
        temp_result=[temp_result,{EXA}];
        %重新初始化种群
        %冷启动    
        pop_cold = init_Population(particle,decision_low_array,decision_high_array);
        % pop=pop_cold;
        %热启动
        pop_hot=next_Pop( EXA,pop_num,decision_low_array,decision_high_array );
        %pop=pop_hot;
        pop=new_pop(pop_cold,pop_hot,tVal);
        pop = calc_objects(pop,tVal);
    end
    %EXA__R_cold{i}=temp_result;  
    %EXA__R_hot{i}=temp_result;    
    EXA__R{i}=temp_result;
end
save('C:\calculate result\dMOP1-complex-20000','EXA__R');
%画图函数
% drawObjectPoints( temp_result );
t = toc