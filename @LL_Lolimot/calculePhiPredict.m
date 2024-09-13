function [vectorPhi, sommeZ] = calculePhiPredict(this, vectValueX)
% LL_Lolimot::calculePhiPredict() :
% returns the value of phi function for each partition for a list of values X
    nbPartition = length(this.listPartition);
    nbX = size(vectValueX, 1);
    
    % on calcule les z
    for (p=1 : nbPartition)
        vectorPhi(:, p) = calculeZPredict(this.listPartition(p), vectValueX);
    end
    
    % on en deduit phi
    sommeZ = sum(vectorPhi, 2) * ones(1, nbPartition);
    vectorPhi = vectorPhi ./ sommeZ;
