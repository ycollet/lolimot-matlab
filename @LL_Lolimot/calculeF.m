function returnValue = calculeF(this, valueX, vectorPhi)
% LL_Lolimot::calculeF() :
% calcule l'estimation pour des valeurs donnees pour chaque dimension
% f(x) = somme/p (ValeurSelonRegression(p) * vectorPhi(p))
% p appartient a l'ensemble des partitions
% phi(p) = z(p) / somme[p2] z(p2)   (phi(p) est donc une proba)
% vectorPhi est optionnel : s'il n'est passé en paramètre, on le calcule
    returnValue = 0.0;
    
    % si vectorPhi n'est passé, on le calcule :
    if (nargin == 2)
        vectorPhi = calculePhi(this, valueX);
    end
    
    nbPartition = length(this.listPartition);
    for (p=1 : nbPartition)
        returnValue = returnValue + calculeValeurSelonRegression(this.listPartition(p), valueX) * vectorPhi(p);
    end

    if this.swTransfoRep
        returnValue = transformeRepInverse(this, returnValue);
    end


