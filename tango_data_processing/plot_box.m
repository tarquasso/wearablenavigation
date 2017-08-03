function plot_box(f1,num)

h = 1.1;
bw = 0.8; %box width
bh = 0.35; %box 'height'/depth
wd = 0.8; %wall displacement from the center

figure(f1)
axis equal

hold on

line([-wd -wd],[0 6.2],'LineWidth',4,'Color','black')
line([wd wd],[0 6.2],'LineWidth',4,'Color','black')

plot([-2.2 -1.2],[0.5,0.5],'k');
plot([-2.2 -2.2],[0.45,0.55],'k');
plot([-1.2 -1.2],[0.45,0.55],'k');
text(-1.8,0.27,'1m');


axis([-2.2 2.2 0 inf]);

if num == 0
    return;
elseif num == 1
    rectangle('Position',[-wd,3*h,bw,bh],'FaceColor','g');
elseif num == 2
    rectangle('Position',[wd-bw,4*h,bw,bh],'FaceColor','g');
elseif num == 3
    rectangle('Position',[wd-bw,2*h,bw,bh],'FaceColor','g');
elseif num == 4
    rectangle('Position',[-wd,2*h,bw,bh],'FaceColor','g');
end


hold off

end