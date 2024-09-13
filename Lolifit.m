function [ResfctLolimot, listEvolutionResidu, intituleColonnes] = lolifit( ...
                                XAppr,YAppr,XValid,YValid,sigma, nbDiscr, nbMaxPartition, ...
                                nameFacteurs, nameReponse,lectureEcriture, swDrawGraphics, ...
                                swTransfoRep, decalageTransfoRep, seuilTransfoRep)
% calcul des fonctions lolimot 
% si lectureEcriture = 0 : on recalcule et on n'écrit pas
% si lectureEcriture = 1 : on lit les partitions dans le fichier de nom 'reponse'.txt
% si lectureEcriture = 2 : on recalcule et on écrit les partitions dans le fichier de nom 'reponse'.txt
% Voici la transformation effectuée sur la réponse (si swTransfoRep == 1) :
%       F  : si x + decalageTransfoRep < seuilTransfoRep
%               x -> seuilTransfo * log ((x + decalageTransfoRep) / seuilTransfoRep)
%            sinon
%               x -> (x + decalageTransfoRep) - seuilTransfoRep
    
    global currentLolimot;
    
    if nargin < 11
        swDrawGraphics = 0;
    end
    if nargin < 12
        swTransfoRep = 0;
        decalageTransfoRep = 0.0;
        seuilTransfoRep = 0.0;
    end
    
    if nargin >= 12 & nargin ~= 14
        error(sprintf('lolifit(%s) : decalageTransfoRep et seuilTransfoRep doivent etre renseignes.', nameReponse));
    end

    nbEssaisAppr=size(XAppr,1);
    nbEssaisValid=size(XValid,1);
    nbEssaisTot = nbEssaisAppr + nbEssaisValid;
    nbfacteurs=size(XAppr,2);
    
    nameModele = sprintf('Modele %s', nameReponse);
    currentLolimot = LL_Lolimot(nameModele, swTransfoRep, decalageTransfoRep, seuilTransfoRep);
            
    dimMin=min(XAppr);
    dimMax=max(XAppr);
      
	
    % APPEL LOLIMOT
    % vecteur ecart type pour chaque facteurs
    ecartType = sigma * ones(1, nbfacteurs); 
    % vecteur nb de pas de discretisation selon chaque dimension
    nbDiscretisation = nbDiscr * ones(1, nbfacteurs);	
    % création de l'objet Lolimot
    currentLolimot = addDimension(currentLolimot, nameFacteurs, dimMin, dimMax, ecartType, nbDiscretisation);
   	currentLolimot = addMesure(currentLolimot, YAppr, XAppr);
   	% changer addMesureValidation en addMesure pour passer tous les essais
    if size(XValid, 1) > 0
        currentLolimot = addMesureValidation(currentLolimot, YValid, XValid);
    end

    
    % LECTURE/ECRITURE DANS UN FICHIER
    nameFile = sprintf('%s_%dsigma_%dpart', nameReponse, round(sigma * 100), nbDiscr);
    
    if lectureEcriture ==0 | lectureEcriture == 2
        [residu, nbPartitionCreated, listEvolutionResidu, intituleColonnes] = createDecoupage(currentLolimot, nbMaxPartition, -1000.0)
        fid = fopen('syntheseFonctionsLolimotEmissions.txt', 'a');
        residuAppr = listEvolutionResidu(nbPartitionCreated, 2);
        residuLValid = listEvolutionResidu(nbPartitionCreated, 6);
        fprintf(fid, '%s sigma = %f, nbDiscretisation = %d : apprentissage = %f --- validation = %f\n',nameReponse, sigma , nbDiscr, residuAppr, residuLValid);
        fclose(fid);        
        if lectureEcriture == 2
            writePartition(currentLolimot, strcat(nameFile,'.txt'));
        end
    else
        readPartition(currentLolimot, strcat(nameFile,'.txt'));
        listEvolutionResidu = [];
        intituleColonnes = [];
    end
    
    if swDrawGraphics
        drawEvolutionResidu(currentLolimot, listEvolutionResidu);
    end
  
%     % Sortie GRAPHIQUE
%     YModeleAppr = loliPredict(currentLolimot, XAppr);
%     YModeleValid = loliPredict(currentLolimot, XValid);
% %     YModeleAppr = zeros(nbEssaisAppr,1);
% %     YModeleValid = zeros(nbEssaisValid,1);
% %     for m = 1 : nbEssaisAppr
% %         % CalculeF est la fonction d'évaluation du modèle
% %         YModeleAppr(m) =  calculeF(currentLolimot, XAppr(m, :));
% %     end
% %     for m = 1 : nbEssaisValid
% %         % CalculeF est la fonction d'évaluation du modèle
% %         YModeleValid(m) =  calculeF(currentLolimot, XValid(m, :));
% %     end
%    
%           
%     R2Appr=1-(std(YModeleAppr-YAppr)/std(YAppr))^2;
%     R2Valid=1-(std(YModeleValid-YValid)/std(YValid))^2;
%    
%     TitreGraphique = sprintf('Modele %s, R2 Appr=%d, R2 Valid=%d', nameReponse,R2Appr,R2Valid);
%    
%     figure;
%     plot(YAppr,YModeleAppr,'b+');hold on;
%     plot(YValid,YModeleValid,'ro');hold on;
%     maxValue = max(max(YAppr), max(YValid));
%     minValue = min(min(YAppr), min(YValid));
%     plot([minValue maxValue], [minValue, maxValue], '-', 'LineWidth',1);
%     title(TitreGraphique);

    ResfctLolimot =currentLolimot;