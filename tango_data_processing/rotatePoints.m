function [ new_x, new_y ] = rotatePoints( x, y, theta )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

r = [cos(theta) sin(theta); -sin(theta) cos(theta)];
points = [x y];
newpoints = (r*points')';
new_x = newpoints(:,1);
new_y = newpoints(:,2);

end

