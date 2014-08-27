%����ӵ������
function [ crowdDistance ] = calc_crowd_distance( pop )
%caltype: =0 �˵�Ϊ���� 1���˵�Ϊ����������
%CALC_CROWD_DISTANCE Summary of this function goes here
%   Detailed explanation goes here
    l_size=size(pop,2);
    crowdDistance = zeros(1,l_size);
    m = size(pop(1).objectVal,2);     %Ŀ�꺯������
    for i = 1:m-1
        obj_val_i = zeros(1,l_size);  %����l_size�������飬����������ÿһ��Ŀ�꺯�������и��������ֵ
        for j = 1:l_size
            obj_val_i(j) = pop(j).objectVal(i); 
        end
        [obj_val_i_sort,s]=sort(obj_val_i);           %�����ݽ������򣬲��ҷ���ԭ�����±�s
        crowdDistance(s(1)) = Inf;            %ͷβ���ó������
        crowdDistance(s(l_size)) = Inf;
        crowdDistance(s(2:l_size-1))=crowdDistance(s(2:l_size-1))+obj_val_i(s(3:l_size))-obj_val_i(s(1:l_size-2));
    end
end
