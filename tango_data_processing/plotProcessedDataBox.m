% FILL IN YOUR computer username here:
editorNames = {'rkk', 'brandonaraki_backup'};

dropboxPathOptions = {'~/Dropbox (MIT)/Robotics Research/haptic devices/Experiments/study may 2016/',...
    '/Users/brandonaraki_backup/Dropbox (MIT)/haptic devices/Experiments/study may 2016/'};

osUserName = char(java.lang.System.getProperty('user.name'));

for k = 1:length(editorNames)
    curName = editorNames{k};
  if strcmp (osUserName,curName)
      dropboxPath = dropboxPathOptions{k};
  end
end

userNumber = 2;
userNumToID = [1, 2, 3, 4, 6, 8, 9, 10, 11, 12, 13];

tests1 = { ...
'010 user01 PP 07a belt bx1', ...
'029 user02 AC 11a belt bx1', ...
'044 user03 SG 12a belt bx1', ...
'056 user04 SF 12a belt bx1', ...
'081 user06 RC 12b belt bx1', ...
'107 user08 HS 12b belt bx1', ...
'186 user09 JK 12b belt bx1', ...
'134 user10 KB 12a belt bx1', ...
'146 user11 MK 12a belt bx1', ...
'158 user12 BB 12a belt bx1', ...
'170 user13 TL 12a belt bx1'};
test1 = tests1{userNumber};
path = strcat(dropboxPath,'processedData/',test1);
load(path);

tt = zeros(4,1);
duration = zeros(4,1);

saveAs1 = test1;
id1 = str2num(saveAs1(1:3));
x1 = x;
x_shift1 = x_shift;
y1 = y;
y_shift1 = y_shift;
theta1 = theta;
maze1 = mazeNum;
tt(1) = total_time;
ave1 = ave_velocity;
time1 = time;
dist(1) = distance;
if1 = index_first;
il1 = index_last;
if tt(1) < 0
    tt(1) = (100000 + time1(il1) - time1(if1))/1000;
    ave1 = dist(1)/tt(1);
end

tests2 = {...
'011 user01 PP 08a belt bx2', ...
'027 user02 AC 09b belt bx2', ...
'042 user03 SG 10b belt bx2', ...
'054 user04 SF 10a belt bx2', ...
'078 user06 RC 10a belt bx2', ...
'104 user08 HS 10a belt bx2', ...
'119 user09 JK 10a belt bx2', ...
'132 user10 KB 10a belt bx2', ...
'144 user11 MK 10a belt bx2', ...
'156 user12 BB 10a belt bx2', ...
'168 user13 TL 10a belt bx2'};
test2 = tests2{userNumber};
path = strcat(dropboxPath,'processedData/',test2);
load(path);

saveAs2 = test2;
id2 = str2num(saveAs2(1:3));
x2 = x;
x_shift2 = x_shift;
y2 = y;
maze2 = mazeNum;
y_shift2 = y_shift;
theta2 = theta;
tt(2) = total_time;
ave2 = ave_velocity;
dist(2) = distance;
if2 = index_first;
il2 = index_last;
time2 = time;
if tt(2) < 0
    tt(2) = (100000 + time2(il2) - time2(if2))/1000;
    ave2 = dist(2)/tt(2);
end

tests3 = { ...
'012 user01 PP 09a belt bx3', ...
'028 user02 AC 10a belt bx3', ...
'043 user03 SG 11a belt bx3', ...
'055 user04 SF 11a belt bx3', ...
'079 user06 RC 11a belt bx3', ...
'105 user08 HS 11a belt bx3', ...
'120 user09 JK 11a belt bx3', ...
'133 user10 KB 11a belt bx3', ...
'145 user11 MK 11a belt bx3', ...
'157 user12 BB 11a belt bx3', ...
'169 user13 TL 11a belt bx3'};
test3 = tests3{userNumber};
path = strcat(dropboxPath,'processedData/',test3);
load(path);

