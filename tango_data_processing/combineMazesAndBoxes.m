% Load saved figures
c=hgload('02 mazes.fig');
k=hgload('02 boxes.fig');
% Prepare subplots
figure
h(1)=subplot(2,1,1);
h(2)=subplot(2,1,2);
% Paste figures on the subplots
copyobj(allchild(get(c,'CurrentAxes')),h(1));
copyobj(allchild(get(k,'CurrentAxes')),h(2));