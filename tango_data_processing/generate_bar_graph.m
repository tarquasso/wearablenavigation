clear all
close all
% dropbox folder location
dropboxPath = '~/Dropbox (MIT)/Robotics Research/haptic devices/Experiments/study may 2016/';
% dropboxPath = '/Users/brandonaraki_backup/Dropbox (MIT)/haptic devices/Experiments/study may 2016/';
filename = 'data-analysis-blind-users-20160524_with_tango.mat';

matFileToOpen = strcat(dropboxPath,filename);
load(matFileToOpen);

% file of interest is data, dataheader
taskColName = 'task_';


[~,taskCol,idV] = find(strcmp(dataheader,taskColName));

datacompiled = struct();

for ii = 1:4
mazeName = ['mz' num2str(ii)];
[mzRows,~,mzRV] = find(strcmp(data(:,taskCol),mazeName));
datacompiled.maze.times{ii} = data(mzRows,20);
boxName = ['bx' num2str(ii)];
[bxRows,~,bxRV] = find(strcmp(data(:,taskCol),boxName));
datacompiled.box.times{ii} = data(bxRows,20);

end