%———————根据实验得到的双耳信号进行分析————————————————
clc;
clear all;
initpath();

flag_binaraul_list_azi=0;%取值：0:5:40 标志某个single_azi下 单双生源双耳信号ILD对比
flag_signal_figure=0;%画出信号波形图
flag_signal_ILD=0;%1:所有帧的ILD连成行向量; 
flag_mean_ILD=1;%1:所有帧按子带求平均值 作图   
flag_signal_ILD_ksdensity=1;%ILD概率密度分布图
flag_points_ILD=0;%画出单双声源双耳信号每个频点ILD取值概率最大时的 ILD曲线图
flag_subbands_ILD=1;%画出单双声源双耳信号每个子带ILD取值概率最大时的 ILD曲线图

single_azi_list=[0 5 10 15 20 25 30 35 40];
% single_azi_list=[0 5 10 ];
right_loudspeaker_azi_list=[0 15 20 25 30 35 40 45];
figure_rows=length(single_azi_list);
figure_columns=length(right_loudspeaker_azi_list);

binarual_signal_basepath='.\binarualsignal\';
binarual_count=2*ones(9,1);%分别对应九种single_azi(0:5:40)下的双声源双耳信号计数


xls_file_name='result(王金山).xlsx';
sheet='result';
xls_range='B1:G8';
[ndata txt alldata]=xlsread(xls_file_name,sheet,xls_range);

%%从excel表中获取所有的数据信息
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
            %左右扬声器方位角
            azi_loudspeaker=[-15 15];
            %某个测试组（某种扬声器配置下）的双耳信号路径     b_-15_15表示在[-15 15]的配置下单双声源的双耳信号路径 
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
    %单声源方位    
    azi_single=Result.single_azi;
 
   
    %双耳信号测试组的 子文件夹（每个子文件夹  就是该种配置下 某个单声源方位下的测试信号）  
    for k=1:length(Result.num)%按单声源single_azi的不同分组（0:5:40）   找到主观感知最接近的双声源双耳信号的 文件名 
        switch azi_single(k)
           %% 单声源方位角为0时
            case 0                
                %获得某个方位下单声源双耳信号文件名  
                % binaraul_list_azi0{}中依次存储的是 0度方位角 单声源双耳信号 [-15 15]  [-20 20]...[-45 45]扬声器配置下主观感知最接近的双声源双耳信号
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
                
                
           %% 单声源方位角为5时                   
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



%% 画出单双声源双耳信号每个子带ILD取值概率最大时的 ILD曲线图
if 1==flag_subbands_ILD
    figure;
    set(gcf,'color','w');%figure背景色改为白色
    annotation(gcf,'textbox',[0.45 0.96 0.2 0.03],'String',{'各子带概率最大ILD曲线图'},'FontSize',14,'edgecolor',get(gcf,'color'));    
    for i=1:length(single_azi_list)
        no_figure_index_j=0;%no_figure_index_j记录不用作图的列的索引j 
        switch single_azi_list(i)%single_azi_list(i)单声源方位 0:5:40
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
        %right_loudspeaker_azi_list(j)右扬声器方位角[0 15 20 25 30 35 40 45]其中0表示单声源情况
        %当单声源方位角位于双声源左右扬声器夹角内或者right_loudspeaker_azi_list(j)==0时作图
            if single_azi_list(i)<right_loudspeaker_azi_list(j)||right_loudspeaker_azi_list(j)==0
                k=figure_columns*(i-1)+j;%图的标号
                if right_loudspeaker_azi_list(j)==0%单声源双耳信号画图
                     %binaraul_list_azi 单双声源双耳信号文件名路径列表
                     single_binaraul_file=binaraul_list_azi{1};%binaraul_list_azi{1}单声源双耳信号文件名
                     single_subbands_ILD=get_subbands_ILD(single_binaraul_file); %single_subbands_ILD每行为一帧 25个子带
                     subbands_number=size(single_subbands_ILD,2);%子带个数 25
                     subbands=1:subbands_number;%图的横坐标 子带编号1:25
                     for p=1:subbands_number%p是子带的个数
                         %single_subbands_ILD(:,p)所有帧的第p个子带的ILD 
                         [f1, x1]=ksdensity(single_subbands_ILD(:,p));%求子带p的ILD概率分布 f1表示概率 x1表示ILD(顺序由小到大) 
                         [max_probability, max_probability_index]=max(f1);
                         single_max_probability_ILD(p)=x1(max_probability_index);%子带p概率最大的ILD,single_max_probability_ILD长度为25 
                     end   
                     subplot(figure_rows, figure_columns ,k);    
                     plot(subbands,single_max_probability_ILD,'-g'); 
                     axis([1 25 -20 20]);
                     
                     %设置第一列左边的单声源方位角说明                   
                     switch single_azi_list(i)
                         case 0 
                             text(0,0,'0      ','horiz','right','vert','middle')
                             text(12.5,22,'单声源','horiz','center','vert','bottom')
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
                             
                else%double_binaraul_file 双声源双耳信号文件名  处理流程与单声源双耳信号相同
                    double_binaraul_file=binaraul_list_azi{j-no_figure_index_j};%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    double_subbands_ILD=get_subbands_ILD(double_binaraul_file); 
                    for q=1:subbands_number
                         [f2, x2]=ksdensity(double_subbands_ILD(:,q));%求每个子带的ILD概率分布
                         [max_probability, max_probability_index]=max(f2);
                         double_max_probability_ILD(q)=x2(max_probability_index);
                    end
                    %画出双耳信号ILD概率分布波形图 
                    subplot(figure_rows, figure_columns ,k);     
                    plot(subbands,double_max_probability_ILD,'-b');                      
                    axis([1 25 -20 20]);
                    if i==1%第一行加标题
                        switch right_loudspeaker_azi_list(j)
                             case 0 
                                 text(12.5,22,'单声源','horiz','center','vert','bottom')
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
                

                if j>1%没有纵坐标标记
                    set(gca,'ytick',[-20 -10 0 10 20])%设置坐标轴刻度
                    set(gca,'yticklabel',[]);%设置坐标轴刻度旁的label为null
                end
                if i>1%没有横坐标标记
                    set(gca,'xtick',[5 10 15 20 25])%设置坐标轴刻度
                    set(gca,'xticklabel',[]);%设置坐标轴刻度旁的label为null
                end  
            else
               no_figure_index_j=j-1;%no_figure_index_j记录不用作图的列的索引j  注意是j-1 
            end
        end
    end     
