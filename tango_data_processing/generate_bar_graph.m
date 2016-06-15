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
containsUsefulData = cell2mat(data(:,usefulCol));

[~,tangoOkCol,~] = find(strcmp(dataheader,'tangoOk'));
containsTangoOkData = cell2mat(data(:,tangoOkCol));

containsUsefulData = containsUsefulData & containsTangoOkData;

[~,idCol,~] = find(strcmp(dataheader,'id'));

[~,deviceCol,~] = find(strcmp(dataheader,'device'));

containsCane = strcmp(data(:,deviceCol),'cane') & containsUsefulData;
containsBelt = strcmp(data(:,deviceCol),'belt') & containsUsefulData;


[~,taskCol,~] = find(strcmp(dataheader,'task_'));
[~,vidDurCol,~] = find(strcmp(dataheader,'VideoDuration_s_'));
[~,totTimCol,~] = find(strcmp(dataheader,'total_time'));
[~,aveVelCol,~] = find(strcmp(dataheader,'ave_velocity'));

[~,wallTapsCol,~] = find(strcmp(dataheader,'WallTaps'));
[~,majCollCol,~] = find(strcmp(dataheader,'x_MajorCollision_boxOrIntoWall_'));
[~,distCol,~] = find(strcmp(dataheader,'distance'));

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
dc.cane.maze{ii}.averageVelocity.raw = cell2mat(data(mzCaneRows,aveVelCol));
dc.cane.maze{ii}.wallTaps.raw = cell2mat(data(mzCaneRows,wallTapsCol));
dc.cane.maze{ii}.distance.raw = cell2mat(data(mzCaneRows,distCol));

figure(ii)
plot(dc.cane.maze{ii}.id,dc.cane.maze{ii}.durationVideo.raw,'*')
hold on
plot(dc.cane.maze{ii}.id,dc.cane.maze{ii}.durationTango.raw,'o')
legend('duration video','duration tango');

title(['cane ' ,mazeName])


% Calculate averages and stds
dc.cane.maze{ii}.durationVideo.mean = mean(dc.cane.maze{ii}.durationVideo.raw);
dc.cane.maze{ii}.durationVideo.std = std(dc.cane.maze{ii}.durationVideo.raw);
dc.cane.maze{ii}.durationTango.mean = mean(dc.cane.maze{ii}.durationTango.raw);
dc.cane.maze{ii}.durationTango.std = std(dc.cane.maze{ii}.durationTango.raw);
dc.cane.maze{ii}.wallTaps.mean = mean(dc.cane.maze{ii}.wallTaps.raw);
dc.cane.maze{ii}.wallTaps.std = std(dc.cane.maze{ii}.wallTaps.raw);

dc.cane.maze{ii}.wallTaps.min = min(dc.cane.maze{ii}.wallTaps.raw);
dc.cane.maze{ii}.wallTaps.deltaLow = dc.cane.maze{ii}.wallTaps.mean - dc.cane.maze{ii}.wallTaps.min;
dc.cane.maze{ii}.wallTaps.max = max(dc.cane.maze{ii}.wallTaps.raw);
dc.cane.maze{ii}.wallTaps.deltaHigh = dc.cane.maze{ii}.wallTaps.max - dc.cane.maze{ii}.wallTaps.mean;
dc.cane.maze{ii}.distance.mean = mean(dc.cane.maze{ii}.distance.raw);
dc.cane.maze{ii}.distance.std = std(dc.cane.maze{ii}.distance.raw);

%BELT MAZE

[mzBeltRows,~,~] = find( containsBelt & containsThisMaze);
dc.belt.maze{ii}.id = cell2mat(data(mzBeltRows,idCol));

dc.belt.maze{ii}.durationVideo.raw = cell2mat(data(mzBeltRows,vidDurCol));
dc.belt.maze{ii}.durationTango.raw = cell2mat(data(mzBeltRows,totTimCol));
dc.belt.maze{ii}.averageVelocity.raw = cell2mat(data(mzBeltRows,aveVelCol));
dc.belt.maze{ii}.majorColl.raw = cell2mat(data(mzBeltRows,majCollCol));
dc.belt.maze{ii}.distance.raw = cell2mat(data(mzBeltRows,distCol));


figure(4+ii)
plot(dc.belt.maze{ii}.id,dc.belt.maze{ii}.durationVideo.raw,'*')
hold on
plot(dc.belt.maze{ii}.id,dc.belt.maze{ii}.durationTango.raw,'o')
legend('duration video','duration tango');
title(['belt ' ,mazeName])

