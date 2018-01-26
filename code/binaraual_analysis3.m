%———————根据实验得到的双耳信号进行分析————————————————
clc;
clear all;
initpath();
flag_gain_ratio=1;
flag_signal_figure=0;
flag_signal_ILD=0;%1:所有帧的ILD连成行向量;   
binarual_signal_basepath='.\binarualsignal\';
xls_file_name='result(王金山).xlsx';
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
    
    %确定左右扬声器方位     
    switch Result.loud_speaker_azi
        case '(-15,15)'
            azi_loudspeaker=[-15 15];
            binarual_group_path=[binarual_signal_basepath,'b_-15_15\'];%某个测试组（某种扬声器配置下）的双耳信号路径
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
    %获取VBAP 对应single_azi的增益（左右增益）     
    for j=1:length(azi_single)
        VBAP_gain_factor(j,:)=get_init_gain(azi_loudspeaker,azi_single(j));
    end

    %主观测试最接近  left_gain
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

        xlabel('单声源方位角');
        ylabel('左右扬声器增益比');
        title([Result.loud_speaker_azi,  '主观感知与VBAP估计的扬声器增益偏差']);%由扬声器方位来区分不同的测试组
        legend('VBAP估计的扬声器增益比','主观感知所对应的扬声器增益比');
    end  
    
   
        %双耳信号测试组的 子文件夹（每个子文件夹  就是该种配置下 某个单声源方位下的测试信号）  
    for k=1:length(Result.num)%找到主观感知最接近的双声源双耳信号的 文件名 
        %获得某个方位下单声源双耳信号文件名
        single_binaraul_file=[binarual_group_path,'b_',num2str(azi_single(k)),'_', num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),...
        '\s_b_', num2str(azi_single(k)), '_whitenoise_0dB.wav'];

        %获得某个方位下 主观感知最接近双声源双耳信号文件名
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
              %画出双耳信号波形图 
              figure       
              subplot(2 ,1, 1);
              plot(single_wav_data,'-g'); 
              title(['[',num2str(azi_loudspeaker(1)),'  ',num2str(azi_single(k)),'  ',num2str(azi_loudspeaker(2)),']','  双耳信号波形图']);%由扬声器方位来区分不同的测试组
              subplot(2 ,1, 2);
              plot(double_wav_data,'-b'); 
        end
                     
        %画出单双声源双耳信号子带ILD 波形图   所有帧的ILD连成行向量 
        if 1==flag_signal_ILD
             %单声源双耳信号子带ILD
             single_subbands_ILD=get_subbands_ILD(single_binaraul_file); 
             single_ild_rows_num=size(single_subbands_ILD,1);
             single_ild_col_num=size(single_subbands_ILD,2);                         
             %双声源双耳信号子带ILD
             double_subbands_ILD=get_subbands_ILD(double_binaraul_file); 
             double_ild_rows_num=size(double_subbands_ILD,1);
             double_ild_col_num=size(double_subbands_ILD,2);
             %reshape 需要转置 single_subbands_ILD' double_subbands_ILD'
             temp_single_ILD=reshape(single_subbands_ILD',[1,single_ild_rows_num*single_ild_col_num]);
             temp_double_ILD=reshape(double_subbands_ILD',[1,double_ild_rows_num*double_ild_col_num]);
             %画出双耳信号ILD波形图 
             %if azi_single(k)==0
             figure;     
             subplot(2 ,1, 1);
             plot(temp_single_ILD,'-g'); 
             title(['[',num2str(azi_loudspeaker(1)),'  ',num2str(azi_single(k)),'  ',num2str(azi_loudspeaker(2)),']','  双耳信号ILD波形图']);%由扬声器方位来区分不同的测试组
             subplot(2 ,1, 2);
             plot(temp_double_ILD,'-b'); 
             %end
        end
        
    end   
end







