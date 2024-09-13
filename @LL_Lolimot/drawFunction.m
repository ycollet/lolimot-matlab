function drawFunction(this)
% LL_Lolimot::drawFunction :
% constructs graphics of the function only there are two dimensions

    nbPartition = getNbPartition(this);
    nbDimension = length(this.dimensionMin);
    
    if (nbDimension ~= 2)
        error('LL_Lolimot::drawFunction : there are not 2 dimensions in this Lolimot Function.');
    end

    figure;
    title('Partitions');
    hold on; % permet de dessiner chaque partition sur la meme figure
    
    % pour chaque partition
    for (p=1 : nbPartition)
        dimensionMin = getListDimensionMin(this.listPartition(p));
        dimensionMax = getListDimensionMax(this.listPartition(p));
        
        xrect = [dimensionMin(1), dimensionMin(1), dimensionMax(1), dimensionMax(1), dimensionMin(1)];
        yrect = [dimensionMin(2), dimensionMax(2), dimensionMax(2), dimensionMin(2), dimensionMin(2)];
        plot(xrect, yrect);
    end % pour chaque partition
    plot(this.mesureDimensionValue(:, 1), this.mesureDimensionValue(:, 2), 'ro');
    if (size(this.mesureValidationDimensionValue, 2) > 0)
        plot(this.mesureValidationDimensionValue(:, 1), this.mesureValidationDimensionValue(:, 2), 'bo');
    end

    
    X = zeros(100, 100);
    Y = zeros(100, 100);
    Z = zeros(100, 100);

    dimMin = this.dimensionMin(1);
    dimMax = this.dimensionMax(1);
    step = (dimMax - dimMin) / (100 - 1);
    for i = 1 : 100
        for j = 1 : 100
            X(i, j) = dimMin + (i - 1) * step;
        end;
    end;

    dimMin = this.dimensionMin(2);
    dimMax = this.dimensionMax(2);
    step = (dimMax - dimMin) / (100 - 1);
    for i = 1 : 100
        for j = 1 : 100
            Y(i, j) = dimMin + (j - 1) * step;
        end;
    end;

%     for i = 1 : 100
%         for j = 1 : 100
%             Z(i, j) = calculeF(this, [X(i, j), Y(i, j)]);
%         end;
%     end;

    tableau = reshape(X, [], 1);
    tableau(:, 2) = reshape(Y, [], 1);
    Ztableau = loliPredict(this, tableau);
    Z = reshape(Ztableau, size(X, 1), size(X, 2));

    figure;
    surf(X, Y, Z), hold on;
    title(this.name);
    colorbar;
    plot3(this.mesureDimensionValue(:, 1), this.mesureDimensionValue(:, 2), this.mesureValue, 'w*');
    if (size(this.mesureValidationDimensionValue, 2) > 0)
        plot3(this.mesureValidationDimensionValue(:, 1), this.mesureValidationDimensionValue(:, 2), this.mesureValidationValue, 'b*');
    end
    