function str = writeForSaving(this)
% LL_Partition::writeForSaving : generates a string writed in a file for
% re-reading

    nbDimension = length(this.dimensionMin);
    str = '';
    
    % on écrit les dimensions de la partition pour chaque emmission
    for (d=1 : nbDimension)
        str = sprintf('%s  %.10f %.10f ', str, this.dimensionMin(d), this.dimensionMax(d));
    end 
    
    % on écrit les coefficients de la partition
    str = sprintf('%s %.10f', str, this.coeff0);
    for (d=1 : nbDimension)
        str = sprintf('%s %.10f', str, this.listCoeff(d));
    end
    