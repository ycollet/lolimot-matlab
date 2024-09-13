function [residu, partitionWithBiggestResidu] = addTheBestPartition(thisUnused, partitionWithBiggestResidu, percentageResiduToStop)
% LL_Lolimot::addTheBestPartition() :
% ajoute la partition permettant de reduire au maximum le residu global
    global currentLolimot

    swCalculSioux = 1;
    
    nbPartition = getNbPartition(currentLolimot);
    nbDimension = length(currentLolimot.dimensionMin);
    nbMesure = length(currentLolimot.mesureValue);
    
    dimensionMinPartitionADecouper = getListDimensionMin(currentLolimot.listPartition(partitionWithBiggestResidu));
    dimensionMaxPartitionADecouper = getListDimensionMax(currentLolimot.listPartition(partitionWithBiggestResidu));
    % on cree la nouvelle partition (copie de la partition a decouper)
    addPartition(currentLolimot, LL_Partition(dimensionMinPartitionADecouper, dimensionMaxPartitionADecouper));

    precResidu = currentLolimot.residu;
    bestResidu = 1e+12;

    % pour chaque dimension
    for (d = 1 : nbDimension)
        nbSeparation = currentLolimot.dimensionNbDiscretisation(d);
        stepSeparation = (dimensionMaxPartitionADecouper(d) - dimensionMinPartitionADecouper(d)) / (nbSeparation + 1);
        
        % pour chaque separation possible
        for (s = 1 : nbSeparation)
	        valeurSeparation = dimensionMinPartitionADecouper(d) + s * stepSeparation;
            
            % on modifie les valeurs des 2 partitions
            currentLolimot.listPartition(partitionWithBiggestResidu) = setDimensionMax( ...
                                    currentLolimot.listPartition(partitionWithBiggestResidu), d, valeurSeparation);
            currentLolimot.listPartition(nbPartition+1) = setDimensionMin( ...
                                    currentLolimot.listPartition(nbPartition+1), d, valeurSeparation);

            if ~ swCalculSioux
                % on evalue ce partitionnement
                residu = calculeCoefficients(currentLolimot);
            else % si calcul sioux
                % mise a jour des sigma :
                updateEcartType(currentLolimot);
%                 for (m=1 : nbMesure)
%                     currentLolimot.intermediateZ(m, partitionWithBiggestResidu) = ...
%                                 calculeZ(currentLolimot.listPartition(partitionWithBiggestResidu), currentLolimot.mesureDimensionValue(m, :));
%                     currentLolimot.intermediateZ(m, nbPartition+1) = ...
%                                 calculeZ(currentLolimot.listPartition(nbPartition+1), currentLolimot.mesureDimensionValue(m, :));
%                 end
%                 currentLolimot.intermediateZ
%                 % on evalue ce partitionnement
%                 residu = calculeCoefficients(currentLolimot, 0, 1, [partitionWithBiggestResidu, nbPartition+1]);
%                residu = calculeCoefficients(currentLolimot, 0, 1);

                residu = calculeCoefficients(currentLolimot, 0, 0, [partitionWithBiggestResidu, nbPartition+1]);
            end % si calcul sioux
            
            % si le residu est plus interessant que la meilleure solution trouvee jusqu'alors
	        if (residu < bestResidu)
                bestResidu = residu;
                bestDimension = d;
                bestValeurSeparation = valeurSeparation;
            end
        end % pour chaque separation possible
        
        % on restaure les valeurs des 2 partitions
        currentLolimot.listPartition(partitionWithBiggestResidu) = setDimensionMax( ...
                                currentLolimot.listPartition(partitionWithBiggestResidu), d, dimensionMaxPartitionADecouper(d));
        currentLolimot.listPartition(nbPartition+1) = setDimensionMin( ...
                                currentLolimot.listPartition(nbPartition+1), d, dimensionMinPartitionADecouper(d));
    end % pour chaque dimension
    
    % Modification le 09/10/2003 
    % test d'arret sur le pourcentage de gain par rapport au residu initial
	if (((precResidu - bestResidu) / currentLolimot.initialResidu) < percentageResiduToStop)
		delLastPartition(currentLolimot);
		calculeCoefficients(currentLolimot);
		residu = -1;
		return
	end

    % on met a jour la nouvelle partition
    currentLolimot.listPartition(partitionWithBiggestResidu) = setDimensionMax( ...
                            currentLolimot.listPartition(partitionWithBiggestResidu), bestDimension, bestValeurSeparation);
    currentLolimot.listPartition(nbPartition+1) = setDimensionMin( ...
                            currentLolimot.listPartition(nbPartition+1), bestDimension, bestValeurSeparation);

    if ~ swCalculSioux
        % on re-evalue ce partitionnement
        [residu, partitionWithBiggestResidu] = calculeCoefficients(currentLolimot, 1);
    else % si calcul sioux
        updateEcartType(currentLolimot);
%         for (m=1 : nbMesure)
%             currentLolimot.intermediateZ(m, partitionWithBiggestResidu) = ...
%                     calculeZ(currentLolimot.listPartition(partitionWithBiggestResidu), currentLolimot.mesureDimensionValue(m, :));
%             currentLolimot.intermediateZ(m, nbPartition+1) = ...
%                     calculeZ(currentLolimot.listPartition(nbPartition+1), currentLolimot.mesureDimensionValue(m, :));
%         end
%     
%         % on re-evalue ce partitionnement : on recalcule pour toutes les
%         % partitions pour se bien se remettre a plat (LPJ le 30/07/03 :
%         % sinon on stagne assez vite ...)
%         [residu, partitionWithBiggestResidu] = calculeCoefficients(currentLolimot, 1, 1);
        [residu, partitionWithBiggestResidu] = calculeCoefficients(currentLolimot, 1, 0);
    end % si calcul sioux
    
    % test de controle : on doit avoir residu == bestResidu !!
%    if (abs(residu - bestResidu) > 1e-4)
%        error('LL_Lolimot::addTheBestPartition : incoherence de valeur de residu !!!');
%    end
    currentLolimot.residu = residu;

    % affichage du decoupage actuel
    disp('----------------------------------');
    currentLolimot
    disp(sprintf('Pourcentage d''amélioration du residu  = %f', ((precResidu - bestResidu) / currentLolimot.initialResidu)));
    