NOMGS_50sigma_3part=dlmread('NOMGS_50sigma_3part_Histo.txt');
figure;
hold;
plot(NOMGS_50sigma_3part(:,1),NOMGS_50sigma_3part(:,3),'r-', 'LineWidth',1);
plot(NOMGS_50sigma_3part(:,1),NOMGS_50sigma_3part(:,4),'-', 'LineWidth',1);
title('NOMGS sigma=0.5 part=3');
open('NOMGS_50sigma_3part_Total.fig');
title('NOMGS sigma=0.5 part=3');

NOMGS_100sigma_4part=dlmread('NOMGS_100sigma_4part_Histo.txt');
figure;
hold;
plot(NOMGS_100sigma_4part(:,1),NOMGS_100sigma_4part(:,3),'r-', 'LineWidth',1);
plot(NOMGS_100sigma_4part(:,1),NOMGS_100sigma_4part(:,4),'-', 'LineWidth',1);
title('NOMGS sigma=1 part=4');
open('NOMGS_100sigma_4part_Total.fig');
title('NOMGS sigma=1 part=4');


NOMGS_50sigma_4part=dlmread('NOMGS_50sigma_4part_Histo.txt');
figure;
hold;
plot(NOMGS_50sigma_4part(:,1),NOMGS_50sigma_4part(:,3),'r-', 'LineWidth',1);
plot(NOMGS_50sigma_4part(:,1),NOMGS_50sigma_4part(:,4),'-', 'LineWidth',1);
title('NOMGS sigma=0.5 part=4');
open('NOMGS_50sigma_4part_Total.fig');
title('NOMGS sigma=0.5 part=4');

NOMGS_33sigma_4part=dlmread('NOMGS_33sigma_4part_Histo.txt');
figure;
hold;
plot(NOMGS_33sigma_4part(:,1),NOMGS_33sigma_4part(:,3),'r-', 'LineWidth',1);
plot(NOMGS_33sigma_4part(:,1),NOMGS_33sigma_4part(:,4),'-', 'LineWidth',1);
title('NOMGS sigma=0.33 part=4');
open('NOMGS_33sigma_4part_Total.fig');
title('NOMGS sigma=0.33 part=4');


IOFCL_33sigma_3part=dlmread('IOFCL_33sigma_3part_Histo.txt');
figure;
hold;
plot(IOFCL_33sigma_3part(:,1),IOFCL_33sigma_3part(:,3),'r-', 'LineWidth',1);
plot(IOFCL_33sigma_3part(:,1),IOFCL_33sigma_3part(:,4),'-', 'LineWidth',1);
title('IOFCL sigma=0.33 part=3');
open('IOFCL_33sigma_3part_Total.fig');
title('IOFCL sigma=0.33 part=3');

IOFCL_100sigma_4part=dlmread('IOFCL_100sigma_4part_Histo.txt');
figure;
hold;
plot(IOFCL_100sigma_4part(:,1),IOFCL_100sigma_4part(:,3),'r-', 'LineWidth',1);
plot(IOFCL_100sigma_4part(:,1),IOFCL_100sigma_4part(:,4),'-', 'LineWidth',1);
title('IOFCL sigma=1 part=4');
open('IOFCL_100sigma_4part_Total.fig');
title('IOFCL sigma=1 part=4');


IOFCL_50sigma_4part=dlmread('IOFCL_50sigma_4part_Histo.txt');
figure;
hold;
plot(IOFCL_50sigma_4part(:,1),IOFCL_50sigma_4part(:,3),'r-', 'LineWidth',1);
plot(IOFCL_50sigma_4part(:,1),IOFCL_50sigma_4part(:,4),'-', 'LineWidth',1);
title('IOFCL sigma=0.5 part=4');
open('IOFCL_50sigma_4part_Total.fig');
title('IOFCL sigma=0.5 part=4');

IOFCL_33sigma_4part=dlmread('IOFCL_33sigma_4part_Histo.txt');
figure;
hold;
plot(IOFCL_33sigma_4part(:,1),IOFCL_33sigma_4part(:,3),'r-', 'LineWidth',1);
plot(IOFCL_33sigma_4part(:,1),IOFCL_33sigma_4part(:,4),'-', 'LineWidth',1);
title('IOFCL sigma=0.33 part=4');
open('IOFCL_33sigma_4part_Total.fig');
title('IOFCL sigma=0.33 part=4');
