function graphs_retrival2()
set(0,'DefaultAxesFontSize',16);
%====================================================

%====================================================
 figure;
PSNR=[0.49098	0.52812];

BER = [1,2];
p=bar(BER,PSNR);
title(['Average Recall value Comparison'],'Color','b');


ylabel('Average Recall Value (0-1)');

xlabel('DNAact-Ran              MFORD');


figure;
PSNR=[50.048	56.556];

BER = [1,2];
p=bar(BER,PSNR);
title(['Average Accuracy Percentage value Comparison'],'Color','b');


ylabel('Average Accuracy Percentage');

xlabel('DNAact-Ran              MFORD');

% hleg1 = legend('GAOF','FOGASD','TLGANN');
% set(hleg1,'Location','NorthEastOutside');
%==========================================================

figure;
b=[800 950 1100 1250 1400];
d=[0.7474 0.866 0.866 0.866 0.866];

p=plot(b,d);
set(p,'LineWidth',2);
hold all;
d=[0.9674 0.9811 0.9811 0.9811 0.9811];

p=plot(b,d);
set(p,'LineWidth',2);
title(['Precision Value Parameters Comparison'],'Color','b');


ylabel('Precision 0-1');

xlabel('Dataset Size');


hleg1 = legend('DNAact-Ran','MFORD');
set(hleg1,'Location','NorthEastOutside');



figure;
b=[800 950 1100 1250 1400];
d=[0.5203 0.7226 0.6645 0.6128 0.5682];

p=plot(b,d);
set(p,'LineWidth',2);
hold all;
d=[0.6163 0.7801 0.7219 0.6714 0.6261];

p=plot(b,d);
set(p,'LineWidth',2);
title(['F-Measure Value Parameters Comparison'],'Color','b');


ylabel('F-Measure 0-1');

xlabel('Dataset Size');


hleg1 = legend('DNAact-Ran','MFORD');
set(hleg1,'Location','NorthEastOutside');

end

