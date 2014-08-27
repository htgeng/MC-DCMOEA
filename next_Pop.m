%生成下一代种群
function [ next_Pop] = next_Pop( EXA,pop_num,decision_low_array,decision_high_array)
%NEXT_POP Summary of this function goes here
%Detailed explanation goes here 
    %namt  范围放大倍数
    %柯西变异
    next_Pop=Cauchy_mute(EXA,pop_num,decision_low_array,decision_high_array);
    %高斯变异
% next_Pop=Gauss_mute(EXA,pop_num,decision_low_array,decision_high_array);
end

%热启动  柯西变异
function [next_pop]=Cauchy_mute(EXA,pop_num,decision_low_array,decision_high_array)
    %统计EXA中个体的每一维最大值和最小值
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
    x_num=size(EXA(1).pop,2);    %维数
    %柯西参数
    a=0;
    b=1;
    for i=1:pop_num                        %种群规模
        temp.pop=zeros(1,x_num);
        m=mod(i,size(EXA,2));
        k=m;
        if m==0
            m=size(EXA,2);
        end
        for j=1:x_num          %维数
            t=1;
            %判断是否越界
            while t<10
                p=unifrnd(0,1);
                temp.pop(j)=EXA(m).pop(j)+sigma(j)*cauchyinv(p,a,b);       %柯西变异                
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
        %当种群规模大于EXA规模时，更新sigma
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

%热启动  高斯变异
function [next_pop]=Gauss_mute(EXA,pop_num,decision_low_array,decision_high_array)
    %统计EXA中个体的每一维最大值和最小值
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
    
    x_num=size(EXA(1).pop,2);    %维数
    for i=1:pop_num                        %种群规模
        temp.pop=zeros(1,x_num);
        m=mod(i,size(EXA,2));
        k=m;
        if m==0
            m=size(EXA,2);
        end
        for j=1:x_num          %维数
            t=1;
            %判断是否越界
            while t<10     
                temp.pop(j)=EXA(m).pop(j)+sigma(j)*randn;   %rand：产生正太分布的随机数
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
        %当种群规模大于EXA规模时，更新sigma
        if k==0            
            sigma=sigma.*exp(sqrt(2.*x_num).^(-1).*randn+sqrt(2.*sqrt(x_num)).*(-1).*randn);
        end
    end
end
%热启动  高斯扰动
function [next_pop]=Gauss_init(EXA,selectOpNum,decision_low_array,decision_high_array,particle,dividerangenum)
    %统计EXA中个体的每一维最大值和最小值
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

%热启动  柯西扰动
function [next_pop]=Cauchy_init(EXA,selectOpNum,decision_low_array,decision_high_array,particle,dividerangenum)
    %统计EXA中个体的每一维最大值和最小值
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
