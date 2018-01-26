%———————根据实验得到的双耳信号进行分析————————————————
clc;
clear all;
initpath();
flag_binaraul_list_azi=0;%取值：0:5:40 标志某个single_azi下 单双生源双耳信号ILD对比

flag_signal_figure=0;%画出信号波形图
flag_signal_ILD=0;%1:所有帧的ILD连成行向量; 
flag_mean_ILD=1;%1:所有帧按子带求平均值 作图   
flag_signal_ILD_ksdensity=0;%ILD概率密度分布图
flag_points_ILD=0;%画出单双声源双耳信号每个频点ILD取值概率最大时的 ILD曲线图
flag_subbands_ILD=0;%画出单双声源双耳信号每个子带ILD取值概率最大时的 ILD曲线图

binarual_signal_basepath='.\binarualsignal\';
binarual_count=2*ones(9,1);%分别对应九种single_azi(0:5:40)下的双声源双耳信号计数


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
 
   
    %双耳信号测试组的 子文件夹（每个子文件夹  就是该种配置下 某个单声源方位下的测试信号）  
    for k=1:length(Result.num)%按单声源single_azi的不同分组（0:5:40）   找到主观感知最接近的双声源双耳信号的 文件名 
        switch azi_single(k)
           %% 单声源方位角为0时
            case 0                
                %获得某个方位下单声源双耳信号文件名
                binaraul_list_azi0{1}=[binarual_group_path,'b_',num2str(azi_single(k)),'_', num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),...
                     '\s_b_', num2str(azi_single(k)), '_whitenoise_0dB.wav'];
                 
                %获得某个方位下 主观感知最接近双声源双耳信号文件名
                if Result.num(k)<10
                    binaraul_list_azi0{binarual_count(1)}=[binarual_group_path,'b_',num2str(azi_single(k)),'_', num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),...
                    '\d_b_',num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),'_0',num2str(Result.num(k)),'_whitenoise_0dB.wav'];              
                else
                    binaraul_list_azi0{binarual_count(1)}=[binarual_group_path,'b_',num2str(azi_single(k)),'_', num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),...
                    '\d_b_',num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),'_',num2str(Result.num(k)),'_whitenoise_0dB.wav'];
                end
                binarual_count(1)=binarual_count(1)+1;
                
                
           %% 单声源方位角为05时                   
            case 5
                                %获得某个方位下单声源双耳信号文件名
                binaraul_list_azi5{1}=[binarual_group_path,'b_',num2str(azi_single(k)),'_', num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),...
                     '\s_b_', num2str(azi_single(k)), '_whitenoise_0dB.wav'];
                 
                %获得某个方位下 主观感知最接近双声源双耳信号文件名
                if Result.num(k)<10
                    binaraul_list_azi5{binarual_count(2)}=[binarual_group_path,'b_',num2str(azi_single(k)),'_', num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),...
                    '\d_b_',num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),'_0',num2str(Result.num(k)),'_whitenoise_0dB.wav'];              
                else
                    binaraul_list_azi5{binarual_count(2)}=[binarual_group_path,'b_',num2str(azi_single(k)),'_', num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),...
                    '\d_b_',num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),'_',num2str(Result.num(k)),'_whitenoise_0dB.wav'];
                end
                binarual_count(2)=binarual_count(2)+1;
                
                
           %% 单声源方位角为10时                
            case 10
                                %获得某个方位下单声源双耳信号文件名
                binaraul_list_azi10{1}=[binarual_group_path,'b_',num2str(azi_single(k)),'_', num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),...
                     '\s_b_', num2str(azi_single(k)), '_whitenoise_0dB.wav'];
                 
                %获得某个方位下 主观感知最接近双声源双耳信号文件名
                if Result.num(k)<10
                    binaraul_list_azi10{binarual_count(3)}=[binarual_group_path,'b_',num2str(azi_single(k)),'_', num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),...
                    '\d_b_',num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),'_0',num2str(Result.num(k)),'_whitenoise_0dB.wav'];              
                else
                    binaraul_list_azi10{binarual_count(3)}=[binarual_group_path,'b_',num2str(azi_single(k)),'_', num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),...
                    '\d_b_',num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),'_',num2str(Result.num(k)),'_whitenoise_0dB.wav'];
                end
                binarual_count(3)=binarual_count(3)+1;
                
                
           %% 单声源方位角为15时                
            case 15
                                %获得某个方位下单声源双耳信号文件名
                binaraul_list_azi15{1}=[binarual_group_path,'b_',num2str(azi_single(k)),'_', num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),...
                     '\s_b_', num2str(azi_single(k)), '_whitenoise_0dB.wav'];
                 
                %获得某个方位下 主观感知最接近双声源双耳信号文件名
                if Result.num(k)<10
                    binaraul_list_azi15{binarual_count(4)}=[binarual_group_path,'b_',num2str(azi_single(k)),'_', num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),...
                    '\d_b_',num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),'_0',num2str(Result.num(k)),'_whitenoise_0dB.wav'];              
                else
                    binaraul_list_azi15{binarual_count(4)}=[binarual_group_path,'b_',num2str(azi_single(k)),'_', num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),...
                    '\d_b_',num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),'_',num2str(Result.num(k)),'_whitenoise_0dB.wav'];
                end
                binarual_count(4)=binarual_count(4)+1;
                
          %% 单声源方位角为20时               
            case 20
                                %获得某个方位下单声源双耳信号文件名
                binaraul_list_azi20{1}=[binarual_group_path,'b_',num2str(azi_single(k)),'_', num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),...
                     '\s_b_', num2str(azi_single(k)), '_whitenoise_0dB.wav'];
                 
                %获得某个方位下 主观感知最接近双声源双耳信号文件名
                if Result.num(k)<10
                    binaraul_list_azi20{binarual_count(5)}=[binarual_group_path,'b_',num2str(azi_single(k)),'_', num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),...
                    '\d_b_',num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),'_0',num2str(Result.num(k)),'_whitenoise_0dB.wav'];              
                else
                    binaraul_list_azi20{binarual_count(5)}=[binarual_group_path,'b_',num2str(azi_single(k)),'_', num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),...
                    '\d_b_',num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),'_',num2str(Result.num(k)),'_whitenoise_0dB.wav'];
                end
                binarual_count(5)=binarual_count(5)+1;
                
           %% 单声源方位角为25时                
            case 25
                                %获得某个方位下单声源双耳信号文件名
                binaraul_list_azi25{1}=[binarual_group_path,'b_',num2str(azi_single(k)),'_', num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),...
                     '\s_b_', num2str(azi_single(k)), '_whitenoise_0dB.wav'];
                 
                %获得某个方位下 主观感知最接近双声源双耳信号文件名
                if Result.num(k)<10
                    binaraul_list_azi25{binarual_count(6)}=[binarual_group_path,'b_',num2str(azi_single(k)),'_', num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),...
                    '\d_b_',num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),'_0',num2str(Result.num(k)),'_whitenoise_0dB.wav'];              
                else
                    binaraul_list_azi25{binarual_count(6)}=[binarual_group_path,'b_',num2str(azi_single(k)),'_', num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),...
                    '\d_b_',num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),'_',num2str(Result.num(k)),'_whitenoise_0dB.wav'];
                end
                binarual_count(6)=binarual_count(6)+1;   
                
          %% 单声源方位角为30时                
            case 30
                                %获得某个方位下单声源双耳信号文件名
                binaraul_list_azi30{1}=[binarual_group_path,'b_',num2str(azi_single(k)),'_', num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),...
                     '\s_b_', num2str(azi_single(k)), '_whitenoise_0dB.wav'];
                 
                %获得某个方位下 主观感知最接近双声源双耳信号文件名
                if Result.num(k)<10
                    binaraul_list_azi30{binarual_count(7)}=[binarual_group_path,'b_',num2str(azi_single(k)),'_', num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),...
                    '\d_b_',num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),'_0',num2str(Result.num(k)),'_whitenoise_0dB.wav'];              
                else
                    binaraul_list_azi30{binarual_count(7)}=[binarual_group_path,'b_',num2str(azi_single(k)),'_', num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),...
                    '\d_b_',num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),'_',num2str(Result.num(k)),'_whitenoise_0dB.wav'];
                end
                binarual_count(7)=binarual_count(7)+1;
                
           %% 单声源方位角为35时                
            case 35   
                                %获得某个方位下单声源双耳信号文件名
                binaraul_list_azi35{1}=[binarual_group_path,'b_',num2str(azi_single(k)),'_', num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),...
                     '\s_b_', num2str(azi_single(k)), '_whitenoise_0dB.wav'];
                 
                %获得某个方位下 主观感知最接近双声源双耳信号文件名
                if Result.num(k)<10
                    binaraul_list_azi35{binarual_count(8)}=[binarual_group_path,'b_',num2str(azi_single(k)),'_', num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),...
                    '\d_b_',num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),'_0',num2str(Result.num(k)),'_whitenoise_0dB.wav'];              
                else
                    binaraul_list_azi35{binarual_count(8)}=[binarual_group_path,'b_',num2str(azi_single(k)),'_', num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),...
                    '\d_b_',num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),'_',num2str(Result.num(k)),'_whitenoise_0dB.wav'];
                end
                binarual_count(8)=binarual_count(8)+1;
                
           %% 单声源方位角为40时                
            case 40  
                                %获得某个方位下单声源双耳信号文件名
                binaraul_list_azi40{1}=[binarual_group_path,'b_',num2str(azi_single(k)),'_', num2str(azi_loudspeaker(1)),'_',num2str(azi_loudspeaker(2)),...
                     '\s_b_', num2str(azi_single(k)), '_whitenoise_0dB.wav'];
                 
                %获得某个方位下 主观感知最接近双声源双耳信号文件名
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
        figure_single_azi='0';%作图标题显示  单声源方位角 
        figure_loudspeaker_azi={'[-15 15]','[-20 20]','[-25 25]','[-30 30]','[-35 35]','[-40 40]','[-45 45]'};%作图标题显示  扬声器配置方位角 
    case 5
        binaraul_list_azi=binaraul_list_azi5;
        figure_single_azi='5';%作图标题显示  单声源方位角 
        figure_loudspeaker_azi={'[-15 15]','[-20 20]','[-25 25]','[-30 30]','[-35 35]','[-40 40]','[-45 45]'};%作图标题显示  扬声器配置方位角        
    case 10
        binaraul_list_azi=binaraul_list_azi10;     
        figure_single_azi='10';%作图标题显示  单声源方位角 
        figure_loudspeaker_azi={'[-15 15]','[-20 20]','[-25 25]','[-30 30]','[-35 35]','[-40 40]','[-45 45]'};%作图标题显示  扬声器配置方位角        
    case 15
        binaraul_list_azi=binaraul_list_azi15;
        figure_single_azi='15';%作图标题显示  单声源方位角 
        figure_loudspeaker_azi={'[-20 20]','[-25 25]','[-30 30]','[-35 35]','[-40 40]','[-45 45]'};%作图标题显示  扬声器配置方位角        
    case 20
        binaraul_list_azi=binaraul_list_azi20;
        figure_single_azi='20';%作图标题显示  单声源方位角 
        figure_loudspeaker_azi={'[-25 25]','[-30 30]','[-35 35]','[-40 40]','[-45 45]'};%作图标题显示  扬声器配置方位角        
    case 25
        binaraul_list_azi=binaraul_list_azi25;
        figure_single_azi='25';%作图标题显示  单声源方位角 
        figure_loudspeaker_azi={'[-30 30]','[-35 35]','[-40 40]','[-45 45]'};%作图标题显示  扬声器配置方位角        
    case 30
        binaraul_list_azi=binaraul_list_azi30;
        figure_single_azi='30';%作图标题显示  单声源方位角 
        figure_loudspeaker_azi={'[-35 35]','[-40 40]','[-45 45]'};%作图标题显示  扬声器配置方位角        
    case 35
        binaraul_list_azi=binaraul_list_azi35;
        figure_single_azi='35';%作图标题显示  单声源方位角 
        figure_loudspeaker_azi={'[-40 40]','[-45 45]'};%作图标题显示  扬声器配置方位角        
    case 40 
        binaraul_list_azi=binaraul_list_azi40;
        figure_single_azi='40';%作图标题显示  单声源方位角 
        figure_loudspeaker_azi={'[-45 45]'};%作图标题显示  扬声器配置方位角        
