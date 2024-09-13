function [residu, nbPartitionCreated, listEvolutionResidu, intituleColonnes] = createDecoupage(thisUnused, nbMaxPartition, percentageResiduToStop)
% LL_Lolimot::createDecoupage() :
% génère des partitions de manière à minimiser le résidu global
%   listEvolutionResidu
%       listEvolutionResidu(i, 1) : valeur du résidu R2 sur essais d'apprentissage avec i partitions
%       listEvolutionResidu(i, 2) : valeur du résidu norme L1 sur essais d'apprentissage avec i partitions
%       listEvolutionResidu(i, 3) : valeur du résidu norme L1 relatif sur essais d'apprentissage avec i partitions
%       listEvolutionResidu(i, 4) : valeur du résidu norme L2 sur essais d'apprentissage avec i partitions
%       listEvolutionResidu(i, 5) : valeur du résidu norme L infini sur essais d'apprentissage avec i partitions
%       listEvolutionResidu(i, 6) : valeur du résidu R2 sur essais d'apprentissage avec i partitions
%       listEvolutionResidu(i, 7) : valeur du résidu norme L1 sur essais de validation avec i partitions
%       listEvolutionResidu(i, 8) : valeur du résidu norme L1 relatif sur essais de validation avec i partitions
%       listEvolutionResidu(i, 9) : valeur du résidu norme L2 sur essais de validation avec i partitions
%       listEvolutionResidu(i, 10) : valeur du résidu norme L infini sur essais de validation avec i partitions
%       listEvolutionResidu(i, 11) : valeur du résidu R2 sur essais de validation avec i partitions

    intituleColonnes = struct('ResOptim',           1, ...
                              'ResL1Appr',          2, ...
                              'ResL1RelatifAppr',   3, ...
                              'ResL2Appr',          4, ...
                              'ResLInfiniAppr',     5, ...
                              'ResR2Appr',          6, ...
                              'ResL1Valid',         7, ...
                              'ResL1RelatifValid',  8, ...
                              'ResL2Valid',         9, ...
                              'ResLInfiniValid',    10, ...
                              'ResR2Valid',         11);
    
    global currentLolimot
    warning off MATLAB:nearlySingularMatrix;
    % s'il y a deja des partitions, on quitte avec une erreur
    if (length(currentLolimot.listPartition) > 0)
        error('LL_Lolimot::createDecoupage : il existe déjà des partitions.\n');
    end
    
    residuLValid = 0;
    residuApprentissage = 0;
    
    
    % on cree une 1ere partition pour initialiser
    addPartition(currentLolimot, LL_Partition(currentLolimot.dimensionMin, currentLolimot.dimensionMax));
    % on calcule les coefficients avec 1 seule partition pour voir le
    % residu initial :
    residu = calculeCoefficients(currentLolimot,1);
    currentLolimot.initialResidu = residu;
    disp(sprintf('Residu initial = %f \n\n', residu));
    currentLolimot
    
    currentLolimot.residu = residu;
    
    listEvolutionResidu = calculeResidus(currentLolimot);
    listEvolutionResidu(1, intituleColonnes.ResOptim) = residu;
    disp(sprintf('Residu L1 sur les essais d''apprentissage = %f', listEvolutionResidu(1, intituleColonnes.ResL1Appr)));
    nbMesureValidation = length(currentLolimot.mesureValidationValue);
    if (nbMesureValidation > 0)
        disp(sprintf('Residu L1 sur les essais de validation = %f', listEvolutionResidu(1, intituleColonnes.ResL1Valid)));
    end
    
    swCreated = 1;
    if (currentLolimot.initialResidu < 1e-10)
        swCreated = 0;
    end
    partitionWithBiggestResidu = 1;
    while ((swCreated) && (length(currentLolimot.listPartition) < nbMaxPartition))
        [residu, partitionWithBiggestResidu] = addTheBestPartition(currentLolimot, partitionWithBiggestResidu, percentageResiduToStop);
        if (residu < 0)
            swCreated = 0;
        else
            % calcul des residus
            nbPartition = length(currentLolimot.listPartition);
            listEvolutionResidu(nbPartition, :) = calculeResidus(currentLolimot);
            listEvolutionResidu(nbPartition, intituleColonnes.ResOptim) = residu;
            disp(sprintf('Residu L1 sur les essais d''apprentissage = %f', listEvolutionResidu(nbPartition, intituleColonnes.ResL1Appr)));
            nbMesureValidation = length(currentLolimot.mesureValidationValue);
            if (nbMesureValidation > 0)
                disp(sprintf('Residu L1 sur les essais de validation = %f', listEvolutionResidu(nbPartition, intituleColonnes.ResL1Valid)));
            end
        end
    end % tant que l'on peut creer une nouvelle partition
    
    nbPartitionCreated = length(currentLolimot.listPartition);

    