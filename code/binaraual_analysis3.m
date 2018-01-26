%������������������ʵ��õ���˫���źŽ��з�����������������������������������
clc;
clear all;
initpath();
flag_gain_ratio=1;
flag_signal_figure=0;
flag_signal_ILD=0;%1:����֡��ILD����������;   
binarual_signal_basepath='.\binarualsignal\';
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
    %��ȡVBAP ��Ӧsingle_azi�����棨�������棩     
    for j=1:length(azi_single)
        VBAP_gain_factor(j,:)=get_init_gain(azi_loudspeaker,azi_single(j));
    end

    %���۲�����ӽ�  left_gain
    subject_left_gain=Result.left_gain;
    VBAP_left_gain=VBAP_gain_factor(:,1);
    subject_left_gain=subject_left_gain';
    subject_left_gain(find(subject_left_gain==0))=eps;
    VBAP_left_gain(find(VBAP_left_gain==0))=eps;
    
    VBAP_gain_ratio=VBAP_left_gain./sqrt(1-VBAP_left_gain.^2);
    subject_gain_ratio=subject_left_gain./sqrt(1-subject_left_gain.^2);
    
    if 1==flag_gain_ratio
        figure;
        plot(azi_single,VBAP_gain_ratio,'-*r');
        hold on;
        plot(azi_single,subject_gain_ratio,'-og');

        xlabel('����Դ��λ��');
        ylabel('���������������');
        title([Result.loud_speaker_azi,  '���۸�֪��VBAP���Ƶ�����������ƫ��']);%����������λ�����ֲ�ͬ�Ĳ�����
        legend('VBAP���Ƶ������������','���۸�֪����Ӧ�������������');
    end  
    
   
        %˫���źŲ������ ���ļ��У�ÿ�����ļ���  ���Ǹ��������� ĳ������Դ��λ�µĲ����źţ�  
    for k=1:length(Result.num)%�ҵ����۸�֪��ӽ���˫��Դ˫���źŵ� �ļ��� 
        %���ĳ����λ�µ���Դ˫���ź��ļ���
        single_binaraul_file=[binarual_group_path,'b_',num2str(azi_single(k)),'_', num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),...
        '\s_b_', num2str(azi_single(k)), '_whitenoise_0dB.wav'];

        %���ĳ����λ�� ���۸�֪��ӽ�˫��Դ˫���ź��ļ���
        if Result.num(k)<10
            double_binaraul_file=[binarual_group_path,'b_',num2str(azi_single(k)),'_', num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),...
            '\d_b_',num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),'_0',num2str(Result.num(k)),'_whitenoise_0dB.wav'];              
        else
            double_binaraul_file=[binarual_group_path,'b_',num2str(azi_single(k)),'_', num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),...
            '\d_b_',num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),'_',num2str(Result.num(k)),'_whitenoise_0dB.wav'];
        end

        if 1==flag_signal_figure
              [single_wav_data fs nbits]=wavread(single_binaraul_file);
              [double_wav_data fs nbits]=wavread(double_binaraul_file);  
              %����˫���źŲ���ͼ 
              figure       
              subplot(2 ,1, 1);
              plot(single_wav_data,'-g'); 
              title(['[',num2str(azi_loudspeaker(1)),'  ',num2str(azi_single(k)),'  ',num2str(azi_loudspeaker(2)),']','  ˫���źŲ���ͼ']);%����������λ�����ֲ�ͬ�Ĳ�����
              subplot(2 ,1, 2);
              plot(double_wav_data,'-b'); 
        end
                     
        %������˫��Դ˫���ź��Ӵ�ILD ����ͼ   ����֡��ILD���������� 
        if 1==flag_signal_ILD
             %����Դ˫���ź��Ӵ�ILD
             single_subbands_ILD=get_subbands_ILD(single_binaraul_file); 
             single_ild_rows_num=size(single_subbands_ILD,1);
             single_ild_col_num=size(single_subbands_ILD,2);                         
             %˫��Դ˫���ź��Ӵ�ILD
             double_subbands_ILD=get_subbands_ILD(double_binaraul_file); 
             double_ild_rows_num=size(double_subbands_ILD,1);
             double_ild_col_num=size(double_subbands_ILD,2);
             %reshape ��Ҫת�� single_subbands_ILD' double_subbands_ILD'
             temp_single_ILD=reshape(single_subbands_ILD',[1,single_ild_rows_num*single_ild_col_num]);
             temp_double_ILD=reshape(double_subbands_ILD',[1,double_ild_rows_num*double_ild_col_num]);
             %����˫���ź�ILD����ͼ 
             %if azi_single(k)==0
             figure;     
             subplot(2 ,1, 1);
             plot(temp_single_ILD,'-g'); 
             title(['[',num2str(azi_loudspeaker(1)),'  ',num2str(azi_single(k)),'  ',num2str(azi_loudspeaker(2)),']','  ˫���ź�ILD����ͼ']);%����������λ�����ֲ�ͬ�Ĳ�����
             subplot(2 ,1, 2);
             plot(temp_double_ILD,'-b'); 
             %end
        end
        
    end   
end







