dropboxPath = '/Users/brandonaraki_backup/Dropbox (MIT)/haptic devices/Experiments/study may 2016/';
test1 = '003 user01 PP 03a cane mz3';
path = strcat(dropboxPath,'processedData/',test1);
load(path);

saveAs1 = test1;
id1 = str2num(saveAs1(1:3));
x1 = x;
x_shift1 = x_shift;
y1 = y;
y_shift1 = y_shift;
theta1 = theta;
tt1 = total_time;
ave1 = ave_velocity;
time1 = time;
distance1 = distance;
if1 = index_first;
il1 = index_last;
if tt1 < 0
    tt1 = (100000 + time1(il1) - time1(if1))/1000;
    ave1 = distance1/tt1;
end


test2 = '007 user01 PP 05a belt mz3';
path = strcat(dropboxPath,'processedData/',test2);
load(path);

saveAs2 = test2;
id2 = str2num(saveAs2(1:3));
x2 = x;
x_shift2 = x_shift;
y2 = y;
y_shift2 = y_shift;
theta2 = theta;
tt2 = total_time;
ave2 = ave_velocity;
distance2 = distance;
if2 = index_first;
il2 = index_last;
time2 = time;
if tt2 < 0
    tt2 = (100000 + time2(il2) - time2(if2))/1000;
    ave2 = distance2/tt2;
end

file = 'data-analysis-blind-users-20160524.xlsx';
sheet = 1;
filePath = strcat(dropboxPath,file);
[num,txt,raw] = xlsread(filePath,sheet);

wallTapCol = 15;
collisionCol = 18;

wallTaps = num(id1,wallTapCol);
collisions = num(id2,collisionCol);

f1 = figure();
subplot(4,2,[1 2 3 4]);
hold on
plot(x1(if1:il1)+x_shift1,y1(if1:il1)+y_shift1,'LineWidth',2.5,'Color','b');
plot(x2(if2:il2)+x_shift2,y2(if2:il2)+y_shift2,'LineWidth',2.5,'Color','r');
legend('cane','belt','Location','southeast');
title(sprintf('User 01 Maze %d',mazeNum));
plot_maze(f1,mazeNum);
hold off

subplot(4,2,5)
hold on;
bar(1, distance1, 'facecolor', 'b');
bar(2, distance2, 'facecolor', 'r');
hold off;
ylabel('distance [m]');
set(gca, 'XTick', 1:2, 'XTickLabel', {'cane','belt'});

subplot(4,2,6)
hold on;
bar(1, tt1, 'facecolor', 'b');
bar(2, tt2, 'facecolor', 'r');
hold off;
ylabel('time [s]')
set(gca, 'XTick', 1:2, 'XTickLabel', {'cane','belt'});

subplot(4,2,7)
hold on;
bar(1, ave1, 'facecolor', 'b');
bar(2, ave2, 'facecolor', 'r');
hold off;
ylabel('average velocity [m/s]')
set(gca, 'XTick', 1:2, 'XTickLabel', {'cane','belt'});

subplot(4,2,8)
hold on;
bar(1,wallTaps, 'facecolor', 'b');
bar(2, collisions, 'facecolor', 'r');
hold off;
ylabel('wall taps / collisions')
set(gca, 'XTick', 1:2, 'XTickLabel', {'cane','belt'});