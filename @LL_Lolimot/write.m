function str = write(this)
% LL_Lolimot::write
    nbDimension = length(this.dimensionMin);
    str = sprintf('%s\n', this.name);
    if (this.residu > 0)
        str = sprintf('%s Residu = %f :\n\n', str, this.residu);
    end
    str = sprintf('%sListe des dimensions (%d) :\n', str, nbDimension);
    for (d=1 : nbDimension)
        str = sprintf('%s\t%s : [%f %f] sigma = %f - nbDiscretisation = %d\n', ...
                    str, char(this.dimensionName(d)), this.dimensionMin(d), this.dimensionMax(d), ...
                    this.dimensionEcartType(d), this.dimensionNbDiscretisation(d));
    end

    nbMesure = length(this.mesureValue);
    str = sprintf('%sListe des mesures (%d) :\n', str, nbMesure);
%     for (m=1 : nbMesure)
%         str = sprintf('%s\t%f : [%s]\n', str, this.mesureValue(m), num2str(this.mesureDimensionValue(m, :)));
%     end

    nbPartition = length(this.listPartition);
    str = sprintf('%sListe des partitions (%d) :\n', str, nbPartition);
    for (p=1 : nbPartition)
        str = sprintf('%s%s', str, write(this.listPartition(p)));
    end
