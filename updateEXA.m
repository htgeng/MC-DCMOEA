%EXA���»���
function [ EXA ] = updateEXA( EXA,pop,max_exa_num )
%UPDATEEXA Summary of this function goes here
%   Detailed explanation goes here
    EXA = [EXA,pop];                              %���·�֧�����ӵ�EXA��
    indeces = extract_nondominatedset(EXA);         %��EXAִ�з�֧������
    EXA = EXA(indeces);
    EXA = EXA_cut( EXA,max_exa_num );               %���EXAԽ��  ɾ��EXA�е�ӵ��������С��Ԫ��
end

