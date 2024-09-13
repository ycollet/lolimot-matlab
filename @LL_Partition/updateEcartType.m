function this = updateEcartType(this, dimensionEcartType)
% LL_Partition::updateEcartType() :
% met à jour l'ecart-type de cette partition pour chaque dimension
    this.listEcartType = dimensionEcartType .* (this.dimensionMax - this.dimensionMin);