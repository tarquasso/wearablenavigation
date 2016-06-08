function [ x, y ] = tango_data( userName, testName )

pathToTest = '/Users/brandonaraki_backup/Dropbox (MIT)/haptic devices/Experiments/study may 2016/';

path = strcat(pathToTest,userName,'/tango/',testName,'/');

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

end