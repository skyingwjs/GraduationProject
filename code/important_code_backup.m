clc;
clear all;
initpath();
x=1:25;
y=x;

single_azi_list=[0 5 10 15 20 25 30 35 40];
right_loudspeaker_azi_list=[0 15 20 25 30 35 40 45];
figure_rows=length(single_azi_list);
figure_columns=length(right_loudspeaker_azi_list);
figure;
for i=1:length(single_azi_list)
    for j=1:length(right_loudspeaker_azi_list)
        if single_azi_list(i)<right_loudspeaker_azi_list(j)||right_loudspeaker_azi_list(j)==0
            k=figure_columns*(i-1)+j;
            subplot(figure_rows, figure_columns ,k);
        plot(x,y,'-g'); 
    %     xlabel('子带','fontsize',8);
    %     ylabel('子带上概率最大ILD(dB)','fontsize',8);    
    %     title(['单声源方位' figure_single_azi '度时双耳信号子带ILD'],'fontsize',8);
        axis([1 25 1 25]);            
        end
    end
end


%———————根据实验得到的双耳信号进行分析————————————————
clc;
clear all;
initpath();
x=1:25;
y=x;

single_azi_list=[0 5 10 15 20 25 30 35 40];
right_loudspeaker_azi_list=[0 15 20 25 30 35 40 45];
figure_rows=length(single_azi_list);
figure_columns=length(right_loudspeaker_azi_list);
figure;
set(gcf,'color','w');%figure背景色改为白色
for i=1:length(single_azi_list)
    for j=1:length(right_loudspeaker_azi_list)
        if single_azi_list(i)<right_loudspeaker_azi_list(j)||right_loudspeaker_azi_list(j)==0
            k=figure_columns*(i-1)+j;
            subplot(figure_rows, figure_columns ,k);
            plot(x,y,'-g'); 
            if j>1%没有纵坐标标记
                set(gca,'ytick',[5 10 15 20 25])%设置坐标轴刻度
                set(gca,'yticklabel',[]);%设置坐标轴刻度旁的label为null
            end
            if i>1%没有横坐标标记
                set(gca,'xtick',[5 10 15 20 25])%设置坐标轴刻度
                set(gca,'xticklabel',[]);%设置坐标轴刻度旁的label为null
            end                
            %xlabel('子带','fontsize',8);
            %ylabel('子带上概率最大ILD(dB)','fontsize',8);    
            %title(['单声源方位' figure_single_azi '度时双耳信号子带ILD'],'fontsize',8);
        axis([1 25 1 25]);
        %axis([1 25 -10 10]);           
        end
    end
end