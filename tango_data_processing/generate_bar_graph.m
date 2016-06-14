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

% set up the compiled data
dc = struct();

for ii = 1:4
mazeName = ['mz' num2str(ii)];

%CANE MAZE

containsThisMaze = strcmp(data(:,taskCol),mazeName);
[mzCaneRows,~,~] = find( containsCane & containsThisMaze);
dc.cane.maze{ii}.id = cell2mat(data(mzCaneRows,idCol));
dc.cane.maze{ii}.durationVideo.raw = cell2mat(data(mzCaneRows,vidDurCol));
dc.cane.maze{ii}.durationTango.raw = cell2mat(data(mzCaneRows,totTimCol));

figure(ii)
plot(dc.cane.maze{ii}.id,dc.cane.maze{ii}.durationVideo.raw,'*')
hold on
plot(dc.cane.maze{ii}.id,dc.cane.maze{ii}.durationTango.raw,'o')
legend('duration video','duration tango');

title(['cane ' ,mazeName])
dc.cane.maze{ii}.averageVelocity.raw = cell2mat(data(mzCaneRows,aveVelCol));
dc.cane.maze{ii}.wallTaps.raw = cell2mat(data(mzCaneRows,wallTapsCol));

% Calculate averages and stds
dc.cane.maze{ii}.durationVideo.mean = mean(dc.cane.maze{ii}.durationVideo.raw);
dc.cane.maze{ii}.durationVideo.std = std(dc.cane.maze{ii}.durationVideo.raw);
dc.cane.maze{ii}.durationTango.mean = mean(dc.cane.maze{ii}.durationTango.raw);
dc.cane.maze{ii}.durationTango.std = std(dc.cane.maze{ii}.durationTango.raw);
dc.cane.maze{ii}.wallTaps.mean = mean(dc.cane.maze{ii}.wallTaps.raw);
dc.cane.maze{ii}.wallTaps.std = std(dc.cane.maze{ii}.wallTaps.raw);

%BELT MAZE

[mzBeltRows,~,~] = find( containsBelt & containsThisMaze);
dc.belt.maze{ii}.id = cell2mat(data(mzBeltRows,idCol));

dc.belt.maze{ii}.durationVideo.raw = cell2mat(data(mzBeltRows,vidDurCol));
dc.belt.maze{ii}.durationTango.raw = cell2mat(data(mzBeltRows,totTimCol));
dc.belt.maze{ii}.averageVelocity.raw = cell2mat(data(mzBeltRows,aveVelCol));
dc.belt.maze{ii}.majorColl.raw = cell2mat(data(mzBeltRows,majCollCol));

figure(4+ii)
plot(dc.belt.maze{ii}.id,dc.belt.maze{ii}.durationVideo.raw,'*')
hold on
plot(dc.belt.maze{ii}.id,dc.belt.maze{ii}.durationTango.raw,'o')
legend('duration video','duration tango');
title(['belt ' ,mazeName])

% Calculate averages and stds
dc.belt.maze{ii}.durationVideo.mean = mean(dc.belt.maze{ii}.durationVideo.raw);
dc.belt.maze{ii}.durationVideo.std = std(dc.belt.maze{ii}.durationVideo.raw);
dc.belt.maze{ii}.durationTango.mean = mean(dc.belt.maze{ii}.durationTango.raw);
dc.belt.maze{ii}.durationTango.std = std(dc.belt.maze{ii}.durationTango.raw);
dc.belt.maze{ii}.majorColl.mean = mean(dc.belt.maze{ii}.majorColl.raw);
dc.belt.maze{ii}.majorColl.std = std(dc.belt.maze{ii}.majorColl.raw);

%BELT BOX

boxName = ['bx' num2str(ii)];
containsThisBox = strcmp(data(:,taskCol),boxName);

[bxBeltRows,~,~] = find( containsBelt & containsThisBox);
dc.belt.box{ii}.durationVideo.raw = data(bxBeltRows,vidDurCol);
dc.belt.box{ii}.durationTango.raw = data(bxBeltRows,totTimCol);
dc.belt.box{ii}.averageVelocity.raw = data(bxBeltRows,aveVelCol);

dc.belt.box{ii}.majorColl.raw = data(mzCaneRows,majCollCol);

end