saveAs3 = test3;
id3 = str2num(saveAs3(1:3));
x3 = x;
x_shift3 = x_shift;
y3 = y;
y_shift3 = y_shift;
theta3 = theta;
tt(3) = total_time;
ave3 = ave_velocity;
maze3 = mazeNum;
dist(3) = distance;
if3 = index_first;
il3 = index_last;
time3 = time;
if tt(3) < 0
    tt(3) = (100000 + time3(il3) - time3(if3))/1000;
    ave3 = dist(3)/tt(3);
end

tests4 = { ... 
'012 user01 PP 09a belt bx3', ...
'025 user02 AC 08b belt bx4', ...
'040 user03 SG 09b belt bx4', ...
'053 user04 SF 09a belt bx4', ...
'077 user06 RC 09a belt bx4', ...
'103 user08 HS 09a belt bx4', ...
'118 user09 JK 09b belt bx4', ...
'131 user10 KB 09b belt bx4', ...
'143 user11 MK 09a belt bx4', ...
'155 user12 BB 09a belt bx4', ...
'167 user13 TL 09a belt bx4'};
test4 = tests4{userNumber};
path = strcat(dropboxPath,'processedData/',test4);
load(path);

saveAs4 = test4;
id4 = str2num(saveAs4(1:3));
x4 = x;
x_shift4 = x_shift;
y4 = y;
y_shift4 = y_shift;
theta4 = theta;
tt(4) = total_time;
ave4 = ave_velocity;
maze4 = mazeNum;
dist(4) = distance;
if4 = index_first;
il4 = index_last;
time4 = time;
if tt(4) < 0
    tt(4) = (100000 + time4(il4) - time4(if4))/1000;
    ave4 = dist(4)/tt(4);
end

file = 'data-analysis-blind-users-20160524rev1.xlsx';
sheet = 1;
filePath = strcat(dropboxPath,file);
[num,txt,raw] = xlsread(filePath,sheet);

collisionCol = 17; %verify with spreadsheet

collisions = zeros(4,1);
collisions(1) = num(id1,collisionCol);
collisions(2) = num(id2,collisionCol);
collisions(3) = num(id3,collisionCol);
collisions(4) = num(id4,collisionCol);

f1 = figure();
set(f1, 'Position', [30 60 1200 400])
bigTitleFontSize = 14;
titleFontSize = 10;
legendFontSize = 10;
xaxisFontSize = 10;
distMin = inf;
ttMin = inf;
ttMax = 0; %init this value to 0
collMax = 0; %init this value to 0
distMax = 0; %init this value to 0
sp = cell(3,4);

hold on
cols = 4*3;
xll = 0.55;
xul = 1.45;
subPlotHeight = 3;

subplot(subPlotHeight,cols,[1 2 cols+1 cols+2  2*cols+1 2*cols+2]);
plot(x1(if1:il1)+x_shift1,y1(if1:il1)+y_shift1,'LineWidth',2.5,'Color','r');
plot_box(f1,maze1);
text(0.04,0.49,sprintf('Hallway with Box %d',maze1),'Units', 'Normalized','FontSize',20,'rotation',90);        
% title(sprintf('Box Trial %d',maze1),'FontSize',bigTitleFontSize);
set(gca,'visible','off')

if userNumber ~= 11
    subplot(subPlotHeight,cols,[1 2 cols+1 cols+2  2*cols+1 2*cols+2]+3);
    plot(x2(if2:il2)+x_shift2,y2(if2:il2)+y_shift2,'LineWidth',2.5,'Color','r');
    plot_box(f1,maze2);
    text(0.04,0.49,sprintf('Hallway with Box %d',maze2),'Units', 'Normalized','FontSize',20,'rotation',90);
%     title(sprintf('Box Trial %d',maze2),'FontSize',bigTitleFontSize);
     set(gca,'visible','off')
end

subplot(subPlotHeight,cols,[1 2 cols+1 cols+2  2*cols+1 2*cols+2]+3*2);
plot(x3(if3:il3)+x_shift3,y3(if3:il3)+y_shift3,'LineWidth',2.5,'Color','r');
plot_box(f1,maze3);
 text(0.04,0.49,sprintf('Hallway with Box %d',maze3),'Units', 'Normalized','FontSize',20,'rotation',90);
