function [ indeces ] = extract_nondominatedset( pop )    %ִ�з�֧������
%EXTRACT_NONDOMINATEDSET Summary of this function goes here
%   Detailed explanation goes here
    indeces=[];             %�洢��֧�����±�
    for i = 1:size(pop,2)
        b = pop(i).objectVal;            %bΪ�ȴ��������Ⱥ����
        j = 1;
        is_add = 1;
        while (j <= size(indeces,2))&&(is_add == 1)
            a = pop(indeces(j)).objectVal;     %ѡ���֧��⼯�еĸ���
            is_dom = compare_indivuals(a,b);
            if is_dom == 1
                is_add = 0;
            end
            if is_dom == 2
                indeces = [indeces(1:j-1),indeces(j+1:size(indeces,2))];
                j=j-1;
            end
            j = j + 1;
        end
        if is_add == 1
            indeces = [indeces,i];
        end
    end
end
       