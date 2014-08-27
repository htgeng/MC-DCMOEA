%polynomial mutation  ����ʽ����
function [ pop ] = Pop_mutation(pop,decision_low_array,decision_high_array)
%POP_MUTATION Summary of this function goes here
%   Detailed explanation goes here
    mute_rate=1/(size(pop(1).pop,2));
    namta_m=20;
    num = size(pop,2);          %��Ⱥ��
    num_div = size(pop(1).pop,2);    %ÿ�������ά��
    for i = 1:num 
        x = pop(i).pop;
        y = x;
        for j = 1:num_div
            if rand < mute_rate
                y(j) = PM(x(j),namta_m,decision_low_array(j),decision_high_array(j));
                count = 1;
                while (y(j) < decision_low_array(j))||(y(j) > decision_high_array(j))          %�жϱ�������Ⱥ�����Խ�磬��������
                    if count == 10      %Ϊʲô����ѭ������Ϊ10
                        break;
                    end
                    y(j) = PM(x(j),namta_m,decision_low_array(j),decision_high_array(j)); 
                    count = count + 1;
                end 
                if count==10
                    y(j)=x(j);
                end
            end
        end
        pop(i).pop=y;
    end
end

function y=PM(x,namta_m,low,high)
    r=rand;
    if r<0.5
        delta=(2*r)^(1/(namta_m+1))-1;
    else
        delta=1-(2*(1-r))^(1/(namta_m+1));
    end
    y=x+(high-low)*delta;
end

