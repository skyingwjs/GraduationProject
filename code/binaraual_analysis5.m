%������������������ʵ��õ���˫���źŽ��з�����������������������������������
clc;
clear all;
initpath();

flag_binaraul_list_azi=0;%ȡֵ��0:5:40 ��־ĳ��single_azi�� ��˫��Դ˫���ź�ILD�Ա�
flag_signal_figure=0;%�����źŲ���ͼ
flag_signal_ILD=0;%1:����֡��ILD����������; 
flag_mean_ILD=1;%1:����֡���Ӵ���ƽ��ֵ ��ͼ   
flag_signal_ILD_ksdensity=1;%ILD�����ܶȷֲ�ͼ
flag_points_ILD=0;%������˫��Դ˫���ź�ÿ��Ƶ��ILDȡֵ�������ʱ�� ILD����ͼ
flag_subbands_ILD=1;%������˫��Դ˫���ź�ÿ���Ӵ�ILDȡֵ�������ʱ�� ILD����ͼ

single_azi_list=[0 5 10 15 20 25 30 35 40];
% single_azi_list=[0 5 10 ];
right_loudspeaker_azi_list=[0 15 20 25 30 35 40 45];
figure_rows=length(single_azi_list);
figure_columns=length(right_loudspeaker_azi_list);

binarual_signal_basepath='.\binarualsignal\';
binarual_count=2*ones(9,1);%�ֱ��Ӧ����single_azi(0:5:40)�µ�˫��Դ˫���źż���


xls_file_name='result(����ɽ).xlsx';
sheet='result';
xls_range='B1:G8';
[ndata txt alldata]=xlsread(xls_file_name,sheet,xls_range);

