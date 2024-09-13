function drawEvolutionResidu(this, listEvolutionResidu)
% LL_Lolimot::drawEvolutionResidu :
% constructs graphics of the history of differents
% residus at each new partition

    [residus, intituleColonnes] = calculeResidus(this);

    if nargin == 1
        listEvolutionResidu = []
    end
    if size(listEvolutionResidu, 1) > 0
        nbPartition = size(listEvolutionResidu, 1);
        figure; hold on;
        title(sprintf('%s : residu optim', getName(this)));
        plot(1 : nbPartition, listEvolutionResidu(:, intituleColonnes.ResOptim), 'b-');
	
        figure; hold on;
        title(sprintf('%s : residu norme L1 (bleu : apprentissage ; rouge : validation)', getName(this)));
        plot(1 : nbPartition, listEvolutionResidu(:, intituleColonnes.ResL1Appr), 'b-');
        plot(1 : nbPartition, listEvolutionResidu(:, intituleColonnes.ResL1Valid), 'r-');
	
        figure; hold on;
        title(sprintf('%s : residu norme L1 relatif (bleu : apprentissage ; rouge : validation)', getName(this)));
        plot(1 : nbPartition, listEvolutionResidu(:, intituleColonnes.ResL1RelatifAppr), 'b-');
        plot(1 : nbPartition, listEvolutionResidu(:, intituleColonnes.ResL1RelatifValid), 'r-');
	
        figure; hold on;
        title(sprintf('%s : residu norme L2 (bleu : apprentissage ; rouge : validation)', getName(this)));
        plot(1 : nbPartition, listEvolutionResidu(:, intituleColonnes.ResL2Appr), 'b-');
        plot(1 : nbPartition, listEvolutionResidu(:, intituleColonnes.ResL2Valid), 'r-');
	
        figure; hold on;
        title(sprintf('%s : residu norme L infini (bleu : apprentissage ; rouge : validation)', getName(this)));
        plot(1 : nbPartition, listEvolutionResidu(:, intituleColonnes.ResLInfiniAppr), 'b-');
        plot(1 : nbPartition, listEvolutionResidu(:, intituleColonnes.ResLInfiniValid), 'r-');
	
        figure; hold on;
        title(sprintf('%s : residu R2 (bleu : apprentissage ; rouge : validation)', getName(this)));
        plot(1 : nbPartition, listEvolutionResidu(:, intituleColonnes.ResR2Appr), 'b-');
        plot(1 : nbPartition, listEvolutionResidu(:, intituleColonnes.ResR2Valid), 'r-');
    end
    
    figure; hold on;
    title(sprintf('%s, R2 Appr=%d, R2 Valid=%d', getName(this), residus(intituleColonnes.ResR2Appr), residus(intituleColonnes.ResR2Valid)));
%     title(sprintf('%s : répartition des points valeur-estimation (bleu : apprentissage ; rouge : validation)', getName(this)));
    estim = loliPredict(this, this.mesureDimensionValue);
    plot(this.mesureValue, estim, 'b+');
    smallest = min(this.mesureValue);
    biggest = max(this.mesureValue);
    if size(this.mesureValidationValue, 1) > 0
        estim = loliPredict(this, this.mesureValidationDimensionValue);
        plot(this.mesureValidationValue, estim, 'ro');
        smallest = min(min(this.mesureValidationValue), smallest);
        biggest = max(max(this.mesureValidationValue), biggest);
    end
    plot([smallest biggest], [smallest biggest], 'b-');
    