function returnValue = calculeZ(this, valueX)
% LL_Partition::calculeZ() :
%   returns the value of function z
%   z = e(-1/2 (somme[d]   (valueX(d) - centre(d))^2 / ecartType(d)^2 ))
    centre = (this.dimensionMin + this.dimensionMax) / 2;
    returnValue = exp(-0.5 * sum(((valueX - centre).^2) ./ this.listEcartType .^2));
