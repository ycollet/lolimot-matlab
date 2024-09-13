function [vectorPhi, sommeZ] = calculePhi(this, valueX)
% LL_Lolimot::calculePhi() :
% returns the value of phi function for each partition
    nbPartition = length(this.listPartition);
    
    % on calcule les z
    for (p=1 : nbPartition)
        vectorPhi(p) = calculeZ(this.listPartition(p), valueX);
    end
    
    % on en deduit phi
    sommeZ = sum(vectorPhi);
    vectorPhi = vectorPhi / sommeZ;
