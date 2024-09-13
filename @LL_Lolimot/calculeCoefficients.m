function [residu, partitionWithBiggestResidu] = calculeCoefficients(thisUnused, swComputeBiggestResidu, ...
                                    swUseIntermediateComputes, listPartitionToRecompute)
% LL_Lolimot::calculeCoefficients() :
% calcule les coefficients minimisant le residu :
% pour chaque partition p, on calcule :
%   coefficients de la partition p = inv(X' * Q(p) * X) * X'* Q(p) * Y
%   Avec
%   X = 1 X1(1) X2(1) ... Xn(1)   Valeur des mesures pour chaque dimension
%       1 X1(m) X2(m) ... Xn(m)   Matrice de taille n+1 * nbMesure
%       ...
%   Y =  Y(1)          Valeur de chaque mesure : vecteur de taille nbMesure
%        Y(m)
%        ...
%   Q(p) = (phi(p, x(1)) 0 0 0)            Matrice diagonale de taille nbMesure * nbMesure
%           0  ... phi(p, x(m)) ... 0)     contenant le phi(p, x) dans la diagonale

% si listPartitionToRecompute est passé, il représente la liste des
% partitions pour lesquelles on recalcule les coefficients
    global currentLolimot
    nbPartition = getNbPartition(currentLolimot);
    nbMesure = length(currentLolimot.mesureValue);
    nbDimension = length(currentLolimot.dimensionMin);

    if (nargin < 2)
        swComputeBiggestResidu = 0;
    end
    if (swComputeBiggestResidu)
        biggestPartitionResidu = 0;
    end
    
    if (nargin < 3)
        swUseIntermediateComputes = 0;
    end
        
    if (nargin < 4)
        listPartitionToRecompute = 1 : nbPartition;
    end

    % calcul des coefficients
    X = [ones(nbMesure, 1), currentLolimot.mesureDimensionValue];
    Y = currentLolimot.mesureValue;
	if currentLolimot.swTransfoRep
        Y = currentLolimot.mesureValueTransfo;
	end

    
    if (swUseIntermediateComputes == 0)
        % mise a jour des sigma :
        updateEcartType(currentLolimot);
    
%         matPhi = zeros(nbMesure, nbPartition);
%         for (m=1 : nbMesure)
%             matPhi(m, :) = calculePhi(currentLolimot, currentLolimot.mesureDimensionValue(m, :));
%         end
        
        matPhi = calculePhiPredict(currentLolimot, currentLolimot.mesureDimensionValue);
    else
%         matPhi = currentLolimot.intermediateZ;
%         for (m=1 : nbMesure)
%             matPhi(m, :) = matPhi(m, :) ./ sum(matPhi(m, :));
%         end
        
        % mise a jour des sigma :
        updateEcartType(currentLolimot);
        matPhi = calculePhiPredict(currentLolimot, currentLolimot.mesureDimensionValue);
    end

    % pour chaque partition a recalculer
    for (indp=1 : length(listPartitionToRecompute))
        p = listPartitionToRecompute(indp);
        % on pré-calcule X' * Q sans réellement construire Q :
        
%         for (m=1 : nbMesure)
%             XtQ(1 : nbDimension+1, m) = X(m, :)' .* matPhi(m, p);
%         end
        
        XtQ = X' .* (ones(nbDimension+1, 1) * matPhi(:, p)');
        
%        coefficients = inv(XtQ * X) * XtQ * Y;
        coefficients = (XtQ * X)\XtQ * Y;
        currentLolimot.listPartition(p) = setCoeff(currentLolimot.listPartition(p), ...
                                            coefficients(1), coefficients(2 : nbDimension+1));

        if (swComputeBiggestResidu)
            ecartEstimation = (coefficients' * XtQ)' - matPhi(:, p) .* Y;
            partitionResidu = sum(ecartEstimation .^ 2);
            if (partitionResidu > biggestPartitionResidu)
                biggestPartitionResidu = partitionResidu;
                partitionWithBiggestResidu = p;
            end
        end

%         % test d'utilisation de lscov plutot que l'inversion de matrice
%         Q = zeros(nbMesure, nbMesure);
%         for (m=1 : nbMesure)
%             Q(m, m) = 1 / matPhi(m, p);
%         end
%         [coefficients, dx] = lscov(X, Y, Q);
    end % pour chaque partition a recalculer
    
    % calcul du residu
    residu = 0.0;
    if (swUseIntermediateComputes == 0)
%         for (m=1 : nbMesure)
%             f = calculeF(currentLolimot, currentLolimot.mesureDimensionValue(m, :), matPhi(m, :));
%             residu = residu + (f - Y(m))^2;
%         end
        f = loliPredict(currentLolimot, currentLolimot.mesureDimensionValue, matPhi);
        residu = sum((f - Y) .^2);
    else
%         % pour chaque partition a recalculer
%         for (indp=1 : length(listPartitionToRecompute))
%             p = listPartitionToRecompute(indp);
%             for (m=1 : nbMesure)
%                 currentLolimot.intermediateF(m, p) = calculeValeurSelonRegression(currentLolimot.listPartition(p), ...
%                                                         currentLolimot.mesureDimensionValue(m, :));
%             end
%         end % pour chaque partition a recalculer
%         for (m=1 : nbMesure)
%             f = sum(currentLolimot.intermediateF(m, :) .* matPhi(m, :));
%             residu = residu + (f - Y(m))^2;
%         end
%         end
        
        f = loliPredict(currentLolimot, currentLolimot.mesureDimensionValue);
        residu = sum((f - Y) .^2);
    end

