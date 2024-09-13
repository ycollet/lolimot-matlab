function returnValue = calculeValeurSelonRegression(this, valueX)
% LL_Partition::calculeValeurSelonRegression() :
% calcule la valeur resultante  pour des valeurs donnees pour chaque dimension
% avec les coefficients de la regression
% returnValue = coeff0 + somme/d (coeff(d) * x(d))
    returnValue = this.coeff0 + valueX * this.listCoeff;
    