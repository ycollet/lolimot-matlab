function addPartition(thisUnused, partition)
% OptiProblem::addMesure() : add one or several mesure in the Lolimot problem
    global currentLolimot
    
    nbNewPartition = length(partition);
    
    for d=1 : nbNewPartition
        nb = length(currentLolimot.listPartition);
        if (nb == 0)
            currentLolimot.listPartition = partition(d);
        else
            currentLolimot.listPartition(nb + 1) = partition(d);
        end
    end
    
    