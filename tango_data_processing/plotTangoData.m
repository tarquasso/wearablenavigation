clc
clear all
format long

%testName = '20160506154842';
testName = '20160506144144';
pathToTest = '/Users/brandonaraki_backup/Dropbox (MIT)/haptic devices/Experiments/study may 2016/user01 - 20160506/paul/tango/';
%pathToTest = '/Users/brandonaraki_backup/Desktop/';
%path = strcat(pathToTest,testName,'/vio_rgb/');
path = strcat(pathToTest,testName,'/');
fileString = ls(path);

files = sort(strsplit(fileString,{'\t','\n','\0'},'CollapseDelimiters',true));

x = [];
y = [];
z = [];
t = [];

for i=3:length(files)
    fileString = strcat(path, files{i});
    if i == 3
        file = dlmread(fileString,',',3,0);
    else
        file = dlmread(fileString);
    end
    
    x = [x; file(:,1)];
    y = [y; file(:,2)];
    z = [z; file(:,3)];
    t = [t; mod(file(:,11), 100000)];
end

%shift x and y to begin at the origin
x = x - x(1);
y = y - min(y);

%get tango x and y bounding box
%by finding the highest and lowest x and y values
max_x = max(x);
min_x = min(x);
max_y = max(y);
min_y = min(y);

%scale data so that the path fits into a 4 x 4.5 box
% x-width is 4 because I want 0.5 x-width on either side for the walls
% y-height is 4.5 because I want 0.5-height on top for the wall
scale_x = 4/(max_x-min_x);
scale_y = 4.5/(max_y-min_y);
x = scale_x * x;
y = scale_y * y;

t = (t-t(1))/1000; %convert t to seconds and start it at time 0

vel = [0];
for j=1:length(x)-1
    distance = sqrt((x(j+1)-x(j))^2+(y(j+1)-y(j))^2);
    %distance = sqrt((x(j+1)-x(j))^2+(y(j+1)-y(j))^2+(z(j+1)-z(j))^2);
    velocity = distance/(t(j+1)-t(j));
    vel = [vel velocity];
end

%figure;plot(x,y);
[new_x,new_y] = rotatePoints(x,y,-0.05);
figure; plot(new_x,new_y);
figure;
grid on;
h = plot(new_x,new_y,'LineWidth',2.5,'Color','b');
grid on;
axis([-3,3,0,6]);
axis off;
%title('x and y coordinates of motion');

savePath = strcat(pathToTest,testName);
saveas(h,savePath,'epsc')
figure;
plot(new_x,new_y,'LineWidth',2.5,'Color','b');
hold on
grid on
% line([0.5 0.5],[-0.5,3.25],'LineWidth',4,'Color','black')
% line([0.5 -2],[3.25,3.25],'LineWidth',4,'Color','black')
% line([-2,-2],[3.25,4.5],'LineWidth',4,'Color','black')
% line([-2,3],[4.5,4.5],'LineWidth',4,'Color','black')
% line([-.5,-.5],[-0.5,2.25],'LineWidth',4,'Color','black')
% line([-.5,-3],[2.25,2.25],'LineWidth',4,'Color','black')
% line([-3,-3],[2.25,5.5],'LineWidth',4,'Color','black')
% line([-3,3],[5.5,5.5],'LineWidth',4,'Color','black')

line([0.5 0.5],[0,2.25],'LineWidth',4,'Color','black')
line([0.5 -1.75],[2.25,2.25],'LineWidth',4,'Color','black')
line([-1.75,-1.75],[2.25,3.75],'LineWidth',4,'Color','black')
line([-1.75,1.75],[3.75,3.75],'LineWidth',4,'Color','black')
line([-.5,-.5],[0,1.25],'LineWidth',4,'Color','black')
line([-.5,-2.75],[1.25,1.25],'LineWidth',4,'Color','black')
line([-2.75,-2.75],[1.25,4.75],'LineWidth',4,'Color','black')
line([-2.75,1.75],[4.75,4.75],'LineWidth',4,'Color','black')
export_fig test.png

%figure;plot(t,vel);
%title('speed of motion in m/s I think');