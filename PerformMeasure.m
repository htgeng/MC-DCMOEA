%��Ⱥ����
function PerformMeasure ( EXA,truePare )
%PERFORMMEASURE Summary of this function goes here
%   Detailed explanation goes here
    GD=calculateGD(EXA,truePare);%General distance
    SP=calculateSP(EXA,truePare);%spread
    MS=calculateMS(EXA,truePare);%Maximum spread
    fprintf('GD=%d    SP=%d   MS=%d\n',GD,SP,MS);
end

%����������ǰ�صľ���
function [GD]=calculateGD(EXA,truePare)
    num=size(EXA,2);
    m=size(EXA(1).objectVal,2);
    sumDis=0;
    for i=1:num
        exaVal=EXA(i).objectVal(1:m-1);
        sumDis=sumDis+(min(dist(truePare,exaVal')))^2;
    end
    GD=sqrt(sumDis)/num;
end

%����ֲ���
function [SP]=calculateSP(EXA,S_true)
    m=size(EXA(1).objectVal,2);
    k=size(S_true,1);
    S=[];                         %ȡ��EXA��ÿһάĿ��ֵ
    for i=1:size(EXA,2)
        S=[S;EXA(i).objectVal(1:m-1)];
    end
    d=calculate_d(S_true,S);
    sum_d=sum(d);
    n_d_averagr(1:size(d,2))=sum_d/k;
    SP=(sum_d+sum(abs(d-n_d_averagr)))/(sum_d*2);
end

function [d]=calculate_d(S_true,S)  
    m=dist(S_true,S');
    m(m==0)=inf;
    d=min(m');
end

%���㸲������ǰ�صĳ̶�
function [MS]=calculateMS(EXA,truePare)
    m=size(EXA(1).objectVal,2);   
    f_l=[];                         %��EXA��ÿһάĿ��ֵ�����ֵ����Сֵ
    for i=1:size(EXA,2)
        f_l=[f_l;EXA(i).objectVal(1:m-1)];
    end
    F_l=truePare;                   %����ʵǰ�ص�ÿһάĿ��ֵ�����ֵ����Сֵ
    sum_deta_l=0;        %����deta_l
    for i=1:m-1
        f_l_max=max(f_l(:,i));
        f_l_min=min(f_l(:,i));
        F_l_max=max(F_l(:,i));
        F_l_min=min(F_l(:,i));
        if f_l_min<F_l_max
            sum_deta_l=sum_deta_l+((min(f_l_max,F_l_max)-max(f_l_min,F_l_min))/(F_l_max-F_l_min))^2;
        end
    end
    MS=sqrt(sum_deta_l/(m-1));
end