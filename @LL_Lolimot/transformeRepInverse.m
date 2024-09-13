function listTransValues = transformeRepInverse(this, listValues)
% LL_Lolimot::transformeRepInverse :
% this method applies the inverse transformation to listValues

    nbValues = size(listValues, 1);
    listTransValues = listValues;

    indInf = find(listTransValues < 0);
    indSup = find(listTransValues >= 0);
    
    if size(indInf) > 0
        listTransValues(indInf) = this.seuilTransfoRep * exp(listTransValues(indInf) / this.seuilTransfoRep);
    end
    if size(indSup) > 0
        listTransValues(indSup) = listTransValues(indSup) + this.seuilTransfoRep;
    end

    listTransValues = listTransValues - this.decalageTransfoRep;
    