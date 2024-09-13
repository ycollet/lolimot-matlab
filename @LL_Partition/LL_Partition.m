function this = LL_Partition(dimensionMin, dimensionMax)
% LL_Partition class constructor.
% Fields :
%   listEcartType
%   dimensionMin
%   dimensionMax
%   coeff0
%   listCoeff

    this.listEcartType = zeros(1, length(dimensionMin));
    this.dimensionMin = dimensionMin;
    this.dimensionMax = dimensionMax;
    this.coeff0 = 0.0;
    this.listCoeff = zeros(1, length(dimensionMin));
    this = class(this, 'LL_Partition');
