function returnCode = getDimensionName(this, index)
% LL_Lolimot::getDimensionName() :
% returns the index' name dimension (or the vector if index is not passed)
	if (nargin == 1)
        returnCode = this.dimensionName;
	else
        returnCode = this.dimensionName{index};
    end