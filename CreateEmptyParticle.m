%���������struct�ṹ
function [ particle ] = CreateEmptyParticle( n )
%CREATEEMPTYPARTICLE Summary of this function goes here
%   Detailed explanation goes here
    if nargin<1                %nargin����Ĳ�������
        n=1;
    end
    empty_particle.pop = [];         %����
    empty_particle.objectVal = [];   %���������ֵ
%    empty_particle.crowdDistance = 0;   %�����ӵ������   
    particle=repmat(empty_particle,1,n);       %����n���¸���
end