% Calculate averages and stds and mins and max
dc.belt.maze{ii}.durationVideo.mean = mean(dc.belt.maze{ii}.durationVideo.raw);
dc.belt.maze{ii}.durationVideo.std = std(dc.belt.maze{ii}.durationVideo.raw);
dc.belt.maze{ii}.durationTango.mean = mean(dc.belt.maze{ii}.durationTango.raw);
dc.belt.maze{ii}.durationTango.std = std(dc.belt.maze{ii}.durationTango.raw);
dc.belt.maze{ii}.majorColl.mean = mean(dc.belt.maze{ii}.majorColl.raw);
dc.belt.maze{ii}.majorColl.std = std(dc.belt.maze{ii}.majorColl.raw);
dc.belt.maze{ii}.majorColl.min = min(dc.belt.maze{ii}.majorColl.raw);
dc.belt.maze{ii}.majorColl.deltaLow = dc.belt.maze{ii}.majorColl.mean - dc.belt.maze{ii}.majorColl.min;
dc.belt.maze{ii}.majorColl.max = max(dc.belt.maze{ii}.majorColl.raw);
dc.belt.maze{ii}.majorColl.deltaHigh = dc.belt.maze{ii}.majorColl.max - dc.belt.maze{ii}.majorColl.mean;

dc.belt.maze{ii}.distance.mean = mean(dc.belt.maze{ii}.distance.raw);
dc.belt.maze{ii}.distance.std = std(dc.belt.maze{ii}.distance.raw);

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


%% Second Bar Graph approach
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


%% Third Bar Graph With Subplots
hFig = figure(12)
set(hFig, 'Position', [30 60 1800 1024])

specs1 = {};

specs2 = {};
specs3 = {};

titleFontSize = 20;
xaxisFontSize = 15;
axisRotation = 45;
offset = 33;
for ii = numOfMazes:-1:1

sp1 = subplot(1,3,1);
xlim(sp1,[offset 3*numOfMazes+offset])

bar((ii-1)*3+offset+1,dc.belt.maze{ii}.durationVideo.mean,'FaceColor',hsv2rgb([0 1 1.0]),'EdgeColor',hsv2rgb([0 1 1]),'LineWidth',1.5);
hold on;
errorbar((ii-1)*3+offset+1,dc.belt.maze{ii}.durationVideo.mean,dc.belt.maze{ii}.durationVideo.std,'LineWidth',1.5,'Color',hsv2rgb([0 1 0.6]),'linestyle','none'); 

bar((ii-1)*3+offset+2,dc.cane.maze{ii}.durationVideo.mean,'FaceColor',hsv2rgb([0 0.4 1]),'EdgeColor',hsv2rgb([0 0.4 1]),'LineWidth',1.5);
errorbar((ii-1)*3+offset+2,dc.cane.maze{ii}.durationVideo.mean,dc.cane.maze{ii}.durationVideo.std,'LineWidth',1.5,'Color',hsv2rgb([0 1 0.6]),'linestyle','none'); 

specs1 = horzcat(specs1,['HW ' num2str(ii) ' Belt Duration'],['HW ' num2str(ii) ' Cane Duration'],' ');
title('Durations','FontSize',titleFontSize)

set(gca,'Xtick',offset+1:numOfMazes*3+numOfMazes+offset,'XTickLabel',specs1,'XTickLabelRotation',axisRotation,'FontSize',xaxisFontSize)


%ylim([-3 inf]) % or your lower limit.

sp2 = subplot(1,3,2);
xlim(sp2,[offset 3*numOfMazes+offset])

% bar((ii-1)*3+1,dc.belt.maze{ii}.majorColl.mean,'FaceColor',hsv2rgb([0.3 1 1]),'EdgeColor',hsv2rgb([0.3 1 1]),'LineWidth',1.5);
% hold on;
% errorbar((ii-1)*3+1,dc.belt.maze{ii}.majorColl.mean,dc.belt.maze{ii}.majorColl.std,'LineWidth',1.5,'Color',hsv2rgb([0.3 1 0.6]),'linestyle','none'); 
% 
% bar((ii-1)*3+2,dc.cane.maze{ii}.wallTaps.mean,'FaceColor',hsv2rgb([0.3 0.2 1]),'EdgeColor',hsv2rgb([0.3 0.2 1]),'LineWidth',1.5);
% errorbar((ii-1)*3+2,dc.cane.maze{ii}.wallTaps.mean,dc.cane.maze{ii}.wallTaps.std,'LineWidth',1.5,'Color',hsv2rgb([0.3 1 0.6]),'linestyle','none'); 

