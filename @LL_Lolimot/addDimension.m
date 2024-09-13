function this = addDimension(this, dimensionName, dimensionMin, dimensionMax, dimensionEcartType, dimensionNbDiscretisation)
% OptiProblem::addDimension() : add one or several dimension in the Lolimot problem
    
    nbNewDimension = length(dimensionName);
    if (length(dimensionMin) ~= nbNewDimension)
        error('LL_Lolimot::addDimension : bad length for dimensionMin');
    end
    if (length(dimensionMax) ~= nbNewDimension)
        error('LL_Lolimot::addDimension : bad length for dimensionMax');
    end
    if (length(dimensionEcartType) ~= nbNewDimension)
        error('LL_Lolimot::addDimension : bad length for dimensionEcartType');
    end
    if (length(dimensionNbDiscretisation) ~= nbNewDimension)
        error('LL_Lolimot::addDimension : bad length for dimensionNbDiscretisation');
    end
    
    for d=1 : nbNewDimension
        nb = length(this.dimensionMin);
        if (nb == 0)
            this.dimensionName{1} = dimensionName{d};
            this.dimensionMin = dimensionMin(d);
            this.dimensionMax = dimensionMax(d);
            this.dimensionEcartType = dimensionEcartType(d);
            this.dimensionNbDiscretisation = dimensionNbDiscretisation(d);
        else
            this.dimensionName{nb + 1} = dimensionName{d};
            this.dimensionMin(nb + 1) = dimensionMin(d);
            this.dimensionMax(nb + 1) = dimensionMax(d);
            this.dimensionEcartType(nb + 1) = dimensionEcartType(d);
            this.dimensionNbDiscretisation(nb + 1) = dimensionNbDiscretisation(d);
        end
    end
    
    