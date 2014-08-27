%创建个体的struct结构
function [ particle ] = CreateEmptyParticle( n )
%CREATEEMPTYPARTICLE Summary of this function goes here
%   Detailed explanation goes here
    if nargin<1                %nargin输入的参数个数
        n=1;
    end
    empty_particle.pop = [];         %个体
    empty_particle.objectVal = [];   %个体的评估值
%    empty_particle.crowdDistance = 0;   %个体的拥挤距离   
    particle=repmat(empty_particle,1,n);       %生成n个新个体
end