end

binaraul_list_len=length(binaraul_list_azi);
figure_rows=ceil(binaraul_list_len/2);


%% single_azi==0时的单双声源双耳信号波形图
if 1==flag_signal_figure
     figure;      
     single_binaraul_file=binaraul_list_azi{1};
     [single_wav_data fs nbits]=wavread(single_binaraul_file);  
     subplot(figure_rows ,2, 1);
     plot(single_wav_data,'-g');    
     xlabel('样本点','fontsize',8);
     ylabel('信号幅度','fontsize',8);
     title(['单声源方位' figure_single_azi '度时双耳信号'],'fontsize',8);%由扬声器方位来区分不同的测试组     
     for i=2:length(binaraul_list_azi)                                
         double_binaraul_file=binaraul_list_azi{i};
         [double_wav_data fs nbits]=wavread(double_binaraul_file); 
         subplot(figure_rows ,2, i);
         plot(double_wav_data,'-b'); 
         xlabel('样本点','fontsize',8);
         ylabel('信号幅度','fontsize',8);
         title(['扬声器配置为' figure_loudspeaker_azi{i-1} '时双耳信号'],'fontsize',8);%由扬声器方位来区分不同的测试组         
     end        
end

%% 画出单双声源双耳信号子带ILD 的概率密度图  所有帧的ILD连成行向量 
if 1==flag_signal_ILD_ksdensity
     figure;  
     %单声源双耳信号子带ILD
     single_binaraul_file=binaraul_list_azi{1};
     single_subbands_ILD=get_subbands_ILD(single_binaraul_file); 
     single_ild_rows_num=size(single_subbands_ILD,1);
     single_ild_col_num=size(single_subbands_ILD,2);                         
     %reshape 需要转置 single_subbands_ILD' double_subbands_ILD'
     temp_single_ILD=reshape(single_subbands_ILD',[1,single_ild_rows_num*single_ild_col_num]);
     [f1, x1]=ksdensity(temp_single_ILD);
     %画出双耳信号ILD概率分布波形图 
     subplot(figure_rows ,2, 1);     
     plot(x1,f1,'-g'); 
     xlabel('ILD(dB)','fontsize',8);
     ylabel('ILD概率分布','fontsize',8);
     title(['单声源方位' figure_single_azi '度时双耳信号ILD概率分布'],'fontsize',8);
     axis([-25 25 0 0.5]);
     
     for i=2:length(binaraul_list_azi)                        
         %双声源双耳信号子带ILD
         double_binaraul_file=binaraul_list_azi{i};
         double_subbands_ILD=get_subbands_ILD(double_binaraul_file); 
         double_ild_rows_num=size(double_subbands_ILD,1);
         double_ild_col_num=size(double_subbands_ILD,2);
         %reshape 需要转置 single_subbands_ILD' double_subbands_ILD'
         temp_double_ILD=reshape(double_subbands_ILD',[1,double_ild_rows_num*double_ild_col_num]);
         [f2, x2]=ksdensity(temp_double_ILD);
         %画出双耳信号ILD概率分布波形图 
         subplot(figure_rows ,2, i);     
         plot(x2,f2,'-b'); 
         xlabel('ILD(dB)','fontsize',8);
         ylabel('ILD概率分布','fontsize',8);
         title(['扬声器配置为' figure_loudspeaker_azi{i-1} '时双耳信号ILD概率密度'],'fontsize',8);
         axis([-25 25 0 0.2]);
     end        
end

%% 画出单双声源双耳信号每个子带ILD取值概率最大时的 ILD曲线图
if 1==flag_subbands_ILD
    
     %单声源双耳信号子带ILD
     single_binaraul_file=binaraul_list_azi{1};
     single_subbands_ILD=get_subbands_ILD(single_binaraul_file); %single_subbands_ILD每行为一帧
     subbands_number=size(single_subbands_ILD,2);
     subbands=1:subbands_number;
     for p=1:subbands_number%p是子带的个数
         [f1, x1]=ksdensity(single_subbands_ILD(:,p));%求每个子带的ILD概率分布
         [max_probability, max_probability_index]=max(f1);
         single_max_probability_ILD(p)=x1(max_probability_index);
     end   
     figure;  
     subplot(figure_rows ,2, 1);     
     plot(subbands,single_max_probability_ILD,'-g'); 
     xlabel('子带','fontsize',8);
     ylabel('子带上概率最大ILD(dB)','fontsize',8);    
     title(['单声源方位' figure_single_azi '度时双耳信号子带ILD'],'fontsize',8);
     axis([1 25 -10 10]);
     
     for i=2:length(binaraul_list_azi)                        
         %双声源双耳信号子带ILD
         double_binaraul_file=binaraul_list_azi{i};
         double_subbands_ILD=get_subbands_ILD(double_binaraul_file); 
         for q=1:subbands_number%q是频点标号
             [f2, x2]=ksdensity(double_subbands_ILD(:,q));%求每个子带的ILD概率分布
             [max_probability, max_probability_index]=max(f2);
             double_max_probability_ILD(q)=x2(max_probability_index);
         end
         %画出双耳信号ILD概率分布波形图 
         subplot(figure_rows ,2, i);     
         plot(subbands,double_max_probability_ILD,'-b'); 
         xlabel('子带','fontsize',8);
         ylabel('子带上概率最大ILD(dB)','fontsize',8);    
         title(['扬声器配置为' figure_loudspeaker_azi{i-1} '时双耳信号子带ILD'],'fontsize',8);
         axis([1 25 -10 10]);
     end        
end



%% 画出单双声源双耳信号每个频点ILD取值概率最大时的 ILD曲线图
if 1==flag_points_ILD
    
     %单声源双耳信号子带ILD
     single_binaraul_file=binaraul_list_azi{1};
     single_points_ILD=get_points_ILD(single_binaraul_file); %single_points_ILD每列为一帧
     points_number=size(single_points_ILD,1);
     points=1:points_number;
     for p=1:points_number%p是频点个数
         [f1, x1]=ksdensity(single_points_ILD(p,:));%求每个频点的ILD概率分布
         [max_probability, max_probability_index]=max(f1);
         single_max_probability_ILD(p)=x1(max_probability_index);
     end   
     figure;  
     %画出双耳信号ILD概率分布波形图 
     subplot(figure_rows ,2, 1);     
     plot(points,single_max_probability_ILD,'-g'); 
     xlabel('频点','fontsize',8);
     ylabel('频点上概率最大ILD(dB)','fontsize',8);    
     title(['单声源方位' figure_single_azi '度时双耳信号频点ILD'],'fontsize',8);
     axis([1 1024 -10 10]);
     
     for i=2:length(binaraul_list_azi)                        
         %双声源双耳信号子带ILD
         double_binaraul_file=binaraul_list_azi{i};
         double_points_ILD=get_points_ILD(double_binaraul_file); 
         for q=1:points_number%q是频点标号
             [f2, x2]=ksdensity(double_points_ILD(q,:));%求每个频点的ILD概率分布
             [max_probability, max_probability_index]=max(f2);
             double_max_probability_ILD(q)=x2(max_probability_index);
         end
         %画出双耳信号ILD概率分布波形图 
         subplot(figure_rows ,2, i);     
         plot(points,double_max_probability_ILD,'-b'); 
         xlabel('频点','fontsize',8);
         ylabel('频点上概率最大ILD(dB)','fontsize',8);    
         title(['扬声器配置为' figure_loudspeaker_azi{i-1} '时双耳信号频点ILD'],'fontsize',8);
         axis([1 1024 -10 10]);
     end        
end


%% single_azi==0时 画出单双声源双耳信号子带ILD 波形图   所有帧的ILD连成行向量 
if 1==flag_signal_ILD
     figure;  
     %单声源双耳信号子带ILD
     single_binaraul_file=binaraul_list_azi{1};
     single_subbands_ILD=get_subbands_ILD(single_binaraul_file); 
     single_ild_rows_num=size(single_subbands_ILD,1);
     single_ild_col_num=size(single_subbands_ILD,2);                         
     %reshape 需要转置 single_subbands_ILD' double_subbands_ILD'
     temp_single_ILD=reshape(single_subbands_ILD',[1,single_ild_rows_num*single_ild_col_num]);

     %画出双耳信号ILD波形图 
     subplot(figure_rows ,2, 1);
     plot(temp_single_ILD,'-g'); 
     xlabel('子带编号','fontsize',8);
     ylabel('ILD(dB)','fontsize',8);
     title(['扬声器配置为' figure_loudspeaker_azi{i-1} '时双耳信号ILD概率密度'],'fontsize',8);
     
     for i=2:length(binaraul_list_azi)                        
         %双声源双耳信号子带ILD
         double_binaraul_file=binaraul_list_azi{i};
         double_subbands_ILD=get_subbands_ILD(double_binaraul_file); 
         double_ild_rows_num=size(double_subbands_ILD,1);
         double_ild_col_num=size(double_subbands_ILD,2);
         %reshape 需要转置 single_subbands_ILD' double_subbands_ILD'
         temp_double_ILD=reshape(double_subbands_ILD',[1,double_ild_rows_num*double_ild_col_num]);
        
         subplot(figure_rows ,2, i);
         plot(temp_double_ILD,'-b'); 
         xlabel('子带编号','fontsize',8);
         ylabel('ILD(dB)','fontsize',8);
         title(['扬声器配置为' figure_loudspeaker_azi{i-1} '时双耳信号ILD'],'fontsize',8);
     end        
end

%% 单双声源双耳信号子带ILD  按子带求平均 （single_subbands_ILD,double_subbands_ILD按列求平均） 
if 1==flag_mean_ILD
     figure;  
     %单声源双耳信号子带ILD
     single_binaraul_file=binaraul_list_azi{1};
     single_subbands_ILD=get_subbands_ILD(single_binaraul_file); 
     save single_subbands_ILD.mat single_subbands_ILD
     %单双声源双耳信号子带ILD  按子带求平均 （single_subbands_ILD,double_subbands_ILD按列求平均） 
     for m=1:size(single_subbands_ILD,2)
        single_mean_ILD(m)=mean(single_subbands_ILD(:,m));
     end     
          
     %画出双耳信号子带平均 ILD波形图 
     subplot(figure_rows ,2, 1);
     plot(single_mean_ILD,'-g'); 
     xlabel('子带编号','fontsize',8);
     ylabel('ILD(dB)','fontsize',8);
     title(['单声源方位' figure_single_azi '度时双耳信号ILD'],'fontsize',8);%由扬声器方位来区分不同的测试组
     
     for i=2:length(binaraul_list_azi)                        
         %双声源双耳信号子带ILD
         double_binaraul_file=binaraul_list_azi{i};
         double_subbands_ILD=get_subbands_ILD(double_binaraul_file); 
%          mat_file_name='double_subbands_ILD.mat';
%          save( mat_file_name,'double_subbands_ILD');
         save double_subbands_ILD.mat double_subbands_ILD;
         % 单双声源双耳信号子带ILD  按子带求平均 （single_subbands_ILD,double_subbands_ILD按列求平均） 
         for m=1:size(double_subbands_ILD,2)
            double_mean_ILD(m)=mean(double_subbands_ILD(:,m));
         end      
         subplot(figure_rows ,2, i);
         plot(double_mean_ILD,'-b'); 
         xlabel('子带编号','fontsize',8);
         ylabel('ILD(dB)','fontsize',8);
         title(['扬声器配置为' figure_loudspeaker_azi{i-1} '时双耳信号ILD'],'fontsize',8);%由扬声器方位来区分不同的测试组
     end            
end
%% 







