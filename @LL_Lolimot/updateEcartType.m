function updateEcartType(thisUnused)
% LL_Lolimot::updateEcartType() :
% met à jour l'ecart-type de chaque partition pour chaque dimension
    global currentLolimot
    nbPartition = length(currentLolimot.listPartition);
    for (p=1 : nbPartition)
        currentLolimot.listPartition(p) = updateEcartType(currentLolimot.listPartition(p), currentLolimot.dimensionEcartType);
    end
