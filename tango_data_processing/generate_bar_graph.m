clear all
close all
% dropbox folder location
dropboxPath = '~/Dropbox (MIT)/Robotics Research/haptic devices/Experiments/study may 2016/';
% dropboxPath = '/Users/brandonaraki_backup/Dropbox (MIT)/haptic devices/Experiments/study may 2016/';
filename = 'data-analysis-blind-users-20160524_with_tango.mat';

matFileToOpen = strcat(dropboxPath,filename);
load(matFileToOpen);

% file of interest is data, dataheader
deviceColName = 'device';
[~,deviceCol,~] = find(strcmp(dataheader,deviceColName));

taskColName = 'task_';
[~,taskCol,~] = find(strcmp(dataheader,taskColName));
[~,vidDurCol,~] = find(strcmp(dataheader,'VideoDuration_s_'));
[~,totTimCol,~] = find(strcmp(dataheader,'total_time'));
[~,aveVelCol,~] = find(strcmp(dataheader,'ave_velocity'));

[~,wallTapsCol,~] = find(strcmp(dataheader,'WallTaps'));
[~,majCollCol,~] = find(strcmp(dataheader,'x_MajorCollision_boxOrIntoWall_'));

datacompiled = struct();

for ii = 1:4
[caneRows,~,~] = find(strcmp(data(:,deviceCol),'cane'));

mazeName = ['mz' num2str(ii)];
[mzCaneRows,~,~] = find(strcmp(data(caneRows,taskCol),mazeName));
datacompiled.cane.maze{ii}.durationVideo = cell2mat(data(mzCaneRows,vidDurCol));
datacompiled.cane.maze{ii}.durationTango = cell2mat(data(mzCaneRows,totTimCol));

figure(ii)
plot(datacompiled.cane.maze{ii}.durationVideo)
hold on
plot(datacompiled.cane.maze{ii}.durationTango,'-.')

title(['cane ' ,mazeName])

datacompiled.cane.maze{ii}.averageVelocity = data(mzCaneRows,aveVelCol);
datacompiled.cane.maze{ii}.wallTaps = data(mzCaneRows,wallTapsCol);

[beltRows,~,~] = find(strcmp(data(:,deviceCol),'belt'));
[mzBeltRows,~,~] = find(strcmp(data(beltRows,taskCol),mazeName));
datacompiled.belt.maze{ii}.durationVideo = cell2mat(data(mzBeltRows,vidDurCol));
datacompiled.belt.maze{ii}.durationTango = cell2mat(data(mzBeltRows,totTimCol));
datacompiled.belt.maze{ii}.averageVelocity = data(mzBeltRows,aveVelCol);
datacompiled.belt.maze{ii}.majorColl = data(mzCaneRows,majCollCol);

figure(4+ii)
plot(datacompiled.belt.maze{ii}.durationVideo)
hold on
plot(datacompiled.belt.maze{ii}.durationTango,'-.')

title(['belt ' ,mazeName])


boxName = ['bx' num2str(ii)];
[bxBeltRows,~,~] = find(strcmp(data(beltRows,taskCol),boxName));
datacompiled.belt.box{ii}.durationVideo = data(bxBeltRows,vidDurCol);
datacompiled.belt.box{ii}.durationTango = data(bxBeltRows,totTimCol);
datacompiled.belt.box{ii}.averageVelocity = data(bxBeltRows,aveVelCol);

datacompiled.belt.maze{ii}.majorColl = data(mzCaneRows,majCollCol);

end


% bar(x,y)
% hold on;
% h=errorbar(x,y,e,'c'); set(h,'linestyle','none')


fileOutCompiledData = 'data-analysis-blind-users-20160524_with_tango_compiled.mat';
filePathOutCompiledData = strcat(dropboxPath,fileOutCompiledData);
save(filePathOutCompiledData,'datacompiled');
