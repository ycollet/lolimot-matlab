function returnCode = getDimensionMax(this, index)
% LL_Lolimot::getDimensionMax() :
% returns the index' max dimension (or the vector if index is not passed)
	if (nargin == 1)
        returnCode = this.dimensionMax;
	else
        returnCode = this.dimensionMax(index);
    end