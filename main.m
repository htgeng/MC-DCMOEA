tic
run_num=30;%�������еĴ���
% EXA__R=cell(1,run_num);
%���Ժ�����������
decisionNum = 10;                          %���߱�������
%decision_low_array(1:decisionNum)=[0,-5,-5,-5,-5,-5,-5,-5,-5,-5];  %�Ͻ�
%decision_high_array(1:decisionNum)=[1,5,5,5,5,5,5,5,5,5];  %�½�
decision_low_array(1:decisionNum)=0;  %dMOP1�Ͻ�
decision_high_array(1:decisionNum)=1;  %dMOP1�½�

max_generation=200;           %��������
pop_num=100;                  %��Ⱥ��ģ
max_u_num=100;                %��Ӣ��Ⱥ����ģ
cross_rate=0.9;               %�����������
mute_rate=1/decisionNum;      %��������ı�����
selectOpNum=[1,2,5];

% Initialization
% ���ɳ�ʼ����Ⱥ           ��Ⱥ��ģ,���߱����ֶ���,�Ͻ� ,�½� 
particle = CreateEmptyParticle(pop_num); %����pop_num���¸�����Ⱥ
pop1 = init_Population(particle,decision_low_array,decision_high_array);  
% save('C:\calculate result\dMOP1-pop','pop1');
% load  ('C:\calculate result\dMOP1-pop')

for i=1:run_num
    T=3;
    tVal=0;%��������
    temp_result=[];
    pop=pop1;
     %��ʼ�����ֲ�����ѡ�����
    %  1:BLX(2:1)    2:SBX(2:2)   3:SPX(3:1)    4:PCX(3:)    5:DE(3:1)
    operation_chooseProb(1:size(selectOpNum,2)) =[0.33,0.67,1] ;
    pop = calc_objects(pop,tVal);                                            %������Ⱥ�еĽ�
    while tVal<=T
        %�㷨��ѭ������
        gen_count=1;
        EXA=[];
        while gen_count <= max_generation 
            indeces = extract_nondominatedset(pop);  %ִ�з�֧������
            EXA =[EXA, pop(indeces)];                %��ʼ��EXA
            %EXA���оֲ�����
            EXA = EXA_propagate_mechanism(EXA,max_u_num,cross_rate,decision_low_array,decision_high_array,operation_chooseProb,selectOpNum,tVal);
            %ȫ������ EXA��POP
            pop = updatePopulation(pop,EXA,pop_num,operation_chooseProb,selectOpNum,cross_rate,decision_low_array,decision_high_array,tVal);
            pop = calc_objects(pop,tVal);                                            %������Ⱥ�еĽ�
            fprintf('gen_count=%d     EXA=%d\n',gen_count,size(EXA,2));
            gen_count = gen_count + 1;
        end
        tVal=tVal+1;
        temp_result=[temp_result,{EXA}];
        %���³�ʼ����Ⱥ
        %������    
        pop_cold = init_Population(particle,decision_low_array,decision_high_array);
        % pop=pop_cold;
        %������
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
%��ͼ����
% drawObjectPoints( temp_result );
t = toc