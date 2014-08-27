%交叉操作
function [ offspring ] = CrossOperation( OperationPop,operationIndex,cross_rate,decision_low_array,decision_high_array,tVal )
%CROSSOPERATION Summary of this function goes here
%   Detailed explanation goes here    
    
    blx_alpha =0.5;                %四种交叉操作的参数设置
    sbx_eta=20;
    spx_epsilon=1;
    pcx_sigma_epsilon=0.1;
    pcx_sigma_eta=0.1;

    DE_CR=0.6;                     %差分进化的参数
    DE_F=0.5;    
    if rand<cross_rate 
            switch (operationIndex)
                case 1
                    offspring = blx_cross(OperationPop,blx_alpha);            
                case 2
                    offspring = sbx_cross(OperationPop,sbx_eta,tVal);
                case 3
                    offspring = spx_cross(OperationPop,spx_epsilon);
                case 4
                    offspring = pcx_cross(OperationPop,pcx_sigma_epsilon,pcx_sigma_eta);
                case 5
                    offspring = DE_cross(OperationPop,DE_CR,DE_F);
            end  
    
            num_size = size(decision_low_array,2);               %判断交叉后的种群是否越界，这样做是否有问题？？？？
            for i = 1:num_size
                if offspring.pop(i) < decision_low_array(i)
                    offspring.pop(i) = decision_low_array(i);
                elseif offspring.pop(i) > decision_high_array(i)
                    offspring.pop(i) = decision_high_array(i);
                end
            end
    else
        tmpPopNum=size(OperationPop,2);
        offspring.pop =OperationPop{randi(tmpPopNum)};%ght modi       
    end
end

%blx交叉操作  1
function [ offspring ] = blx_cross(OperationPop,blx_alpha)
        for i = 1:size(OperationPop{1},2)
                cmin = min(OperationPop{1}(i),OperationPop{2}(i));
                cmax = max(OperationPop{1}(i),OperationPop{2}(i));
                offspring.pop(i) =unifrnd(cmin-(cmax-cmin)*blx_alpha, cmax+(cmax-cmin)*blx_alpha);
        end
end

%sbx交叉操作  2
function [ offspring ]=sbx_cross(OperationPop,nc,tVal)
%SBX Crossover
    n=size(OperationPop{1},2);
    x1=OperationPop{1};
    x2=OperationPop{2};
    y1=x1;
    y2=x2;
    for i=1:n
            [y1(i),y2(i)]=SBX(x1(i),x2(i),nc);
    end
    op1.pop=y1;
    op2.pop=y2;
    y1= calc_objects(op1,tVal);
    y2= calc_objects(op2,tVal);
    offspring1=y1;
    if (compare_indivuals(y1.objectVal,y2.objectVal)==2 )|| ( (compare_indivuals(y1.objectVal,y2.objectVal)==0) && randi(2)==2   )  %执行非支配排序
               offspring1=y2;
    end
    offspring.pop=offspring1.pop;
end

 function [y1,y2]=SBX(x1,x2,nc)
        u=rand;
        if u<0.5
            beta=(2*u)^(1/(nc+1));
        else
            beta=(1/(2*(1-u)))^(1/(nc+1));
        end
        y1=0.5*((1+beta)*x1+(1-beta)*x2);
        y2=0.5*((1-beta)*x1+(1+beta)*x2);
    end    

%spx交叉操作  3
function [ offspring ] = spx_cross(OperationPop,spx_epsilon)
    arr=[1 2 3;1 3 2;2 1 3;2 3 1;3 1 2;3 2 1];
    arrindex=randi(6);
    x1=OperationPop{arr(arrindex,1)};
    x2=OperationPop{arr(arrindex,2)};
    x3=OperationPop{arr(arrindex,3)};
    u=unifrnd(0,1);
    offspring.pop =(1-sqrt(u)).*x3+(sqrt(u)*(1-u).*x2+u*sqrt(u).*x1);
end

%pcx交叉操作  4
function [ offspring ] = pcx_cross(OperationPop,pcx_sigma_epsilon,pcx_sigma_eta)
    u = size(OperationPop,2);    %父类个体的个数
    sum_pop = OperationPop{1};
    for i = 2:u
        sum_pop = sum_pop + OperationPop{i};
    end
    G = sum_pop./u;          %求解个体的中心
    rnd = randi(u);          %随机选择一个父代个体
    Xp = OperationPop{rnd};
    dp = Xp - G;             %求算方向向量
    
    D_aveg = 0;
    c = dist(Xp,G');          %求三角形的边长，c:底边
    for j = 1:u
        if j ~= rnd
            a = dist(OperationPop{j},Xp');
            b = dist(OperationPop{j},G');
            p = (a+b+c)/2;
            s = sqrt(p*(p-a)*(p-b)*(p-c));    %求三点构成三角形的面积
            D_aveg = D_aveg + 2*s/c;
        end
    end
    D_aveg = D_aveg/(u-1);
    for i=1:u
            w_epsilon = normrnd(0,pcx_sigma_epsilon^2);        %normrnd是平均值为0，方差为pcx_eta^2的正太分布
            w_eta=normrnd(0,pcx_sigma_eta^2); 
            Xp(i)=Xp(i)+w_epsilon*dp(i)+w_eta*D_aveg;
    end
    offspring.pop = Xp;
end

%DE交叉操作  5
function [ offspring ] = DE_cross(OperationPop,CR,F)
    num = size(OperationPop{1},2);
    for i = 1:num
        prob = rand;
        if (prob <= CR) || (randi(num)==i)
            offspring.pop(i) = OperationPop{1}(i) + F*(OperationPop{2}(i)-OperationPop{3}(i));
        else 
            offspring.pop(i) = OperationPop{1}(i);
        end
    end
end