%% First Bar Graph
figure(10)
specs = {};
numOfMazes = 4;
for ii = 1:numOfMazes
barh((numOfMazes-ii)*5+4,dc.belt.maze{ii}.durationVideo.mean,'FaceColor',hsv2rgb([0 1 1]),'EdgeColor',hsv2rgb([0 1 1]),'LineWidth',1.5);
hold on;
barh((numOfMazes-ii)*5+3,dc.belt.maze{ii}.majorColl.mean,'FaceColor',hsv2rgb([0.3 1 1]),'EdgeColor',hsv2rgb([0.3 1 1]),'LineWidth',1.5);
barh((numOfMazes-ii)*5+2,dc.cane.maze{ii}.durationVideo.mean,'FaceColor',hsv2rgb([0 0.4 1]),'EdgeColor',hsv2rgb([0 0.4 1]),'LineWidth',1.5);
barh((numOfMazes-ii)*5+1,dc.cane.maze{ii}.wallTaps.mean,'FaceColor',hsv2rgb([0.3 0.2 1]),'EdgeColor',hsv2rgb([0.3 0.2 1]),'LineWidth',1.5);
specs = horzcat(specs,' ',['Belt Duration HW' num2str(ii)],['Belt Major Collisions HW' num2str(ii)],['Cane Duration HW' num2str(ii)],['Cane Wall Taps HW' num2str(ii)]);

%h=errorbar(x,y,e,'c'); set(h,'linestyle','none')
end

set(gca,'Ytick',1:numOfMazes*5+numOfMazes,'YTickLabel',specs(end:-1:1))


%% Second Bar Graph
figure(11)
specs = {};
numOfMazes = 4;
for ii = 1:numOfMazes
bar((ii-1)*5+1,dc.belt.maze{ii}.durationVideo.mean,'FaceColor',hsv2rgb([0 1 1.0]),'EdgeColor',hsv2rgb([0 1 1]),'LineWidth',1.5);
hold on;
errorbar((ii-1)*5+1,dc.belt.maze{ii}.durationVideo.mean,dc.belt.maze{ii}.durationVideo.std,'LineWidth',1.5,'Color',hsv2rgb([0 1 0.6]),'linestyle','none'); 

bar((ii-1)*5+2,dc.belt.maze{ii}.majorColl.mean,'FaceColor',hsv2rgb([0.3 1 1]),'EdgeColor',hsv2rgb([0.3 1 1]),'LineWidth',1.5);
errorbar((ii-1)*5+2,dc.belt.maze{ii}.majorColl.mean,dc.belt.maze{ii}.majorColl.std,'LineWidth',1.5,'Color',hsv2rgb([0.3 1 0.6]),'linestyle','none'); 

bar((ii-1)*5+3,dc.cane.maze{ii}.durationVideo.mean,'FaceColor',hsv2rgb([0 0.4 1]),'EdgeColor',hsv2rgb([0 0.4 1]),'LineWidth',1.5);
errorbar((ii-1)*5+3,dc.cane.maze{ii}.durationVideo.mean,dc.cane.maze{ii}.durationVideo.std,'LineWidth',1.5,'Color',hsv2rgb([0 1 0.6]),'linestyle','none'); 

bar((ii-1)*5+4,dc.cane.maze{ii}.wallTaps.mean,'FaceColor',hsv2rgb([0.3 0.2 1]),'EdgeColor',hsv2rgb([0.3 0.2 1]),'LineWidth',1.5);
errorbar((ii-1)*5+4,dc.cane.maze{ii}.wallTaps.mean,dc.cane.maze{ii}.wallTaps.std,'LineWidth',1.5,'Color',hsv2rgb([0.3 1 0.6]),'linestyle','none'); 

specs = horzcat(specs,['Belt Duration HW' num2str(ii)],['Belt Major Collisions HW' num2str(ii)],['Cane Duration HW' num2str(ii)],['Cane Wall Taps HW' num2str(ii)],' ');

ylim([-3 inf]) % or your lower limit.


end

set(gca,'Xtick',1:numOfMazes*5+numOfMazes,'XTickLabel',specs,'XTickLabelRotation',60)




fileOutCompiledData = 'data-analysis-blind-users-20160524_with_tango_compiled.mat';
filePathOutCompiledData = strcat(dropboxPath,fileOutCompiledData);
save(filePathOutCompiledData,'dc');
