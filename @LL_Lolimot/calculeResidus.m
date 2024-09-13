function [returnValue, intituleColonnes] = calculeResidus(this)
% LL_Lolimot::calculeResidus() :
% calcule le residu sur les mesures d'apprentissage si typeMesure = 1
%                      sur les mesures de validation si typeMesure = 2
% type de residu calcule selon la valeur de typeResidu :
%   1 : residu L1
%   2 : residu L1 relatif
%   3 : residu L2
%   4 : residu L infini (plus grand écart)

    warning off MATLAB:divideByZero;

    intituleColonnes = struct('ResOptim',           1, ...
                              'ResL1Appr',          2, ...
                              'ResL1RelatifAppr',   3, ...
                              'ResL2Appr',          4, ...
                              'ResLInfiniAppr',     5, ...
                              'ResR2Appr',          6, ...
                              'ResL1Valid',         7, ...
                              'ResL1RelatifValid',  8, ...
                              'ResL2Valid',         9, ...
                              'ResLInfiniValid',    10, ...
                              'ResR2Valid',         11);

    returnValue(1, intituleColonnes.ResOptim) = 0.0;
                          
    % -------------------------------------------------------------
    % on calcule les residus sur les essais d'apprentissage
    mValue = this.mesureValue;
    mDimValue = this.mesureDimensionValue;
    nbMesure = length(mValue);
    % on calcule vectorF
    vectorF = loliPredict(this, mDimValue);
    
    returnValue(1, intituleColonnes.ResL1Appr) = sum(abs(mValue - vectorF)) / nbMesure;
    returnValue(1, intituleColonnes.ResL1RelatifAppr) = sum(abs((mValue - vectorF) ./ mValue)) / nbMesure;
    returnValue(1, intituleColonnes.ResL2Appr) = (sum((mValue - vectorF).^2) / nbMesure)^0.5;
    returnValue(1, intituleColonnes.ResLInfiniAppr) = max(mValue - vectorF);
    returnValue(1, intituleColonnes.ResR2Appr) = 1-(std(vectorF-mValue)/std(mValue))^2;

    % -------------------------------------------------------------
    % on calcule les residus sur les essais de validation
    if size(this.mesureValidationValue, 1) > 0
        mValue = this.mesureValidationValue;
        mDimValue = this.mesureValidationDimensionValue;
        nbMesure = length(mValue);
        % on calcule vectorF
        vectorF = loliPredict(this, mDimValue);
        
        returnValue(1, intituleColonnes.ResL1Valid) = sum(abs(mValue - vectorF)) / nbMesure;
        returnValue(1, intituleColonnes.ResL1RelatifValid) = sum(abs((mValue - vectorF) ./ mValue)) / nbMesure;
        returnValue(1, intituleColonnes.ResL2Valid) = (sum((mValue - vectorF).^2) / nbMesure)^0.5;
        returnValue(1, intituleColonnes.ResLInfiniValid) = max(mValue - vectorF);
        returnValue(1, intituleColonnes.ResR2Valid) = 1-(std(vectorF-mValue)/std(mValue))^2;
    else
        returnValue(1, intituleColonnes.ResL1Valid) = 0.0;
        returnValue(1, intituleColonnes.ResL1RelatifValid) = 0.0;
        returnValue(1, intituleColonnes.ResL2Valid) = 0.0;
        returnValue(1, intituleColonnes.ResLInfiniValid) = 0.0;
        returnValue(1, intituleColonnes.ResR2Valid) = 0.0;
    end
