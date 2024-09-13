function this = addMesure(this, mesureValue, mesureDimensionValue)
% OptiProblem::addMesure() : add one or several mesure in the Lolimot problem
    
    nbNewMesure = length(mesureValue);
    if (size(mesureDimensionValue, 1) ~= nbNewMesure)
        error('LL_Lolimot::addMesure : bad length for mesureDimensionValue');
    end
    nbDimension = length(mesureDimensionValue(1, :));
    
    if this.swTransfoRep
        mesureValueTransfo = transformeRep(this, mesureValue);
    end
    
    for d=1 : nbNewMesure
        nb = length(this.mesureValue);
        if (nb == 0)
            this.mesureValue = mesureValue(d);
            this.mesureDimensionValue(1, :) = zeros(1, nbDimension);
            this.mesureDimensionValue(:) = mesureDimensionValue(d, :);
            if this.swTransfoRep
                this.mesureValueTransfo = mesureValueTransfo(d);
            end
        else
            this.mesureValue(nb + 1, :) = mesureValue(d, :);
            this.mesureDimensionValue(nb + 1, :) = mesureDimensionValue(d, :);
            if this.swTransfoRep
                this.mesureValueTransfo(nb + 1, :) = mesureValueTransfo(d, :);
            end
        end
    end
    
    