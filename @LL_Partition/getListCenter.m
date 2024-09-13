function returnCode = getListCenter(this)
% LL_Partition::getListCenter() :
% returns the vector of center of each dimension
    returnCode = (this.dimensionMax + this.dimensionMin) / 2;
