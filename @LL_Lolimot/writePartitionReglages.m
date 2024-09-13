function str = writePartitionReglages(this, nameFile, compteurReglages)
% Ecriture dans fichier des decoupages::writePartitionReglages
    
    % ouverture et fermeture du fichier pour ecriture afin d'effacer
    % l'ancien contenu i.e. les anciennes partitions
    if compteurReglages == 1
        ficPartition = fopen(nameFile,'w');
        fclose(ficPartition);
    end
    
    ficPartition = fopen(nameFile,'a');
    nbPartition = length(this.listPartition);
    fprintf(ficPartition, '%d\n', nbPartition);
    for (p=1 : nbPartition)
        fprintf(ficPartition, '%s\n', writeForSaving(this.listPartition(p)));
    end
    fclose(ficPartition);