end




%% 画出单双声源双耳信号子带ILD 的概率密度图  所有帧的ILD连成行向量 
if 1==flag_signal_ILD_ksdensity
    figure;
    set(gcf,'color','w');%figure背景色改为白色
    annotation(gcf,'textbox',[0.45 0.96 0.2 0.03],'String',{'ILD概率密度图'},'FontSize',14,'edgecolor',get(gcf,'color')); 
    for i=1:length(single_azi_list)
        no_figure_index_j=0;%no_figure_index_j记录不用作图的列的索引j 
        switch single_azi_list(i)%single_azi_list(i)单声源方位 0:5:40
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
        %right_loudspeaker_azi_list(j)右扬声器方位角[0 15 20 25 30 35 40 45]其中0表示单声源情况
        %当单声源方位角位于双声源左右扬声器夹角内或者right_loudspeaker_azi_list(j)==0时作图
            if single_azi_list(i)<right_loudspeaker_azi_list(j)||right_loudspeaker_azi_list(j)==0
                k=figure_columns*(i-1)+j;%图的标号
                if right_loudspeaker_azi_list(j)==0%单声源双耳信号画图
                     %binaraul_list_azi 单双声源双耳信号文件名路径列表
                     single_binaraul_file=binaraul_list_azi{1};%binaraul_list_azi{1}单声源双耳信号文件名
                     single_subbands_ILD=get_subbands_ILD(single_binaraul_file); %single_subbands_ILD每行为一帧 25个子带
                     single_ild_rows_num=size(single_subbands_ILD,1);
                     single_ild_col_num=size(single_subbands_ILD,2);                         
                     %reshape 需要转置 single_subbands_ILD' double_subbands_ILD'
                     temp_single_ILD=reshape(single_subbands_ILD',[1,single_ild_rows_num*single_ild_col_num]);
                     [f1, x1]=ksdensity(temp_single_ILD);  
                     subplot(figure_rows, figure_columns ,k);    
                     plot(x1,f1,'-g'); 
                     axis([-20 20 0 0.5]);
                     
                     %设置第一列左边的单声源方位角说明                   
                     switch single_azi_list(i)
                         case 0 
                             text(-20,0.25,'0           ','horiz','right','vert','middle')
                             text(12.5,12,'单声源','horiz','center','vert','bottom')
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
                             
                else%double_binaraul_file 双声源双耳信号文件名  处理流程与单声源双耳信号相同
                    double_binaraul_file=binaraul_list_azi{j-no_figure_index_j};%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    double_subbands_ILD=get_subbands_ILD(double_binaraul_file); 
                    double_ild_rows_num=size(double_subbands_ILD,1);
                    double_ild_col_num=size(double_subbands_ILD,2);
                    %reshape 需要转置 single_subbands_ILD' double_subbands_ILD'
                    temp_double_ILD=reshape(double_subbands_ILD',[1,double_ild_rows_num*double_ild_col_num]);
                    [f2, x2]=ksdensity(temp_double_ILD);
                    %画出双耳信号ILD概率分布波形图 
                    subplot(figure_rows, figure_columns ,k);     
                    plot(x2,f2,'-b');                      
                    axis([-20 20 0 0.5]);
                    if i==1%第一行加标题
                        switch right_loudspeaker_azi_list(j)
                             case 0 
                                 text(0,0.5,'单声源','horiz','center','vert','bottom')
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
                

                if j>1%没有纵坐标标记
                    set(gca,'ytick',[0.1 0.2 0.3 0.4 0.5])%设置纵坐标轴刻度
                    set(gca,'yticklabel',[]);%设置纵坐标轴刻度旁的label为null
                end
                if i>1%没有横坐标标记
                    set(gca,'xtick',-20:5:20)%设置横坐标轴刻度
                    set(gca,'xticklabel',[]);%设置横坐标轴刻度旁的label为null
                end  
            else
               no_figure_index_j=j-1;%no_figure_index_j记录不用作图的列的索引j  注意是j-1 
            end
        end
    end     

end



%% 单双声源双耳信号子带ILD  按子带求平均 （single_subbands_ILD,double_subbands_ILD按列求平均） 
if 1==flag_mean_ILD
    figure;
    set(gcf,'color','w');%figure背景色改为白色
    annotation(gcf,'textbox',[0.45 0.96 0.2 0.03],'String',{'各子带ILD均值曲线图'},'FontSize',14,'edgecolor',get(gcf,'color'));       
    for i=1:length(single_azi_list)
        no_figure_index_j=0;%no_figure_index_j记录不用作图的列的索引j 
        switch single_azi_list(i)%single_azi_list(i)单声源方位 0:5:40
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
        %right_loudspeaker_azi_list(j)右扬声器方位角[0 15 20 25 30 35 40 45]其中0表示单声源情况
        %当单声源方位角位于双声源左右扬声器夹角内或者right_loudspeaker_azi_list(j)==0时作图
            if single_azi_list(i)<right_loudspeaker_azi_list(j)||right_loudspeaker_azi_list(j)==0
                k=figure_columns*(i-1)+j;%图的标号
                if right_loudspeaker_azi_list(j)==0%单声源双耳信号画图
                     %binaraul_list_azi 单双声源双耳信号文件名路径列表
                     single_binaraul_file=binaraul_list_azi{1};%binaraul_list_azi{1}单声源双耳信号文件名
                     single_subbands_ILD=get_subbands_ILD(single_binaraul_file); %single_subbands_ILD每行为一帧 25个子带
                     subbands_number=size(single_subbands_ILD,2);%子带个数 25
                     subbands=1:subbands_number;%图的横坐标 子带编号1:25
                     %单双声源双耳信号子带ILD  按子带求平均 （single_subbands_ILD,double_subbands_ILD按列求平均） 
                     for m=1:size(single_subbands_ILD,2)
                        single_mean_ILD(m)=mean(single_subbands_ILD(:,m));
                     end  
                     subplot(figure_rows, figure_columns ,k);    
                     plot(subbands,single_mean_ILD,'-g'); 
                     axis([1 25 -20 20]);
                     
                    %设置第一列左边的单声源方位角说明                   
                     switch single_azi_list(i)
                         case 0 
                             text(-8,0,'0','horiz','right','vert','middle')
                             text(12.5,22,'单声源','horiz','center','vert','bottom')
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
                             
                else%double_binaraul_file 双声源双耳信号文件名  处理流程与单声源双耳信号相同
                    double_binaraul_file=binaraul_list_azi{j-no_figure_index_j};%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    double_subbands_ILD=get_subbands_ILD(double_binaraul_file); 
                    for m=1:size(double_subbands_ILD,2)
                        double_mean_ILD(m)=mean(double_subbands_ILD(:,m));
                    end  
                    subplot(figure_rows, figure_columns ,k);     
                    plot(subbands,double_mean_ILD,'-b');                      
                    axis([1 25 -20 20]);
                    if i==1%第一行加标题
                        switch right_loudspeaker_azi_list(j)
                             case 0 
                                 text(12.5,22,'单声源','horiz','center','vert','bottom')
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
                

                if j>1%没有纵坐标标记
                %set(gca,'ytick',0:2:10)%设置纵坐标轴刻度  
                    set(gca,'yticklabel',[]);%设置纵坐标轴刻度旁的label为null
                end
                if i>1%没有横坐标标记
                %set(gca,'xtick',5:5:25)%设置横坐标轴刻度
                    set(gca,'xticklabel',[]);%设置横坐标轴刻度旁的label为null
                end  
            else
               no_figure_index_j=j-1;%no_figure_index_j记录不用作图的列的索引j  注意是j-1 
            end
        end
    end     
end
%% 