%%��excel���л�ȡ���е�������Ϣ
for i=2:8
    
    Result.group_name=alldata{i,1}; 
    Result.loud_speaker_azi=alldata{i,2}; 
    
    single_azi_range=alldata{i,3};
    Result.single_azi=xlsread(xls_file_name,sheet,single_azi_range);
    
    num_range=alldata{i,4};  
    Result.num=xlsread(xls_file_name,sheet,num_range);
    
    left_gain_range=alldata{i,5}; 
    Result.left_gain=xlsread(xls_file_name,sheet,left_gain_range);
    
    right_gain_range=alldata{i,6};
    Result.right_gain=xlsread(xls_file_name,sheet,right_gain_range);
    
    %ȷ��������������λ     
    switch Result.loud_speaker_azi
        case '(-15,15)'
            %������������λ��
            azi_loudspeaker=[-15 15];
            %ĳ�������飨ĳ�������������£���˫���ź�·��     b_-15_15��ʾ��[-15 15]�������µ�˫��Դ��˫���ź�·�� 
            binarual_group_path=[binarual_signal_basepath,'b_-15_15\'];
        case '(-20,20)'
            azi_loudspeaker=[-20 20];
            binarual_group_path=[binarual_signal_basepath,'b_-20_20\'];
        case '(-25,25)'
            azi_loudspeaker=[-25 25];
            binarual_group_path=[binarual_signal_basepath,'b_-25_25\'];
        case '(-30,30)'
            azi_loudspeaker=[-30 30];
            binarual_group_path=[binarual_signal_basepath,'b_-30_30\'];
        case '(-35,35)'
            azi_loudspeaker=[-35 35];
            binarual_group_path=[binarual_signal_basepath,'b_-35_35\'];
        case '(-40,40)'
            azi_loudspeaker=[-40 40];
            binarual_group_path=[binarual_signal_basepath,'b_-40_40\'];
        case '(-45,45)'
            azi_loudspeaker=[-45 45]; 
            binarual_group_path=[binarual_signal_basepath,'b_-45_45\'];
    end
    %����Դ��λ    
    azi_single=Result.single_azi;
 
   
    %˫���źŲ������ ���ļ��У�ÿ�����ļ���  ���Ǹ��������� ĳ������Դ��λ�µĲ����źţ�  
    for k=1:length(Result.num)%������Դsingle_azi�Ĳ�ͬ���飨0:5:40��   �ҵ����۸�֪��ӽ���˫��Դ˫���źŵ� �ļ��� 
        switch azi_single(k)
           %% ����Դ��λ��Ϊ0ʱ
            case 0                
                %���ĳ����λ�µ���Դ˫���ź��ļ���  
                % binaraul_list_azi0{}�����δ洢���� 0�ȷ�λ�� ����Դ˫���ź� [-15 15]  [-20 20]...[-45 45]���������������۸�֪��ӽ���˫��Դ˫���ź�
                binaraul_list_azi0{1}=[binarual_group_path,'b_',num2str(azi_single(k)),'_', num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),...
                     '\s_b_', num2str(azi_single(k)), '_whitenoise_0dB.wav'];
                 
                %���ĳ����λ�� ���۸�֪��ӽ�˫��Դ˫���ź��ļ���
                if Result.num(k)<10
                    binaraul_list_azi0{binarual_count(1)}=[binarual_group_path,'b_',num2str(azi_single(k)),'_', num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),...
                    '\d_b_',num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),'_0',num2str(Result.num(k)),'_whitenoise_0dB.wav'];              
                else
                    binaraul_list_azi0{binarual_count(1)}=[binarual_group_path,'b_',num2str(azi_single(k)),'_', num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),...
                    '\d_b_',num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),'_',num2str(Result.num(k)),'_whitenoise_0dB.wav'];
                end
                binarual_count(1)=binarual_count(1)+1;
                
                
           %% ����Դ��λ��Ϊ5ʱ                   
            case 5
                                %���ĳ����λ�µ���Դ˫���ź��ļ���
                binaraul_list_azi5{1}=[binarual_group_path,'b_',num2str(azi_single(k)),'_', num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),...
                     '\s_b_', num2str(azi_single(k)), '_whitenoise_0dB.wav'];
                 
                %���ĳ����λ�� ���۸�֪��ӽ�˫��Դ˫���ź��ļ���
                if Result.num(k)<10
                    binaraul_list_azi5{binarual_count(2)}=[binarual_group_path,'b_',num2str(azi_single(k)),'_', num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),...
                    '\d_b_',num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),'_0',num2str(Result.num(k)),'_whitenoise_0dB.wav'];              
                else
                    binaraul_list_azi5{binarual_count(2)}=[binarual_group_path,'b_',num2str(azi_single(k)),'_', num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),...
                    '\d_b_',num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),'_',num2str(Result.num(k)),'_whitenoise_0dB.wav'];
                end
                binarual_count(2)=binarual_count(2)+1;
                
                
           %% ����Դ��λ��Ϊ10ʱ                
            case 10
                                %���ĳ����λ�µ���Դ˫���ź��ļ���
                binaraul_list_azi10{1}=[binarual_group_path,'b_',num2str(azi_single(k)),'_', num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),...
                     '\s_b_', num2str(azi_single(k)), '_whitenoise_0dB.wav'];
                 
                %���ĳ����λ�� ���۸�֪��ӽ�˫��Դ˫���ź��ļ���
                if Result.num(k)<10
                    binaraul_list_azi10{binarual_count(3)}=[binarual_group_path,'b_',num2str(azi_single(k)),'_', num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),...
                    '\d_b_',num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),'_0',num2str(Result.num(k)),'_whitenoise_0dB.wav'];              
                else
                    binaraul_list_azi10{binarual_count(3)}=[binarual_group_path,'b_',num2str(azi_single(k)),'_', num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),...
                    '\d_b_',num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),'_',num2str(Result.num(k)),'_whitenoise_0dB.wav'];
                end
                binarual_count(3)=binarual_count(3)+1;
                
                
           %% ����Դ��λ��Ϊ15ʱ                
            case 15
                                %���ĳ����λ�µ���Դ˫���ź��ļ���
                binaraul_list_azi15{1}=[binarual_group_path,'b_',num2str(azi_single(k)),'_', num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),...
                     '\s_b_', num2str(azi_single(k)), '_whitenoise_0dB.wav'];
                 
                %���ĳ����λ�� ���۸�֪��ӽ�˫��Դ˫���ź��ļ���
                if Result.num(k)<10
                    binaraul_list_azi15{binarual_count(4)}=[binarual_group_path,'b_',num2str(azi_single(k)),'_', num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),...
                    '\d_b_',num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),'_0',num2str(Result.num(k)),'_whitenoise_0dB.wav'];              
                else
                    binaraul_list_azi15{binarual_count(4)}=[binarual_group_path,'b_',num2str(azi_single(k)),'_', num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),...
                    '\d_b_',num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),'_',num2str(Result.num(k)),'_whitenoise_0dB.wav'];
                end
                binarual_count(4)=binarual_count(4)+1;
                
          %% ����Դ��λ��Ϊ20ʱ               
            case 20
                                %���ĳ����λ�µ���Դ˫���ź��ļ���
                binaraul_list_azi20{1}=[binarual_group_path,'b_',num2str(azi_single(k)),'_', num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),...
                     '\s_b_', num2str(azi_single(k)), '_whitenoise_0dB.wav'];
                 
                %���ĳ����λ�� ���۸�֪��ӽ�˫��Դ˫���ź��ļ���
                if Result.num(k)<10
                    binaraul_list_azi20{binarual_count(5)}=[binarual_group_path,'b_',num2str(azi_single(k)),'_', num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),...
                    '\d_b_',num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),'_0',num2str(Result.num(k)),'_whitenoise_0dB.wav'];              
                else
                    binaraul_list_azi20{binarual_count(5)}=[binarual_group_path,'b_',num2str(azi_single(k)),'_', num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),...
                    '\d_b_',num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),'_',num2str(Result.num(k)),'_whitenoise_0dB.wav'];
                end
                binarual_count(5)=binarual_count(5)+1;
                
           %% ����Դ��λ��Ϊ25ʱ                
            case 25
                                %���ĳ����λ�µ���Դ˫���ź��ļ���
                binaraul_list_azi25{1}=[binarual_group_path,'b_',num2str(azi_single(k)),'_', num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),...
                     '\s_b_', num2str(azi_single(k)), '_whitenoise_0dB.wav'];
                 
                %���ĳ����λ�� ���۸�֪��ӽ�˫��Դ˫���ź��ļ���
                if Result.num(k)<10
                    binaraul_list_azi25{binarual_count(6)}=[binarual_group_path,'b_',num2str(azi_single(k)),'_', num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),...
                    '\d_b_',num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),'_0',num2str(Result.num(k)),'_whitenoise_0dB.wav'];              
                else
                    binaraul_list_azi25{binarual_count(6)}=[binarual_group_path,'b_',num2str(azi_single(k)),'_', num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),...
                    '\d_b_',num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),'_',num2str(Result.num(k)),'_whitenoise_0dB.wav'];
                end
                binarual_count(6)=binarual_count(6)+1;   
                
          %% ����Դ��λ��Ϊ30ʱ                
            case 30
                                %���ĳ����λ�µ���Դ˫���ź��ļ���
                binaraul_list_azi30{1}=[binarual_group_path,'b_',num2str(azi_single(k)),'_', num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),...
                     '\s_b_', num2str(azi_single(k)), '_whitenoise_0dB.wav'];
                 
                %���ĳ����λ�� ���۸�֪��ӽ�˫��Դ˫���ź��ļ���
                if Result.num(k)<10
                    binaraul_list_azi30{binarual_count(7)}=[binarual_group_path,'b_',num2str(azi_single(k)),'_', num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),...
                    '\d_b_',num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),'_0',num2str(Result.num(k)),'_whitenoise_0dB.wav'];              
                else
                    binaraul_list_azi30{binarual_count(7)}=[binarual_group_path,'b_',num2str(azi_single(k)),'_', num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),...
                    '\d_b_',num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),'_',num2str(Result.num(k)),'_whitenoise_0dB.wav'];
                end
                binarual_count(7)=binarual_count(7)+1;
                
           %% ����Դ��λ��Ϊ35ʱ                
            case 35   
                                %���ĳ����λ�µ���Դ˫���ź��ļ���
                binaraul_list_azi35{1}=[binarual_group_path,'b_',num2str(azi_single(k)),'_', num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),...
                     '\s_b_', num2str(azi_single(k)), '_whitenoise_0dB.wav'];
                 
                %���ĳ����λ�� ���۸�֪��ӽ�˫��Դ˫���ź��ļ���
                if Result.num(k)<10
                    binaraul_list_azi35{binarual_count(8)}=[binarual_group_path,'b_',num2str(azi_single(k)),'_', num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),...
                    '\d_b_',num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),'_0',num2str(Result.num(k)),'_whitenoise_0dB.wav'];              
                else
                    binaraul_list_azi35{binarual_count(8)}=[binarual_group_path,'b_',num2str(azi_single(k)),'_', num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),...
                    '\d_b_',num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),'_',num2str(Result.num(k)),'_whitenoise_0dB.wav'];
                end
                binarual_count(8)=binarual_count(8)+1;
                
           %% ����Դ��λ��Ϊ40ʱ                
            case 40  
                                %���ĳ����λ�µ���Դ˫���ź��ļ���
                binaraul_list_azi40{1}=[binarual_group_path,'b_',num2str(azi_single(k)),'_', num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),...
                     '\s_b_', num2str(azi_single(k)), '_whitenoise_0dB.wav'];
                 
                %���ĳ����λ�� ���۸�֪��ӽ�˫��Դ˫���ź��ļ���
                if Result.num(k)<10
                    binaraul_list_azi40{binarual_count(9)}=[binarual_group_path,'b_',num2str(azi_single(k)),'_', num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),...
                    '\d_b_',num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),'_0',num2str(Result.num(k)),'_whitenoise_0dB.wav'];              
                else
                    binaraul_list_azi40{binarual_count(9)}=[binarual_group_path,'b_',num2str(azi_single(k)),'_', num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),...
                    '\d_b_',num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),'_',num2str(Result.num(k)),'_whitenoise_0dB.wav'];
                end
                binarual_count(9)=binarual_count(9)+1;
        end       
    end   
