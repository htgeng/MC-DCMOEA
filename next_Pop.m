%������һ����Ⱥ
function [ next_Pop] = next_Pop( EXA,pop_num,decision_low_array,decision_high_array)
%NEXT_POP Summary of this function goes here
%Detailed explanation goes here 
    %namt  ��Χ�Ŵ���
    %��������
    next_Pop=Cauchy_mute(EXA,pop_num,decision_low_array,decision_high_array);
    %��˹����
% next_Pop=Gauss_mute(EXA,pop_num,decision_low_array,decision_high_array);
end

%������  ��������
function [next_pop]=Cauchy_mute(EXA,pop_num,decision_low_array,decision_high_array)
    %ͳ��EXA�и����ÿһά���ֵ����Сֵ
    temp_low=[];
    temp_high=[];
    for j=1:size(EXA(1).pop,2)
        min=EXA(1).pop(j);
        max=EXA(1).pop(j);
        for i=1:size(EXA,2)
            if EXA(i).pop(j)<min
                min=EXA(i).pop(j);
            end
            if EXA(i).pop(j)>max
                max=EXA(i).pop(j);
            end
        end
        temp_low=[temp_low,min];
        temp_high=[temp_high,max];
        temp_low=temp_low;
        temp_high=temp_high;
    end 
    next_pop=[];
    sigma=(temp_high-temp_low)./sqrt(size(temp_low,2));  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %sigma=(decision_high_array-decision_low_array)./sqrt(size(decision_low_array,2));
    x_num=size(EXA(1).pop,2);    %ά��
    %��������
    a=0;
    b=1;
    for i=1:pop_num                        %��Ⱥ��ģ
        temp.pop=zeros(1,x_num);
        m=mod(i,size(EXA,2));
        k=m;
        if m==0
            m=size(EXA,2);
        end
        for j=1:x_num          %ά��
            t=1;
            %�ж��Ƿ�Խ��
            while t<10
                p=unifrnd(0,1);
                temp.pop(j)=EXA(m).pop(j)+sigma(j)*cauchyinv(p,a,b);       %��������                
                if temp.pop(j)<=decision_high_array(j)&&temp.pop(j)>=decision_low_array(j)
                    break;
                else
                    t=t+1;
                end
                if t==10
                    if temp.pop(j)>decision_high_array(j)
                        temp.pop(j)=decision_high_array(j);
                    else
                        temp.pop(j)=decision_low_array(j);
                    end
                end                  
            end      
        end        
        temp.objectVal=[];
        next_pop=[next_pop,temp];
        %����Ⱥ��ģ����EXA��ģʱ������sigma
        if k==0
            for rr=1:x_num
                p1(rr)=unifrnd(0,1);
                p2(rr)=unifrnd(0,1);   
            end
            a=0;
            b=1;
            sigma=sigma.*exp(sqrt(2.*x_num).^(-1).*randn+sqrt(2.*sqrt(x_num)).*(-1).*randn);  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %sigma=sigma.*exp(sqrt(2.*x_num).^(-1).*cauchyinv(p1,a,b)+sqrt(2.*sqrt(x_num)).*(-1).*cauchyinv(p2,a,b));
        end
    end
end

%������  ��˹����
function [next_pop]=Gauss_mute(EXA,pop_num,decision_low_array,decision_high_array)
    %ͳ��EXA�и����ÿһά���ֵ����Сֵ
    temp_low=[];
    temp_high=[];
    for j=1:size(EXA(1).pop,2)
        min=EXA(1).pop(j);
        max=EXA(1).pop(j);
        for i=1:size(EXA,2)
            if EXA(i).pop(j)<min
                min=EXA(i).pop(j);
            end
            if EXA(i).pop(j)>max
                max=EXA(i).pop(j);
            end
        end
        temp_low=[temp_low,min];
        temp_high=[temp_high,max];
        temp_low=temp_low.*2;
        temp_high=temp_high.*2;
    end 

    next_pop=[];
    sigma=(temp_high-temp_low)./sqrt(size(temp_low,2));
    
    x_num=size(EXA(1).pop,2);    %ά��
    for i=1:pop_num                        %��Ⱥ��ģ
        temp.pop=zeros(1,x_num);
        m=mod(i,size(EXA,2));
        k=m;
        if m==0
            m=size(EXA,2);
        end
        for j=1:x_num          %ά��
            t=1;
            %�ж��Ƿ�Խ��
            while t<10     
                temp.pop(j)=EXA(m).pop(j)+sigma(j)*randn;   %rand��������̫�ֲ��������
                if temp.pop(j)<=decision_high_array(j)&&temp.pop(j)>=decision_low_array(j)
                    break;
                else
                    t=t+1;
                end
            end  
            if t==10
                if temp.pop(j)>decision_high_array(j)
                    temp.pop(j)=decision_high_array(j);
                else
                    temp.pop(j)=decision_low_array(j);
                end
            end
        end
        temp.selectOp=EXA(m).selectOp;
        temp.pba=[];
        next_pop=[next_pop,temp];
        %����Ⱥ��ģ����EXA��ģʱ������sigma
        if k==0            
            sigma=sigma.*exp(sqrt(2.*x_num).^(-1).*randn+sqrt(2.*sqrt(x_num)).*(-1).*randn);
        end
    end
end
%������  ��˹�Ŷ�
function [next_pop]=Gauss_init(EXA,selectOpNum,decision_low_array,decision_high_array,particle,dividerangenum)
    %ͳ��EXA�и����ÿһά���ֵ����Сֵ
    for j=1:size(EXA(1).pop,2)
        min=EXA(1).pop(j);
        max=EXA(1).pop(j);
        for i=1:size(EXA,2)
            if EXA(i).pop(j)<min
                min=EXA(i).pop(j);
            end
            if EXA(i).pop(j)>max
                max=EXA(i).pop(j);
            end
        end
        temp_low=[temp_low,min];
        temp_high=[temp_high,max];
    end 
    next_pop=Gauss_init_Population(particle,dividerangenum,temp_low,temp_high,selectOpNum,decision_low_array,decision_high_array);
end

%������  �����Ŷ�
function [next_pop]=Cauchy_init(EXA,selectOpNum,decision_low_array,decision_high_array,particle,dividerangenum)
    %ͳ��EXA�и����ÿһά���ֵ����Сֵ
    for j=1:size(EXA(1).pop,2)
        min=EXA(1).pop(j);
        max=EXA(1).pop(j);
        for i=1:size(EXA,2)
            if EXA(i).pop(j)<min
                min=EXA(i).pop(j);
            end
            if EXA(i).pop(j)>max
                max=EXA(i).pop(j);
            end
        end
        temp_low=[temp_low,min];
        temp_high=[temp_high,max];
    end 
    next_pop=Cauchy_init_Population(particle,dividerangenum,temp_low,temp_high,selectOpNum,decision_low_array,decision_high_array);
end
