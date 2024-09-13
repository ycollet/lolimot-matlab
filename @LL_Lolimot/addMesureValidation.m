function this = addMesureValidation(this, mesureValidationValue, mesureValidationDimensionValue)
% OptiProblem::addMesureValidation() : add one or several mesure for validation in the Lolimot problem
    
    nbNewMesure = length(mesureValidationValue);
    if (length(mesureValidationDimensionValue) ~= nbNewMesure)
        error('LL_Lolimot::addMesureValidation : bad length for mesureValidationDimensionValue');
    end
    nbDimension = length(mesureValidationDimensionValue(1, :));
    
%     if this.swTransfoRep
%         mesureValidationValue = transformeRep(this, mesureValidationValue);
%     end
    
    for d=1 : nbNewMesure
        nb = length(this.mesureValidationValue);
        if (nb == 0)
            this.mesureValidationValue = mesureValidationValue(d);
            this.mesureValidationDimensionValue(1, :) = zeros(1, nbDimension);
            this.mesureValidationDimensionValue(:) = mesureValidationDimensionValue(d, :);
        else
            this.mesureValidationValue(nb + 1, :) = mesureValidationValue(d, :);
            this.mesureValidationDimensionValue(nb + 1, :) = mesureValidationDimensionValue(d, :);
        end
    end
    
    