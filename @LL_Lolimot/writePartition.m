function str = writePartition(this, nameFile)
% Ecriture dans fichier des decoupages::writePartition
    
    ficPartition = fopen(nameFile,'w');
 
    nbPartition = length(this.listPartition);
    fprintf(ficPartition, '%d\n', nbPartition);
    for (p=1 : nbPartition)
        fprintf(ficPartition, '%s\n', writeForSaving(this.listPartition(p)));
    end

    fclose(ficPartition);