end



%% ������˫��Դ˫���ź�ÿ���Ӵ�ILDȡֵ�������ʱ�� ILD����ͼ
if 1==flag_subbands_ILD
    figure;
    set(gcf,'color','w');%figure����ɫ��Ϊ��ɫ
    annotation(gcf,'textbox',[0.45 0.96 0.2 0.03],'String',{'���Ӵ��������ILD����ͼ'},'FontSize',14,'edgecolor',get(gcf,'color'));    
    for i=1:length(single_azi_list)
        no_figure_index_j=0;%no_figure_index_j��¼������ͼ���е�����j 
        switch single_azi_list(i)%single_azi_list(i)����Դ��λ 0:5:40
            case 0
                binaraul_list_azi=binaraul_list_azi0;
            case 5
                binaraul_list_azi=binaraul_list_azi5;
            case 10
                binaraul_list_azi=binaraul_list_azi10;
            case 15
                binaraul_list_azi=binaraul_list_azi15;
            case 20
                binaraul_list_azi=binaraul_list_azi20;
            case 25
                binaraul_list_azi=binaraul_list_azi25;
            case 30
                binaraul_list_azi=binaraul_list_azi30;
            case 35
                binaraul_list_azi=binaraul_list_azi35;
            case 40
                binaraul_list_azi=binaraul_list_azi40;              
        end        
        
        for j=1:length(right_loudspeaker_azi_list)
        %right_loudspeaker_azi_list(j)����������λ��[0 15 20 25 30 35 40 45]����0��ʾ����Դ���
        %������Դ��λ��λ��˫��Դ�����������н��ڻ���right_loudspeaker_azi_list(j)==0ʱ��ͼ
            if single_azi_list(i)<right_loudspeaker_azi_list(j)||right_loudspeaker_azi_list(j)==0
                k=figure_columns*(i-1)+j;%ͼ�ı��
                if right_loudspeaker_azi_list(j)==0%����Դ˫���źŻ�ͼ
                     %binaraul_list_azi ��˫��Դ˫���ź��ļ���·���б�
                     single_binaraul_file=binaraul_list_azi{1};%binaraul_list_azi{1}����Դ˫���ź��ļ���
                     single_subbands_ILD=get_subbands_ILD(single_binaraul_file); %single_subbands_ILDÿ��Ϊһ֡ 25���Ӵ�
                     subbands_number=size(single_subbands_ILD,2);%�Ӵ����� 25
                     subbands=1:subbands_number;%ͼ�ĺ����� �Ӵ����1:25
                     for p=1:subbands_number%p���Ӵ��ĸ���
                         %single_subbands_ILD(:,p)����֡�ĵ�p���Ӵ���ILD 
                         [f1, x1]=ksdensity(single_subbands_ILD(:,p));%���Ӵ�p��ILD���ʷֲ� f1��ʾ���� x1��ʾILD(˳����С����) 
                         [max_probability, max_probability_index]=max(f1);
                         single_max_probability_ILD(p)=x1(max_probability_index);%�Ӵ�p��������ILD,single_max_probability_ILD����Ϊ25 
                     end   
                     subplot(figure_rows, figure_columns ,k);    
                     plot(subbands,single_max_probability_ILD,'-g'); 
                     axis([1 25 -20 20]);
                     
                     %���õ�һ����ߵĵ���Դ��λ��˵��                   
                     switch single_azi_list(i)
                         case 0 
                             text(0,0,'0      ','horiz','right','vert','middle')
                             text(12.5,22,'����Դ','horiz','center','vert','bottom')
                         case 5 
                             text(0,0,'5      ','horiz','right','vert','middle')
                         case 10 
                             text(0,0,'10      ','horiz','right','vert','middle') 
                         case 15 
                             text(0,0,'15      ','horiz','right','vert','middle')
                         case 20 
                             text(0,0,'20      ','horiz','right','vert','middle')
                         case 25 
                             text(0,0,'25      ','horiz','right','vert','middle') 
                         case 30 
                             text(0,0,'30      ','horiz','right','vert','middle')
                         case 35 
                             text(0,0,'35      ','horiz','right','vert','middle')
                         case 40 
                             text(0,0,'40      ','horiz','right','vert','middle')                             
                     end
                             
                else%double_binaraul_file ˫��Դ˫���ź��ļ���  ���������뵥��Դ˫���ź���ͬ
                    double_binaraul_file=binaraul_list_azi{j-no_figure_index_j};%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    double_subbands_ILD=get_subbands_ILD(double_binaraul_file); 
                    for q=1:subbands_number
                         [f2, x2]=ksdensity(double_subbands_ILD(:,q));%��ÿ���Ӵ���ILD���ʷֲ�
                         [max_probability, max_probability_index]=max(f2);
                         double_max_probability_ILD(q)=x2(max_probability_index);
                    end
                    %����˫���ź�ILD���ʷֲ�����ͼ 
                    subplot(figure_rows, figure_columns ,k);     
                    plot(subbands,double_max_probability_ILD,'-b');                      
                    axis([1 25 -20 20]);
                    if i==1%��һ�мӱ���
                        switch right_loudspeaker_azi_list(j)
                             case 0 
                                 text(12.5,22,'����Դ','horiz','center','vert','bottom')
                             case 15 
                                 text(12.5,22,'[-15     15]','horiz','center','vert','bottom')
                             case 20 
                                 text(12.5,22,'[-20     20]','horiz','center','vert','bottom') 
                             case 25 
                                 text(12.5,22,'[-25     25]','horiz','center','vert','bottom')
                             case 30 
                                 text(12.5,22,'[-30     30]','horiz','center','vert','bottom')
                             case 35 
                                 text(12.5,22,'[-35     35]','horiz','center','vert','bottom')
                             case 40 
                                 text(12.5,22,'[-40     40]','horiz','center','vert','bottom')
                             case 45 
                                 text(12.5,22,'[-45     45]','horiz','center','vert','bottom')                          
                        end 
                   end
                end
                

                if j>1%û����������
                    set(gca,'ytick',[-20 -10 0 10 20])%����������̶�
                    set(gca,'yticklabel',[]);%����������̶��Ե�labelΪnull
                end
                if i>1%û�к�������
                    set(gca,'xtick',[5 10 15 20 25])%����������̶�
                    set(gca,'xticklabel',[]);%����������̶��Ե�labelΪnull
                end  
            else
               no_figure_index_j=j-1;%no_figure_index_j��¼������ͼ���е�����j  ע����j-1 
            end
        end
    end     
