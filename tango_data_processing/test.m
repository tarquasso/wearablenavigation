y = [11 31 16 17 7 113 15 11 31 16 17 7 113 15 44 88 99 66]';
p = [17 7 113 15 44 88 99 66 77]';

bar(y)

set(gca,'xtick',1:18)

xt=(1:2:18)'+ 0.5;
yMaxPerPair = max([y(1:2:end-1),y(2:2:end)],[],2);
yt=yMaxPerPair+5;
ytxt=num2str(p(:,1),'p=%.2f');
text(xt,yt,ytxt,'rotation',90,'fontsize',8,'fontweight','bold')