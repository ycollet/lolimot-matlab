function str = readPartition(thisUnused, nameFile)
% Lecture des decoupages dans un fichier::readPartition
    global currentLolimot;

    %ficPartition = fopen('resC2MGS', 'r');
    ficPartition = fopen(nameFile, 'r');
    nbDimension = length(getDimensionMin(currentLolimot));

    % nb de partitions a creer
    nbPartition = fscanf(ficPartition, '%d', 1);
    
    % pour chaque partition a creer
    for (p=1 : nbPartition)
        % pour chaque dimension
        for (d=1 : nbDimension)
            dimMin(d) = fscanf(ficPartition, '%f', 1);
            dimMax(d) = fscanf(ficPartition, '%f', 1);
        end % pour chaque dimension
        % on cree la partition
        addPartition(currentLolimot, LL_Partition(dimMin, dimMax));
        
        % on lit le coefficient 0
        coeff0 = fscanf(ficPartition, '%f', 1);
        
        % on lit le coefficient lie a chaque dimension
        for (d=1 : nbDimension)
            listCoeff(d, 1) = fscanf(ficPartition, '%f', 1);
        end % pour chaque dimension
        
        currentLolimot.listPartition(p) = setCoeff(currentLolimot.listPartition(p), coeff0, listCoeff);
    end % pour chaque partition a creer
    
    fclose(ficPartition);
    
    updateEcartType(currentLolimot);
    
    

