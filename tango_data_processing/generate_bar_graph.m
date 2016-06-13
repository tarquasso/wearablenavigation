clear all
close all

% dropbox folder location
% FILL IN YOUR computer username here:
editorNames = {'rkk', 'brandonaraki'};

dropboxPathOptions = {'~/Dropbox (MIT)/Robotics Research/haptic devices/Experiments/study may 2016/',...
    '/Users/brandonaraki_backup/Dropbox (MIT)/haptic devices/Experiments/study may 2016/'};

osUserName = char(java.lang.System.getProperty('user.name'));

for k = 1:length(editorNames)
    curName = editorNames{k};
  if strcmp (osUserName,curName)
      dropboxPath = dropboxPathOptions{k};
  end
end

filename = 'data-analysis-blind-users-20160524_with_tango.mat';

matFileToOpen = strcat(dropboxPath,filename);
load(matFileToOpen);


% file of interest is data, dataheader

[~,usefulCol,~] = find(strcmp(dataheader,'useful'));

[~,idCol,~] = find(strcmp(dataheader,'id'));

[~,deviceCol,~] = find(strcmp(dataheader,'device'));

containsUsefulData = cell2mat(data(:,usefulCol));

containsCane = strcmp(data(:,deviceCol),'cane') & containsUsefulData;
containsBelt = strcmp(data(:,deviceCol),'belt') & containsUsefulData;


[~,taskCol,~] = find(strcmp(dataheader,'task_'));
[~,vidDurCol,~] = find(strcmp(dataheader,'VideoDuration_s_'));
[~,totTimCol,~] = find(strcmp(dataheader,'total_time'));
[~,aveVelCol,~] = find(strcmp(dataheader,'ave_velocity'));

[~,wallTapsCol,~] = find(strcmp(dataheader,'WallTaps'));
[~,majCollCol,~] = find(strcmp(dataheader,'x_MajorCollision_boxOrIntoWall_'));

datacompiled = struct();



for ii = 1:4
mazeName = ['mz' num2str(ii)];

containsThisMaze = strcmp(data(:,taskCol),mazeName);
[mzCaneRows,~,~] = find( containsCane & containsThisMaze);
datacompiled.cane.maze{ii}.id = cell2mat(data(mzCaneRows,idCol));
datacompiled.cane.maze{ii}.durationVideo = cell2mat(data(mzCaneRows,vidDurCol));
datacompiled.cane.maze{ii}.durationTango = cell2mat(data(mzCaneRows,totTimCol));

figure(ii)
plot(datacompiled.cane.maze{ii}.id,datacompiled.cane.maze{ii}.durationVideo,'*')
hold on
plot(datacompiled.cane.maze{ii}.id,datacompiled.cane.maze{ii}.durationTango,'o')
legend('duration video','duration tango');

title(['cane ' ,mazeName])
datacompiled.cane.maze{ii}.averageVelocity = cell2mat(data(mzCaneRows,aveVelCol));
datacompiled.cane.maze{ii}.wallTaps = cell2mat(data(mzCaneRows,wallTapsCol));

%BELT MAZE

[mzBeltRows,~,~] = find( containsBelt & containsThisMaze);
datacompiled.belt.maze{ii}.id = cell2mat(data(mzBeltRows,idCol));

datacompiled.belt.maze{ii}.durationVideo = cell2mat(data(mzBeltRows,vidDurCol));
datacompiled.belt.maze{ii}.durationTango = cell2mat(data(mzBeltRows,totTimCol));
datacompiled.belt.maze{ii}.averageVelocity = cell2mat(data(mzBeltRows,aveVelCol));
datacompiled.belt.maze{ii}.majorColl = cell2mat(data(mzBeltRows,majCollCol));

figure(4+ii)
plot(datacompiled.belt.maze{ii}.id,datacompiled.belt.maze{ii}.durationVideo,'*')
hold on
plot(datacompiled.belt.maze{ii}.id,datacompiled.belt.maze{ii}.durationTango,'o')
legend('duration video','duration tango');
title(['belt ' ,mazeName])


boxName = ['bx' num2str(ii)];
containsThisBox = strcmp(data(:,taskCol),boxName);

[bxBeltRows,~,~] = find( containsBelt & containsThisBox);
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
