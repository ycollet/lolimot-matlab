function returnValue = calculeZPredict(this, vectValueX)
% LL_Partition::calculeZPredict() :
%   returns the value of function z for a list of values X
%   z = e(-1/2 (somme[d]   (valueX(d) - centre(d))^2 / ecartType(d)^2 ))
    nbX = size(vectValueX, 1);
    centre = ones(nbX, 1) * ((this.dimensionMin + this.dimensionMax) / 2);
    ecartType = ones(nbX, 1) * this.listEcartType .^2;
    returnValue = exp(-0.5 * sum(((vectValueX - centre).^2) ./ ecartType, 2));
