function str = write(this)
% LL_Partition::write

    nbDimension = length(this.dimensionMin);
    str = '';
    
    % on écrit les dimensions de la partition pour chaque emmission
    for (d=1 : nbDimension)
        str = sprintf('%s  (%f %f), ', str, this.dimensionMin(d), this.dimensionMax(d));
    end 
    
    % on écrit les coefficients de la partition
    str = sprintf('%s %f,', str, this.coeff0);
    for (d=1 : nbDimension)
        str = sprintf('%s %f', str, this.listCoeff(d));
    end
    str = sprintf('%s\n', str);
    