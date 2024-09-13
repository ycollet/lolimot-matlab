function returnValue = loliPredict(this, vectValueX, vectorPhi)
% LL_Lolimot::vectValueX() :
% calcule l'estimation pour des valeurs donnees pour chaque dimension pour
% une liste de points définis dans vectValueX
% f(x) = somme/p (ValeurSelonRegression(p) * vectorPhi(p))
% p appartient a l'ensemble des partitions
% phi(p) = z(p) / somme[p2] z(p2)   (phi(p) est donc une proba)
% vectorPhi est optionnel : s'il n'est passé en paramètre, on le calcule

    nbX = size(vectValueX, 1);
    returnValue = zeros(nbX, 1);
    
    % si vectorPhi n'est passé, on le calcule :
    if (nargin == 2)
        vectorPhi = calculePhiPredict(this, vectValueX);
    end
%     % on calcule vectorPhi
%     vectorPhi = calculePhiPredict(this, vectValueX);
    
    nbPartition = length(this.listPartition);
    for (p=1 : nbPartition)
        returnValue = returnValue + calculeValeurSelonRegression(this.listPartition(p), vectValueX) .* vectorPhi(:, p);
    end

    if this.swTransfoRep
        returnValue = transformeRepInverse(this, returnValue);
    end

    

