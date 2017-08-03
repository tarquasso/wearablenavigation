function plot_box(f1,num)

h = 1.1;
bw = 0.77; %box width
bh = 0.35; %box 'height'/depth
wd = 0.8; %wall displacement from the center

figure(f1)
axis equal

hold on

line([-wd -wd],[0 6.2],'LineWidth',4,'Color','black')
line([wd wd],[0 6.2],'LineWidth',4,'Color','black')

plot([-0.96 -0.96],[0.5,1.5],'k','LineWidth',2);
plot([-1.02 -0.92],[0.5,0.5],'k','LineWidth',2);
plot([-1.02 -0.92],[1.5,1.5],'k','LineWidth',2);
%text(-1.8,0.27,'1m');
text(-1.1,0.8,'1m','FontSize',14,'rotation',90);

axis([-1.15 0.9 0 inf]);

if num == 0
    return;
elseif num == 1
    rectangle('Position',[-wd+0.03,3*h,bw,bh],'FaceColor','g');
elseif num == 2
    rectangle('Position',[wd-bw-0.03,4*h,bw,bh],'FaceColor','g');
elseif num == 3
    rectangle('Position',[wd-bw-0.03,2*h,bw,bh],'FaceColor','g');
elseif num == 4
    rectangle('Position',[-wd+0.03,2*h,bw,bh],'FaceColor','g');
end


hold off

end