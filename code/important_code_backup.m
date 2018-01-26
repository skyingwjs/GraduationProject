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
    %     xlabel('�Ӵ�','fontsize',8);
    %     ylabel('�Ӵ��ϸ������ILD(dB)','fontsize',8);    
    %     title(['����Դ��λ' figure_single_azi '��ʱ˫���ź��Ӵ�ILD'],'fontsize',8);
        axis([1 25 1 25]);            
        end
    end
end


%������������������ʵ��õ���˫���źŽ��з�����������������������������������
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
set(gcf,'color','w');%figure����ɫ��Ϊ��ɫ
for i=1:length(single_azi_list)
    for j=1:length(right_loudspeaker_azi_list)
        if single_azi_list(i)<right_loudspeaker_azi_list(j)||right_loudspeaker_azi_list(j)==0
            k=figure_columns*(i-1)+j;
            subplot(figure_rows, figure_columns ,k);
            plot(x,y,'-g'); 
            if j>1%û����������
                set(gca,'ytick',[5 10 15 20 25])%����������̶�
                set(gca,'yticklabel',[]);%����������̶��Ե�labelΪnull
            end
            if i>1%û�к�������
                set(gca,'xtick',[5 10 15 20 25])%����������̶�
                set(gca,'xticklabel',[]);%����������̶��Ե�labelΪnull
            end                
            %xlabel('�Ӵ�','fontsize',8);
            %ylabel('�Ӵ��ϸ������ILD(dB)','fontsize',8);    
            %title(['����Դ��λ' figure_single_azi '��ʱ˫���ź��Ӵ�ILD'],'fontsize',8);
        axis([1 25 1 25]);
        %axis([1 25 -10 10]);           
        end
    end
end