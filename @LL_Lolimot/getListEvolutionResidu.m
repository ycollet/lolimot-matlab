function listEvolutionResidu = getListEvolutionResidu(this)
% LL_Lolimot::getListEvolutionResidu() : returns the history of differents
% residus at each new partition
%   listEvolutionResidu
%       listEvolutionResidu(i, 1) : valeur du r�sidu sur essais d'apprentissage avec i partitions
%       listEvolutionResidu(i, 2) : valeur du r�sidu norme L1 sur essais d'apprentissage avec i partitions
%       listEvolutionResidu(i, 3) : valeur du r�sidu norme L1 relatif sur essais d'apprentissage avec i partitions
%       listEvolutionResidu(i, 4) : valeur du r�sidu norme L2 sur essais d'apprentissage avec i partitions
%       listEvolutionResidu(i, 5) : valeur du r�sidu norme L1 sur essais de validation avec i partitions
%       listEvolutionResidu(i, 6) : valeur du r�sidu norme L1 relatif sur essais de validation avec i partitions
%       listEvolutionResidu(i, 7) : valeur du r�sidu norme L2 sur essais de validation avec i partitions
    listEvolutionResidu = this.listEvolutionResidu;