% title(sprintf('Box Trial %d',maze3),'FontSize',bigTitleFontSize);
 set(gca,'visible','off')

subplot(subPlotHeight,cols,[1 2 cols+1 cols+2  2*cols+1 2*cols+2]+3*3);
plot(x4(if4:il4)+x_shift4,y4(if4:il4)+y_shift4,'LineWidth',2.5,'Color','r');
plot_box(f1,maze4);
 text(0.04,0.49,sprintf('Hallway with Box %d',maze4),'Units', 'Normalized','FontSize',20,'rotation',90);
% title(sprintf('Box Trial %d',maze4),'FontSize',bigTitleFontSize);
 set(gca,'visible','off')

for ii = 1:4
sp{1,ii} = subplot(subPlotHeight,cols,3+3*(ii-1));
hold on
%xlim(sp{1,ii},[xll xul])
bar(1,tt(ii), 'facecolor', hsv2rgb([0.0 1 1]),...
        'EdgeColor',hsv2rgb([0.0 1 1]),'LineWidth',1);
ttMin = min(ttMin,tt(ii));
ttMax = max(ttMax,tt(ii));
hold off;
yLab1 = ylabel('Duration [s]','FontSize',titleFontSize);
%set(yLab1, 'Units', 'Normalized', 'Position', [-0.35, 0.5, 0]);

    
set(gca, 'XTick', 1, 'XTickLabel', {'ALVU'},'FontSize',xaxisFontSize);
    
sp{2,ii} = subplot(subPlotHeight,cols,3+3*(ii-1)+cols);
hold on
%xlim(sp{2,ii},[xll xul])
bar(1,collisions(ii), 'facecolor', hsv2rgb([0.0 0.6 1]),...
        'EdgeColor',hsv2rgb([0.0 1 1]),'LineWidth',1);
collMax = max(collMax,collisions(ii));
hold off;
yLab2 = ylabel('# of Collisions','FontSize',titleFontSize);
set(gca, 'XTick', 1, 'XTickLabel', {'ALVU'},'FontSize',xaxisFontSize);

sp{3,ii} = subplot(subPlotHeight,cols,3+3*(ii-1)+2*cols);
hold on
%xlim(sp{3,ii},[xll xul])
bar(1,dist(ii), 'facecolor', hsv2rgb([0.0 0.2 1]),...
        'EdgeColor',hsv2rgb([0.0 1 1]),'LineWidth',1);
distMin = min(distMin,dist(ii));
distMax = max(distMax,dist(ii));
hold off;
yLab3 = ylabel('Length [m]','FontSize',titleFontSize);
%set(yLab4, 'Units', 'Normalized', 'Position', [-0.2, 0.5, 0]);
set(gca, 'XTick', 1, 'XTickLabel', {'ALVU'},'FontSize',xaxisFontSize);
end

%adjust ylims to make uniform
for i =1:4
    ylim(sp{1,i},[0.97*ttMin 1.03*ttMax])
    %set(sp{1,i},'YTick',floor(linspace(ttMin,ttMax,6)))
    %position1 = get(gca, 'Position');
    %position1(1) = position1(1)*1.05;
    %pos(3) = pos(3)* 0.8;
    %set(gca,'Position', position1);
    collMaxUse = max(collMax,1);
    ylim(sp{2,i},[0 collMaxUse])
    set(sp{2,i},'YTick',0:1:collMaxUse)
        
    ylim(sp{3,i},[0.97*distMin 1.03*distMax])
    %set(sp{3,i},'YTick',linspace(distMin,distMax,min(6,distMax-distMin)));
end
    
% annotation('textbox', [0 0.9 1 0.1], ...
%     'String', 'User 13', ...
%     'EdgeColor', 'none', ...
%     'HorizontalAlignment', 'center',...
%     'FontSize', 30)
