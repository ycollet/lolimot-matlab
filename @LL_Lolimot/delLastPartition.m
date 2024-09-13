function delLastPartition(thisUnused)
% LL_Lolimot::delLastPartition() : deletes the last partition created
    global currentLolimot
    
    nbPartition = getNbPartition(currentLolimot);
    if (nbPartition == 0)
        error('LL_Lolimot::delLastPartition : il n''y a pas de partition.\n');
    end
    currentLolimot.listPartition = currentLolimot.listPartition(1 : nbPartition - 1);
    
    