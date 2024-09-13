function this = LL_Lolimot(name, swTransfoRep, decalageTransfoRep, seuilTransfoRep)
% LL_Lolimot class constructor.
% Fields :
%   name
%   dimensionName
%   dimensionMin
%   dimensionMax
%   dimensionEcartType
%   dimensionNbDiscretisation
%   mesureValue
%   mesureDimensionValue
%   mesureValidationValue
%   mesureValidationDimensionValue
%   listPartition
%   swTransfoRep
%   decalageTransfoRep
%   seuilTransfoRep
%   mesureValueTransfo : stockage de mesureValue apres transformation
%       Voici la transformation effectuée sur la réponse :
%       F  : si x + decalageTransfoRep < seuilTransfoRep
%               x -> seuilTransfo * log ((x + decalageTransfoRep) / seuilTransfoRep)
%            sinon
%               x -> (x + decalageTransfoRep) - seuilTransfoRep


    this.name = name;

    this.residu = 0.0;
    this.initialResidu = 0.0;
    
    % fields for dimensions :
    this.dimensionName = {};
    this.dimensionMin = [];
    this.dimensionMax = [];
    this.dimensionEcartType = [];
    this.dimensionNbDiscretisation = [];

    % fields for mesures :
    this.mesureValue = [];
    this.mesureDimensionValue = [,];
    this.mesureValidationValue = [];
    this.mesureValidationDimensionValue = [,];
    
    % field for partitions :
    this.listPartition = [];

    this.intermediateZ = 0;
    this.intermediateF = 0;
    
    this.listEvolutionResidu = [];

    %  Parametres pour la transformation de la reponse
    if nargin == 1
        this.swTransfoRep = 0;
    else
        this.swTransfoRep = swTransfoRep;
        if swTransfoRep
            if nargin ~= 4
                error(sprintf('LL_Lolimot(%s) : il faut definir decalageTransfoRep et seuilTransfoRep', name));
            end
            this.decalageTransfoRep = decalageTransfoRep;
            this.seuilTransfoRep = seuilTransfoRep;
        end
    end
    if ~ this.swTransfoRep
        this.decalageTransfoRep = 0.0;
        this.seuilTransfoRep = 0.0;
    end
    this.mesureValueTransfo = [];
    
    this = class(this,'LL_Lolimot');

