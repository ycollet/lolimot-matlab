function listTransValues = transformeRep(this, listValues)
% LL_Lolimot::transformeRep :
% this method applies the transformation to listValues

    nbValues = size(listValues, 1);
    listTransValues = listValues + this.decalageTransfoRep;
    indInf = find(listTransValues < this.seuilTransfoRep);
    indSup = find(listTransValues >= this.seuilTransfoRep);
    
    if size(indInf) > 0
        listTransValues(indInf) = this.seuilTransfoRep * log(listTransValues(indInf) / this.seuilTransfoRep);
    end
    if size(indSup) > 0
        listTransValues(indSup) = listTransValues(indSup) - this.seuilTransfoRep;
    end
