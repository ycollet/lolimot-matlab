function returnValue = calculeResiduL(this, typeResidu, typeMesure, vectorF)
% LL_Lolimot::calculeResiduL() :
% calcule le residu sur les mesures d'apprentissage si typeMesure = 1
%                      sur les mesures de validation si typeMesure = 2
% type de residu calcule selon la valeur de typeResidu :
%   1 : residu L1
%   2 : residu L1 relatif
%   3 : residu L2
%   4 : residu L2 relatif
    
    if (typeMesure == 1)
        mValue = this.mesureValue;
        mDimValue = this.mesureDimensionValue;
    else
        mValue = this.mesureValidationValue;
        mDimValue = this.mesureValidationDimensionValue;
    end
    nbMesure = length(mValue);
    
    % si vectorF n'est passé, on le calcule :
    if (nargin == 3)
        for (m=1 : nbMesure)
            vectorF(m, 1) = calculeF(this, mDimValue(m, :));
        end
    end

    switch (typeResidu)
        case 1
            returnValue = sum(abs(mValue - vectorF)) / nbMesure;
        case 2
            returnValue = sum(abs((mValue - vectorF) ./ mValue)) / nbMesure;
        case 3
            returnValue = (sum((mValue - vectorF).^2) / nbMesure)^0.5;
        case 4
            returnValue = max(abs(mValue - vectorF));
        case 5
    end


