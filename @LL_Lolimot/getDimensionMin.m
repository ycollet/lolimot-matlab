function returnCode = getDimensionMin(this, index)
% LL_Lolimot::getDimensionMin() :
% returns the index' min dimension (or the vector if index is not passed)
	if (nargin == 1)
        returnCode = this.dimensionMin;
	else
        returnCode = this.dimensionMin(index);
    end