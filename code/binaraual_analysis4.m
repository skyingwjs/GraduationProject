%������������������ʵ��õ���˫���źŽ��з�����������������������������������
clc;
clear all;
initpath();
flag_binaraul_list_azi=0;%ȡֵ��0:5:40 ��־ĳ��single_azi�� ��˫��Դ˫���ź�ILD�Ա�

flag_signal_figure=0;%�����źŲ���ͼ
flag_signal_ILD=0;%1:����֡��ILD����������; 
flag_mean_ILD=1;%1:����֡���Ӵ���ƽ��ֵ ��ͼ   
flag_signal_ILD_ksdensity=0;%ILD�����ܶȷֲ�ͼ
flag_points_ILD=0;%������˫��Դ˫���ź�ÿ��Ƶ��ILDȡֵ�������ʱ�� ILD����ͼ
flag_subbands_ILD=0;%������˫��Դ˫���ź�ÿ���Ӵ�ILDȡֵ�������ʱ�� ILD����ͼ

binarual_signal_basepath='.\binarualsignal\';
binarual_count=2*ones(9,1);%�ֱ��Ӧ����single_azi(0:5:40)�µ�˫��Դ˫���źż���


xls_file_name='result(����ɽ).xlsx';
sheet='result';
xls_range='B1:G8';
[ndata txt alldata]=xlsread(xls_file_name,sheet,xls_range);

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
            azi_loudspeaker=[-15 15];
            binarual_group_path=[binarual_signal_basepath,'b_-15_15\'];%ĳ�������飨ĳ�������������£���˫���ź�·��
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
        
    azi_single=Result.single_azi;
 
   
    %˫���źŲ������ ���ļ��У�ÿ�����ļ���  ���Ǹ��������� ĳ������Դ��λ�µĲ����źţ�  
    for k=1:length(Result.num)%������Դsingle_azi�Ĳ�ͬ���飨0:5:40��   �ҵ����۸�֪��ӽ���˫��Դ˫���źŵ� �ļ��� 
        switch azi_single(k)
           %% ����Դ��λ��Ϊ0ʱ
            case 0                
                %���ĳ����λ�µ���Դ˫���ź��ļ���
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
                
                
           %% ����Դ��λ��Ϊ05ʱ                   
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

switch flag_binaraul_list_azi
    case 0
        binaraul_list_azi=binaraul_list_azi0;
        figure_single_azi='0';%��ͼ������ʾ  ����Դ��λ�� 
        figure_loudspeaker_azi={'[-15 15]','[-20 20]','[-25 25]','[-30 30]','[-35 35]','[-40 40]','[-45 45]'};%��ͼ������ʾ  ���������÷�λ�� 
    case 5
        binaraul_list_azi=binaraul_list_azi5;
        figure_single_azi='5';%��ͼ������ʾ  ����Դ��λ�� 
        figure_loudspeaker_azi={'[-15 15]','[-20 20]','[-25 25]','[-30 30]','[-35 35]','[-40 40]','[-45 45]'};%��ͼ������ʾ  ���������÷�λ��        
    case 10
        binaraul_list_azi=binaraul_list_azi10;     
        figure_single_azi='10';%��ͼ������ʾ  ����Դ��λ�� 
        figure_loudspeaker_azi={'[-15 15]','[-20 20]','[-25 25]','[-30 30]','[-35 35]','[-40 40]','[-45 45]'};%��ͼ������ʾ  ���������÷�λ��        
    case 15
        binaraul_list_azi=binaraul_list_azi15;
        figure_single_azi='15';%��ͼ������ʾ  ����Դ��λ�� 
        figure_loudspeaker_azi={'[-20 20]','[-25 25]','[-30 30]','[-35 35]','[-40 40]','[-45 45]'};%��ͼ������ʾ  ���������÷�λ��        
    case 20
        binaraul_list_azi=binaraul_list_azi20;
        figure_single_azi='20';%��ͼ������ʾ  ����Դ��λ�� 
        figure_loudspeaker_azi={'[-25 25]','[-30 30]','[-35 35]','[-40 40]','[-45 45]'};%��ͼ������ʾ  ���������÷�λ��        
    case 25
        binaraul_list_azi=binaraul_list_azi25;
        figure_single_azi='25';%��ͼ������ʾ  ����Դ��λ�� 
        figure_loudspeaker_azi={'[-30 30]','[-35 35]','[-40 40]','[-45 45]'};%��ͼ������ʾ  ���������÷�λ��        
    case 30
        binaraul_list_azi=binaraul_list_azi30;
        figure_single_azi='30';%��ͼ������ʾ  ����Դ��λ�� 
        figure_loudspeaker_azi={'[-35 35]','[-40 40]','[-45 45]'};%��ͼ������ʾ  ���������÷�λ��        
    case 35
        binaraul_list_azi=binaraul_list_azi35;
        figure_single_azi='35';%��ͼ������ʾ  ����Դ��λ�� 
        figure_loudspeaker_azi={'[-40 40]','[-45 45]'};%��ͼ������ʾ  ���������÷�λ��        
    case 40 
        binaraul_list_azi=binaraul_list_azi40;
        figure_single_azi='40';%��ͼ������ʾ  ����Դ��λ�� 
        figure_loudspeaker_azi={'[-45 45]'};%��ͼ������ʾ  ���������÷�λ��        
end

binaraul_list_len=length(binaraul_list_azi);
figure_rows=ceil(binaraul_list_len/2);


%% single_azi==0ʱ�ĵ�˫��Դ˫���źŲ���ͼ
if 1==flag_signal_figure
     figure;      
     single_binaraul_file=binaraul_list_azi{1};
     [single_wav_data fs nbits]=wavread(single_binaraul_file);  
     subplot(figure_rows ,2, 1);
     plot(single_wav_data,'-g');    
     xlabel('������','fontsize',8);
     ylabel('�źŷ���','fontsize',8);
     title(['����Դ��λ' figure_single_azi '��ʱ˫���ź�'],'fontsize',8);%����������λ�����ֲ�ͬ�Ĳ�����     
     for i=2:length(binaraul_list_azi)                                
         double_binaraul_file=binaraul_list_azi{i};
         [double_wav_data fs nbits]=wavread(double_binaraul_file); 
         subplot(figure_rows ,2, i);
         plot(double_wav_data,'-b'); 
         xlabel('������','fontsize',8);
         ylabel('�źŷ���','fontsize',8);
         title(['����������Ϊ' figure_loudspeaker_azi{i-1} 'ʱ˫���ź�'],'fontsize',8);%����������λ�����ֲ�ͬ�Ĳ�����         
     end        
end

%% ������˫��Դ˫���ź��Ӵ�ILD �ĸ����ܶ�ͼ  ����֡��ILD���������� 
if 1==flag_signal_ILD_ksdensity
     figure;  
     %����Դ˫���ź��Ӵ�ILD
     single_binaraul_file=binaraul_list_azi{1};
     single_subbands_ILD=get_subbands_ILD(single_binaraul_file); 
     single_ild_rows_num=size(single_subbands_ILD,1);
     single_ild_col_num=size(single_subbands_ILD,2);                         
     %reshape ��Ҫת�� single_subbands_ILD' double_subbands_ILD'
     temp_single_ILD=reshape(single_subbands_ILD',[1,single_ild_rows_num*single_ild_col_num]);
     [f1, x1]=ksdensity(temp_single_ILD);
     %����˫���ź�ILD���ʷֲ�����ͼ 
     subplot(figure_rows ,2, 1);     
     plot(x1,f1,'-g'); 
     xlabel('ILD(dB)','fontsize',8);
     ylabel('ILD���ʷֲ�','fontsize',8);
     title(['����Դ��λ' figure_single_azi '��ʱ˫���ź�ILD���ʷֲ�'],'fontsize',8);
     axis([-25 25 0 0.5]);
     
     for i=2:length(binaraul_list_azi)                        
         %˫��Դ˫���ź��Ӵ�ILD
         double_binaraul_file=binaraul_list_azi{i};
         double_subbands_ILD=get_subbands_ILD(double_binaraul_file); 
         double_ild_rows_num=size(double_subbands_ILD,1);
         double_ild_col_num=size(double_subbands_ILD,2);
         %reshape ��Ҫת�� single_subbands_ILD' double_subbands_ILD'
         temp_double_ILD=reshape(double_subbands_ILD',[1,double_ild_rows_num*double_ild_col_num]);
         [f2, x2]=ksdensity(temp_double_ILD);
         %����˫���ź�ILD���ʷֲ�����ͼ 
         subplot(figure_rows ,2, i);     
         plot(x2,f2,'-b'); 
         xlabel('ILD(dB)','fontsize',8);
         ylabel('ILD���ʷֲ�','fontsize',8);
         title(['����������Ϊ' figure_loudspeaker_azi{i-1} 'ʱ˫���ź�ILD�����ܶ�'],'fontsize',8);
         axis([-25 25 0 0.2]);
     end        
end

%% ������˫��Դ˫���ź�ÿ���Ӵ�ILDȡֵ�������ʱ�� ILD����ͼ
if 1==flag_subbands_ILD
    
     %����Դ˫���ź��Ӵ�ILD
     single_binaraul_file=binaraul_list_azi{1};
     single_subbands_ILD=get_subbands_ILD(single_binaraul_file); %single_subbands_ILDÿ��Ϊһ֡
     subbands_number=size(single_subbands_ILD,2);
     subbands=1:subbands_number;
     for p=1:subbands_number%p���Ӵ��ĸ���
         [f1, x1]=ksdensity(single_subbands_ILD(:,p));%��ÿ���Ӵ���ILD���ʷֲ�
         [max_probability, max_probability_index]=max(f1);
         single_max_probability_ILD(p)=x1(max_probability_index);
     end   
     figure;  
     subplot(figure_rows ,2, 1);     
     plot(subbands,single_max_probability_ILD,'-g'); 
     xlabel('�Ӵ�','fontsize',8);
     ylabel('�Ӵ��ϸ������ILD(dB)','fontsize',8);    
     title(['����Դ��λ' figure_single_azi '��ʱ˫���ź��Ӵ�ILD'],'fontsize',8);
     axis([1 25 -10 10]);
     
     for i=2:length(binaraul_list_azi)                        
         %˫��Դ˫���ź��Ӵ�ILD
         double_binaraul_file=binaraul_list_azi{i};
         double_subbands_ILD=get_subbands_ILD(double_binaraul_file); 
         for q=1:subbands_number%q��Ƶ����
             [f2, x2]=ksdensity(double_subbands_ILD(:,q));%��ÿ���Ӵ���ILD���ʷֲ�
             [max_probability, max_probability_index]=max(f2);
             double_max_probability_ILD(q)=x2(max_probability_index);
         end
         %����˫���ź�ILD���ʷֲ�����ͼ 
         subplot(figure_rows ,2, i);     
         plot(subbands,double_max_probability_ILD,'-b'); 
         xlabel('�Ӵ�','fontsize',8);
         ylabel('�Ӵ��ϸ������ILD(dB)','fontsize',8);    
         title(['����������Ϊ' figure_loudspeaker_azi{i-1} 'ʱ˫���ź��Ӵ�ILD'],'fontsize',8);
         axis([1 25 -10 10]);
     end        
end



%% ������˫��Դ˫���ź�ÿ��Ƶ��ILDȡֵ�������ʱ�� ILD����ͼ
if 1==flag_points_ILD
    
     %����Դ˫���ź��Ӵ�ILD
     single_binaraul_file=binaraul_list_azi{1};
     single_points_ILD=get_points_ILD(single_binaraul_file); %single_points_ILDÿ��Ϊһ֡
     points_number=size(single_points_ILD,1);
     points=1:points_number;
     for p=1:points_number%p��Ƶ�����
         [f1, x1]=ksdensity(single_points_ILD(p,:));%��ÿ��Ƶ���ILD���ʷֲ�
         [max_probability, max_probability_index]=max(f1);
         single_max_probability_ILD(p)=x1(max_probability_index);
     end   
     figure;  
     %����˫���ź�ILD���ʷֲ�����ͼ 
     subplot(figure_rows ,2, 1);     
     plot(points,single_max_probability_ILD,'-g'); 
     xlabel('Ƶ��','fontsize',8);
     ylabel('Ƶ���ϸ������ILD(dB)','fontsize',8);    
     title(['����Դ��λ' figure_single_azi '��ʱ˫���ź�Ƶ��ILD'],'fontsize',8);
     axis([1 1024 -10 10]);
     
     for i=2:length(binaraul_list_azi)                        
         %˫��Դ˫���ź��Ӵ�ILD
         double_binaraul_file=binaraul_list_azi{i};
         double_points_ILD=get_points_ILD(double_binaraul_file); 
         for q=1:points_number%q��Ƶ����
             [f2, x2]=ksdensity(double_points_ILD(q,:));%��ÿ��Ƶ���ILD���ʷֲ�
             [max_probability, max_probability_index]=max(f2);
             double_max_probability_ILD(q)=x2(max_probability_index);
         end
         %����˫���ź�ILD���ʷֲ�����ͼ 
         subplot(figure_rows ,2, i);     
         plot(points,double_max_probability_ILD,'-b'); 
         xlabel('Ƶ��','fontsize',8);
         ylabel('Ƶ���ϸ������ILD(dB)','fontsize',8);    
         title(['����������Ϊ' figure_loudspeaker_azi{i-1} 'ʱ˫���ź�Ƶ��ILD'],'fontsize',8);
         axis([1 1024 -10 10]);
     end        
end


%% single_azi==0ʱ ������˫��Դ˫���ź��Ӵ�ILD ����ͼ   ����֡��ILD���������� 
if 1==flag_signal_ILD
     figure;  
     %����Դ˫���ź��Ӵ�ILD
     single_binaraul_file=binaraul_list_azi{1};
     single_subbands_ILD=get_subbands_ILD(single_binaraul_file); 
     single_ild_rows_num=size(single_subbands_ILD,1);
     single_ild_col_num=size(single_subbands_ILD,2);                         
     %reshape ��Ҫת�� single_subbands_ILD' double_subbands_ILD'
     temp_single_ILD=reshape(single_subbands_ILD',[1,single_ild_rows_num*single_ild_col_num]);

     %����˫���ź�ILD����ͼ 
     subplot(figure_rows ,2, 1);
     plot(temp_single_ILD,'-g'); 
     xlabel('�Ӵ����','fontsize',8);
     ylabel('ILD(dB)','fontsize',8);
     title(['����������Ϊ' figure_loudspeaker_azi{i-1} 'ʱ˫���ź�ILD�����ܶ�'],'fontsize',8);
     
     for i=2:length(binaraul_list_azi)                        
         %˫��Դ˫���ź��Ӵ�ILD
         double_binaraul_file=binaraul_list_azi{i};
         double_subbands_ILD=get_subbands_ILD(double_binaraul_file); 
         double_ild_rows_num=size(double_subbands_ILD,1);
         double_ild_col_num=size(double_subbands_ILD,2);
         %reshape ��Ҫת�� single_subbands_ILD' double_subbands_ILD'
         temp_double_ILD=reshape(double_subbands_ILD',[1,double_ild_rows_num*double_ild_col_num]);
        
         subplot(figure_rows ,2, i);
         plot(temp_double_ILD,'-b'); 
         xlabel('�Ӵ����','fontsize',8);
         ylabel('ILD(dB)','fontsize',8);
         title(['����������Ϊ' figure_loudspeaker_azi{i-1} 'ʱ˫���ź�ILD'],'fontsize',8);
     end        
end

%% ��˫��Դ˫���ź��Ӵ�ILD  ���Ӵ���ƽ�� ��single_subbands_ILD,double_subbands_ILD������ƽ���� 
if 1==flag_mean_ILD
     figure;  
     %����Դ˫���ź��Ӵ�ILD
     single_binaraul_file=binaraul_list_azi{1};
     single_subbands_ILD=get_subbands_ILD(single_binaraul_file); 
     save single_subbands_ILD.mat single_subbands_ILD
     %��˫��Դ˫���ź��Ӵ�ILD  ���Ӵ���ƽ�� ��single_subbands_ILD,double_subbands_ILD������ƽ���� 
     for m=1:size(single_subbands_ILD,2)
        single_mean_ILD(m)=mean(single_subbands_ILD(:,m));
     end     
          
     %����˫���ź��Ӵ�ƽ�� ILD����ͼ 
     subplot(figure_rows ,2, 1);
     plot(single_mean_ILD,'-g'); 
     xlabel('�Ӵ����','fontsize',8);
     ylabel('ILD(dB)','fontsize',8);
     title(['����Դ��λ' figure_single_azi '��ʱ˫���ź�ILD'],'fontsize',8);%����������λ�����ֲ�ͬ�Ĳ�����
     
     for i=2:length(binaraul_list_azi)                        
         %˫��Դ˫���ź��Ӵ�ILD
         double_binaraul_file=binaraul_list_azi{i};
         double_subbands_ILD=get_subbands_ILD(double_binaraul_file); 
%          mat_file_name='double_subbands_ILD.mat';
%          save( mat_file_name,'double_subbands_ILD');
         save double_subbands_ILD.mat double_subbands_ILD;
         % ��˫��Դ˫���ź��Ӵ�ILD  ���Ӵ���ƽ�� ��single_subbands_ILD,double_subbands_ILD������ƽ���� 
         for m=1:size(double_subbands_ILD,2)
            double_mean_ILD(m)=mean(double_subbands_ILD(:,m));
         end      
         subplot(figure_rows ,2, i);
         plot(double_mean_ILD,'-b'); 
         xlabel('�Ӵ����','fontsize',8);
         ylabel('ILD(dB)','fontsize',8);
         title(['����������Ϊ' figure_loudspeaker_azi{i-1} 'ʱ˫���ź�ILD'],'fontsize',8);%����������λ�����ֲ�ͬ�Ĳ�����
     end            
end
%% 