% bar((ii-1)*3+1,dc.belt.maze{ii}.majorColl.max,'FaceColor',hsv2rgb([0.3 0.4 1]),'EdgeColor',hsv2rgb([0.3 0.4 1]),'LineWidth',1.5);
% hold on
% bar((ii-1)*3+1,dc.belt.maze{ii}.majorColl.mean,'FaceColor',hsv2rgb([0.3 1 0.8]),'EdgeColor',hsv2rgb([0.3 1 1]),'LineWidth',1.5);
% bar((ii-1)*3+1,dc.belt.maze{ii}.majorColl.min,'FaceColor',hsv2rgb([0.3 1 1]),'EdgeColor',hsv2rgb([0.3 0.4 1]),'LineWidth',1.5);
% 
% bar((ii-1)*3+2,dc.cane.maze{ii}.wallTaps.max,'FaceColor',hsv2rgb([0.3 0.1 1]),'EdgeColor',hsv2rgb([0.3 0.4 1]),'LineWidth',1.5);
% hold on
% bar((ii-1)*3+2,dc.cane.maze{ii}.wallTaps.mean,'FaceColor',hsv2rgb([0.3 0.4 0.8]),'EdgeColor',hsv2rgb([0.3 1 1]),'LineWidth',1.5);
% bar((ii-1)*3+2,dc.cane.maze{ii}.wallTaps.min,'FaceColor',hsv2rgb([0.3 1 1]),'EdgeColor',hsv2rgb([0.3 0.4 1]),'LineWidth',1.5);

bar((ii-1)*3+1+offset,dc.belt.maze{ii}.majorColl.mean,'FaceColor',hsv2rgb([0.3 1 1]),'EdgeColor',hsv2rgb([0.3 1 1]),'LineWidth',1.5);
hold on;
errorbar((ii-1)*3+1+offset,dc.belt.maze{ii}.majorColl.mean,min(dc.belt.maze{ii}.majorColl.std,dc.belt.maze{ii}.majorColl.deltaLow),dc.belt.maze{ii}.majorColl.std,'LineWidth',1.5,'Color',hsv2rgb([0.3 1 0.6]),'linestyle','none'); 

bar((ii-1)*3+2+offset,dc.cane.maze{ii}.wallTaps.mean,'FaceColor',hsv2rgb([0.3 0.2 1]),'EdgeColor',hsv2rgb([0.3 0.2 1]),'LineWidth',1.5);
errorbar((ii-1)*3+2+offset,dc.cane.maze{ii}.wallTaps.mean,min(dc.cane.maze{ii}.wallTaps.std,dc.cane.maze{ii}.wallTaps.deltaLow),dc.cane.maze{ii}.wallTaps.std,'LineWidth',1.5,'Color',hsv2rgb([0.3 1 0.6]),'linestyle','none'); 

specs2 = horzcat(specs2,['HW ' num2str(ii) ' Belt Major Collisions'],['HW ' num2str(ii) ' Cane Wall Taps'],' ');

title('Collisions and Taps','FontSize',titleFontSize)
set(gca,'Xtick',1+offset:numOfMazes*3+numOfMazes+offset,'XTickLabel',specs2,'XTickLabelRotation',axisRotation,'FontSize',xaxisFontSize)

sp3 = subplot(1,3,3);
xlim(sp3,[offset 3*numOfMazes+offset])
bar((ii-1)*3+1+offset,dc.belt.maze{ii}.distance.mean,'FaceColor',hsv2rgb([0.6 1 1]),'EdgeColor',hsv2rgb([0.6 1 1]),'LineWidth',1.5);

hold on;
errorbar((ii-1)*3+1+offset,dc.belt.maze{ii}.distance.mean,dc.belt.maze{ii}.distance.std,'LineWidth',1.5,'Color',hsv2rgb([0.6 1 0.6])); 

bar((ii-1)*3+2+offset,dc.cane.maze{ii}.distance.mean,'FaceColor',hsv2rgb([0.6 0.2 1]),'EdgeColor',hsv2rgb([0.6 0.2 1]),'LineWidth',1.5);
errorbar((ii-1)*3+2+offset,dc.cane.maze{ii}.distance.mean,dc.cane.maze{ii}.distance.std,'LineWidth',1.5,'Color',hsv2rgb([0.6 1 0.6])); 

specs3 = horzcat(specs3,['HW ' num2str(ii) ' Belt Avg Distance' ],['HW ' num2str(ii) ' Cane Avg Distance'],' ');

title('Distances','FontSize',titleFontSize)
set(gca,'Xtick',1+offset:numOfMazes*3+numOfMazes+offset,'XTickLabel',specs3,'XTickLabelRotation',axisRotation,'FontSize',xaxisFontSize)
% 
% xlhand = get(gca,'xlabel')
% set(xlhand,'string','X','fontsize',20)

end

% clip the data
% show min and max for taps and collisions, visualize that in a better way

fileOutCompiledData = 'data-analysis-blind-users-20160524_with_tango_compiled.mat';
filePathOutCompiledData = strcat(dropboxPath,fileOutCompiledData);
save(filePathOutCompiledData,'dc');