end




%% ������˫��Դ˫���ź��Ӵ�ILD �ĸ����ܶ�ͼ  ����֡��ILD���������� 
if 1==flag_signal_ILD_ksdensity
    figure;
    set(gcf,'color','w');%figure����ɫ��Ϊ��ɫ
    annotation(gcf,'textbox',[0.45 0.96 0.2 0.03],'String',{'ILD�����ܶ�ͼ'},'FontSize',14,'edgecolor',get(gcf,'color')); 
    for i=1:length(single_azi_list)
        no_figure_index_j=0;%no_figure_index_j��¼������ͼ���е�����j 
        switch single_azi_list(i)%single_azi_list(i)����Դ��λ 0:5:40
            case 0
                binaraul_list_azi=binaraul_list_azi0;
            case 5
                binaraul_list_azi=binaraul_list_azi5;
            case 10
                binaraul_list_azi=binaraul_list_azi10;
            case 15
                binaraul_list_azi=binaraul_list_azi15;
            case 20
                binaraul_list_azi=binaraul_list_azi20;
            case 25
                binaraul_list_azi=binaraul_list_azi25;
            case 30
                binaraul_list_azi=binaraul_list_azi30;
            case 35
                binaraul_list_azi=binaraul_list_azi35;
            case 40
                binaraul_list_azi=binaraul_list_azi40;              
        end        
        
        for j=1:length(right_loudspeaker_azi_list)
        %right_loudspeaker_azi_list(j)����������λ��[0 15 20 25 30 35 40 45]����0��ʾ����Դ���
        %������Դ��λ��λ��˫��Դ�����������н��ڻ���right_loudspeaker_azi_list(j)==0ʱ��ͼ
            if single_azi_list(i)<right_loudspeaker_azi_list(j)||right_loudspeaker_azi_list(j)==0
                k=figure_columns*(i-1)+j;%ͼ�ı��
                if right_loudspeaker_azi_list(j)==0%����Դ˫���źŻ�ͼ
                     %binaraul_list_azi ��˫��Դ˫���ź��ļ���·���б�
                     single_binaraul_file=binaraul_list_azi{1};%binaraul_list_azi{1}����Դ˫���ź��ļ���
                     single_subbands_ILD=get_subbands_ILD(single_binaraul_file); %single_subbands_ILDÿ��Ϊһ֡ 25���Ӵ�
                     single_ild_rows_num=size(single_subbands_ILD,1);
                     single_ild_col_num=size(single_subbands_ILD,2);                         
                     %reshape ��Ҫת�� single_subbands_ILD' double_subbands_ILD'
                     temp_single_ILD=reshape(single_subbands_ILD',[1,single_ild_rows_num*single_ild_col_num]);
                     [f1, x1]=ksdensity(temp_single_ILD);  
                     subplot(figure_rows, figure_columns ,k);    
                     plot(x1,f1,'-g'); 
                     axis([-20 20 0 0.5]);
                     
                     %���õ�һ����ߵĵ���Դ��λ��˵��                   
                     switch single_azi_list(i)
                         case 0 
                             text(-20,0.25,'0           ','horiz','right','vert','middle')
                             text(12.5,12,'����Դ','horiz','center','vert','bottom')
                         case 5 
                             text(-20,0.25,'5           ','horiz','right','vert','middle')
                         case 10 
                             text(-20,0.25,'10          ','horiz','right','vert','middle') 
                         case 15 
                             text(-20,0.25,'15          ','horiz','right','vert','middle')
                         case 20 
                             text(-20,0.25,'20          ','horiz','right','vert','middle')
                         case 25 
                             text(-20,0.25,'25          ','horiz','right','vert','middle') 
                         case 30 
                             text(-20,0.25,'30          ','horiz','right','vert','middle')
                         case 35 
                             text(-20,0.25,'35          ','horiz','right','vert','middle')
                         case 40 
                             text(-20,0.25,'40          ','horiz','right','vert','middle')                             
                     end
                             
                else%double_binaraul_file ˫��Դ˫���ź��ļ���  ���������뵥��Դ˫���ź���ͬ
                    double_binaraul_file=binaraul_list_azi{j-no_figure_index_j};%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    double_subbands_ILD=get_subbands_ILD(double_binaraul_file); 
                    double_ild_rows_num=size(double_subbands_ILD,1);
                    double_ild_col_num=size(double_subbands_ILD,2);
                    %reshape ��Ҫת�� single_subbands_ILD' double_subbands_ILD'
                    temp_double_ILD=reshape(double_subbands_ILD',[1,double_ild_rows_num*double_ild_col_num]);
                    [f2, x2]=ksdensity(temp_double_ILD);
                    %����˫���ź�ILD���ʷֲ�����ͼ 
                    subplot(figure_rows, figure_columns ,k);     
                    plot(x2,f2,'-b');                      
                    axis([-20 20 0 0.5]);
                    if i==1%��һ�мӱ���
                        switch right_loudspeaker_azi_list(j)
                             case 0 
                                 text(0,0.5,'����Դ','horiz','center','vert','bottom')
                             case 15 
                                 text(0,0.5,'[-15     15]','horiz','center','vert','bottom')
                             case 20 
                                 text(0,0.5,'[-20     20]','horiz','center','vert','bottom') 
                             case 25 
                                 text(0,0.5,'[-25     25]','horiz','center','vert','bottom')
                             case 30 
                                 text(0,0.5,'[-30     30]','horiz','center','vert','bottom')
                             case 35 
                                 text(0,0.5,'[-35     35]','horiz','center','vert','bottom')
                             case 40 
                                 text(0,0.5,'[-40     40]','horiz','center','vert','bottom')
                             case 45 
                                 text(0,0.5,'[-45     45]','horiz','center','vert','bottom')                          
                        end 
                   end
                end
                

                if j>1%û����������
                    set(gca,'ytick',[0.1 0.2 0.3 0.4 0.5])%������������̶�
                    set(gca,'yticklabel',[]);%������������̶��Ե�labelΪnull
                end
                if i>1%û�к�������
                    set(gca,'xtick',-20:5:20)%���ú�������̶�
                    set(gca,'xticklabel',[]);%���ú�������̶��Ե�labelΪnull
                end  
            else
               no_figure_index_j=j-1;%no_figure_index_j��¼������ͼ���е�����j  ע����j-1 
            end
        end
    end     

end



%% ��˫��Դ˫���ź��Ӵ�ILD  ���Ӵ���ƽ�� ��single_subbands_ILD,double_subbands_ILD������ƽ���� 
if 1==flag_mean_ILD
    figure;
    set(gcf,'color','w');%figure����ɫ��Ϊ��ɫ
    annotation(gcf,'textbox',[0.45 0.96 0.2 0.03],'String',{'���Ӵ�ILD��ֵ����ͼ'},'FontSize',14,'edgecolor',get(gcf,'color'));       
    for i=1:length(single_azi_list)
        no_figure_index_j=0;%no_figure_index_j��¼������ͼ���е�����j 
        switch single_azi_list(i)%single_azi_list(i)����Դ��λ 0:5:40
            case 0
                binaraul_list_azi=binaraul_list_azi0;
            case 5
                binaraul_list_azi=binaraul_list_azi5;
            case 10
                binaraul_list_azi=binaraul_list_azi10;
            case 15
                binaraul_list_azi=binaraul_list_azi15;
            case 20
                binaraul_list_azi=binaraul_list_azi20;
            case 25
                binaraul_list_azi=binaraul_list_azi25;
            case 30
                binaraul_list_azi=binaraul_list_azi30;
            case 35
                binaraul_list_azi=binaraul_list_azi35;
            case 40
                binaraul_list_azi=binaraul_list_azi40;              
        end        
        
        for j=1:length(right_loudspeaker_azi_list)
        %right_loudspeaker_azi_list(j)����������λ��[0 15 20 25 30 35 40 45]����0��ʾ����Դ���
        %������Դ��λ��λ��˫��Դ�����������н��ڻ���right_loudspeaker_azi_list(j)==0ʱ��ͼ
            if single_azi_list(i)<right_loudspeaker_azi_list(j)||right_loudspeaker_azi_list(j)==0
                k=figure_columns*(i-1)+j;%ͼ�ı��
                if right_loudspeaker_azi_list(j)==0%����Դ˫���źŻ�ͼ
                     %binaraul_list_azi ��˫��Դ˫���ź��ļ���·���б�
                     single_binaraul_file=binaraul_list_azi{1};%binaraul_list_azi{1}����Դ˫���ź��ļ���
                     single_subbands_ILD=get_subbands_ILD(single_binaraul_file); %single_subbands_ILDÿ��Ϊһ֡ 25���Ӵ�
                     subbands_number=size(single_subbands_ILD,2);%�Ӵ����� 25
                     subbands=1:subbands_number;%ͼ�ĺ����� �Ӵ����1:25
                     %��˫��Դ˫���ź��Ӵ�ILD  ���Ӵ���ƽ�� ��single_subbands_ILD,double_subbands_ILD������ƽ���� 
                     for m=1:size(single_subbands_ILD,2)
                        single_mean_ILD(m)=mean(single_subbands_ILD(:,m));
                     end  
                     subplot(figure_rows, figure_columns ,k);    
                     plot(subbands,single_mean_ILD,'-g'); 
                     axis([1 25 -20 20]);
                     
                    %���õ�һ����ߵĵ���Դ��λ��˵��                   
                     switch single_azi_list(i)
                         case 0 
                             text(-8,0,'0','horiz','right','vert','middle')
                             text(12.5,22,'����Դ','horiz','center','vert','bottom')
                         case 5 
                             text(-8,0,'5','horiz','right','vert','middle')
                         case 10 
                             text(-8,0,'10','horiz','right','vert','middle') 
                         case 15 
                             text(-8,0,'15','horiz','right','vert','middle')
                         case 20 
                             text(-8,0,'20','horiz','right','vert','middle')
                         case 25 
                             text(-8,0,'25','horiz','right','vert','middle') 
                         case 30 
                             text(-8,0,'30','horiz','right','vert','middle')
                         case 35 
                             text(-8,0,'35','horiz','right','vert','middle')
                         case 40 
                             text(-8,0,'40','horiz','right','vert','middle')                             
                     end
                             
                else%double_binaraul_file ˫��Դ˫���ź��ļ���  ���������뵥��Դ˫���ź���ͬ
                    double_binaraul_file=binaraul_list_azi{j-no_figure_index_j};%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    double_subbands_ILD=get_subbands_ILD(double_binaraul_file); 
                    for m=1:size(double_subbands_ILD,2)
                        double_mean_ILD(m)=mean(double_subbands_ILD(:,m));
                    end  
                    subplot(figure_rows, figure_columns ,k);     
                    plot(subbands,double_mean_ILD,'-b');                      
                    axis([1 25 -20 20]);
                    if i==1%��һ�мӱ���
                        switch right_loudspeaker_azi_list(j)
                             case 0 
                                 text(12.5,22,'����Դ','horiz','center','vert','bottom')
                             case 15 
                                 text(12.5,22,'[-15     15]','horiz','center','vert','bottom')
                             case 20 
                                 text(12.5,22,'[-20     20]','horiz','center','vert','bottom') 
                             case 25 
                                 text(12.5,22,'[-25     25]','horiz','center','vert','bottom')
                             case 30 
                                 text(12.5,22,'[-30     30]','horiz','center','vert','bottom')
                             case 35 
                                 text(12.5,22,'[-35     35]','horiz','center','vert','bottom')
                             case 40 
                                 text(12.5,22,'[-40     40]','horiz','center','vert','bottom')
                             case 45 
                                 text(12.5,22,'[-45     45]','horiz','center','vert','bottom')                          
                        end 
                   end
                end
                

                if j>1%û����������
                %set(gca,'ytick',0:2:10)%������������̶�  
                    set(gca,'yticklabel',[]);%������������̶��Ե�labelΪnull
                end
                if i>1%û�к�������
                %set(gca,'xtick',5:5:25)%���ú�������̶�
                    set(gca,'xticklabel',[]);%���ú�������̶��Ե�labelΪnull
                end  
            else
               no_figure_index_j=j-1;%no_figure_index_j��¼������ͼ���е�����j  ע����j-1 
            end
        end
    end     
end
%% 







