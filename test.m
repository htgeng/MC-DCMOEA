%…Ëº∆∂ƒ≈Ã
function [ sWheel ] = test( EXA)
    crowdDistance = calc_crowd_distance(EXA);
    maxValue=max(crowdDistance(crowdDistance~=Inf))*2;
	sumCrowdDis = 0;    
    for i = 1:size(EXA,2)       
        if crowdDistance(i)== Inf
            crowdDistance(i)=maxValue;
        end
        sumCrowdDis = sumCrowdDis + crowdDistance(i);
    end
    sWheel = crowdDistance./sumCrowdDis;
end
