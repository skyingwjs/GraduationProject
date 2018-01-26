clc;
clear all;


%% *******************************�ں����������Լ�˵������**********************%
% x=0:0.1:2.2;
% y=160./(1+exp(-6*(x-1)));
% plot(x,y,'k')
% 
% max_y = max(y);
% y1 = 0.85 * max_y;
% x1 = interp1(y,x,y1);
% hold on
% plot([x1 x1], [0 y1],'--k')
% plot([0 x1], [y1 y1],'--k')
% text(x1/2,y1,'85% λ','horiz','center','vert','bottom')
% text(1.25,165,'����������','horiz','center','vert','bottom')
% text(0,80,'��λ��      ','horiz','right','vert','middle')

%% *****************************����ͼ���ܱ���*********************************%
x=linspace(0,pi);
y1=cos(x);
y2=sin(x);
h(1)=subplot('position',[.08,.08,.35,.8]);
hP(1)=plot(x,y1);
hTit(1)=title('����1');
h(2)=subplot('position',[.6,.08,.35,.8]);
hP(2)=plot(x,y2);
hTit(2)=title('����2');
set(hTit,'fontname','����','fontsize',16)
set(hP,'linewidth',2)
set(h,'xtick',0:pi/6:pi)
set(gcf,'color','w')
annotation(gcf,'textbox',[0.5 0.9 0.05 0.05],'String',{'�ܱ���'},'FontSize',20,'edgecolor',get(gcf,'color'));
