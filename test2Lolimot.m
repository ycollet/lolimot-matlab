cd ('c:\dev\sonia\proto matlab\log');
diary ('output.txt');
clear;

fid = fopen('synthese.txt', 'w');
fclose (fid);       


 
% Variation pour reponse C2MGS
vSigma = [1 0.5 0.33 0.16];
vNbDiscr = [1 2 3 4 5 6 ];

for d = 1: length(vNbDiscr);
    for s = 1 : length(vSigma)
%        fid = fopen('synthese.txt', 'a');
        lancementModeleGlobal(vSigma(1,s), vNbDiscr(1,d), 30,'NOMGS');
%        fclose(fid);
    end
end

% Variation pour reponse NOISE
vSigma = [1 0.5 0.33 0.16];
vNbDiscr = [1 2 3 4 5 6 ];

for s = 1 : length(vSigma)
    for d = 1: length(vNbDiscr);
%        fid = fopen('synthese.txt', 'a');
        lancementModeleGlobal(vSigma(1,s), vNbDiscr(1,d), 60,'NOISE');
%        fclose(fid); 
    end
end

% Variation pour reponse QEMGC
vSigma = [1 0.5 0.33 0.16];
vNbDiscr = [1 2 3 4 5 6 ];

for s = 1 : length(vSigma)
    for d = 1: length(vNbDiscr);
%        fid = fopen('synthese.txt', 'a');
        lancementModeleGlobal(vSigma(1,s), vNbDiscr(1,d), 30,'QEMGC');
%        fclose(fid);
    end
end


diary('off'); 
