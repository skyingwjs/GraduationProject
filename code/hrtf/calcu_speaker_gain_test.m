%subject_index:CIPIC库的subject index
%source_theta:单声源的方位(即将要合成的虚拟声像的方位) source_theta=[azi,elev]
%speaker_theta:扬声器方位 speaker_theta=[sp1_azi,sp1_elev;sp2_azi,sp2_elev;sp3_azi,sp3_elev;...]
%gain: 扬声器频域信号增益 gain=[sp1_gain;sp2_gain;sp3_gain;...]
%type: 子带划分类型，通过subbands_type(type)可获得不同子带划分方式的数据


%添加需要调用的函数的路径
hrtf_path='..\hrtf\';
addpath(genpath(hrtf_path));
subbands_path='..\subbands\';
addpath(genpath(subbands_path));
input_path='..\input\';
addpath(genpath(input_path));
utils_path='..\utils\';
addpath(genpath(utils_path));
vbap_path='..\vbap\';
addpath(genpath(vbap_path));


subject_index=1;
source_theta=[0,22.5];
speaker_theta=[-45,45;0,0;45,45];
% start_end_index=subbands_type(25);
start_index=[1 4 6 8  11 13 16 19 23 27 31 36 41 48 55 64 75 87  104 125 150 180 222 280 361];
end_index=  [3 5 7 10 12 15 18 22 26 30 35 40 47 54 63 74 86 103 124 149 179 221 279 360 513];
start_end_index=[start_index' end_index'];

source_azi=source_theta(1);
source_elev=source_theta(2);
sp1_azi=speaker_theta(1,1);
sp1_elev=speaker_theta(1,2);
sp2_azi=speaker_theta(2,1);
sp2_elev=speaker_theta(2,2);
sp3_azi=speaker_theta(3,1);
sp3_elev=speaker_theta(3,2);

%获得声源方位及扬声器方位处的hrtf
source_hrtf=get_hrtf(subject_index,source_azi,source_elev);
sp1_hrtf=get_hrtf(subject_index,sp1_azi,sp1_elev);
sp2_hrtf=get_hrtf(subject_index,sp2_azi,sp2_elev);
sp3_hrtf=get_hrtf(subject_index,sp3_azi,sp3_elev);


%将hrtf频谱划分子带
source_subbands=subbands_divide(source_hrtf,start_end_index);
sp1_subbands=subbands_divide(sp1_hrtf,start_end_index);
sp2_subbands=subbands_divide(sp2_hrtf,start_end_index);
sp3_subbands=subbands_divide(sp3_hrtf,start_end_index);

%子带数
subbands_number=size(source_subbands,1);

for i=1:subbands_number %子带
    for j=1:2 %左右耳
          source_bands_energy(i,j)=sum(source_subbands{i,j} .*conj(source_subbands{i,j}) );  
          sp1_bands_energy(i,j)=sum(sp1_subbands{i,j} .*conj(sp1_subbands{i,j}) ); 
          sp2_bands_energy(i,j)=sum(sp2_subbands{i,j} .*conj(sp2_subbands{i,j}) ); 
          sp3_bands_energy(i,j)=sum(sp3_subbands{i,j} .*conj(sp3_subbands{i,j}) ); 
    end
end

% source_energy_l=sqrt(source_bands_energy(:,1));
% source_energy_r=sqrt(source_bands_energy(:,2));
% sp_energy_l=sqrt([sp1_bands_energy(:,1) sp2_bands_energy(:,1) sp3_bands_energy(:,1)]);
% sp_energy_r=sqrt([sp1_bands_energy(:,2) sp2_bands_energy(:,2) sp3_bands_energy(:,2)]);

source_energy_l=source_bands_energy(:,1);
source_energy_r=source_bands_energy(:,2);
sp_energy_l=[sp1_bands_energy(:,1) sp2_bands_energy(:,1) sp3_bands_energy(:,1)];
sp_energy_r=[sp1_bands_energy(:,2) sp2_bands_energy(:,2) sp3_bands_energy(:,2)];

gain=zeros(subbands_number,3);
gain_temp=zeros(subbands_number,3*4);
g_temp=zeros(4,1);
min_diff=Inf;
g1_init=0:0.05:1;
g2_init=0:0.05:1;
g3_init=0:0.05:1;

%各扬声器各子带加权hrtf能量之和与原始声源处各子带hrtf能量和守恒
for i=1:subbands_number 
    SL=  source_energy_l(i);
    SR=  source_energy_r(i);
    SPL= sp_energy_l(i,:);
    SPR= sp_energy_r(i,:);
    syms  g2 g3 
    for j=1:length(g1_init)
        S=solve(SPL(1)*g1_init(j)+ SPL(2)*g2+ SPL(3)*g3==SL,SPR(1)*g1_init(j)+SPR(2)*g2+SPR(3)*g3==SR);
        S=[S.g2 S.g3];
        diff=abs(1-sum(S.^2));
        if (diff<min_diff && S(1)<=1 && S(1)>=0 && S(2)<=1 && S(2)>=0 )
            min_diff=diff;            
            g_temp=[vpa(g1_init(j),4) vpa(S(1),4) vpa(S(2),4) vpa(min_diff,4)];              
        end
    end
    min_diff=Inf;
    gain_temp(i,1:4)=g_temp;
end

for i=1:subbands_number 
    SL=  source_energy_l(i);
    SR=  source_energy_r(i);
    SPL= sp_energy_l(i,:);
    SPR= sp_energy_r(i,:);
    syms  g1 g3 
    for j=1:length(g2_init)
        S=solve(SPL(1)*g1+ SPL(2)*g2_init(j)+ SPL(3)*g3==SL,SPR(1)*g1+SPR(2)*g2_init(j)+SPR(3)*g3==SR);
        S=[S.g1 S.g3];
        diff=abs(1-sum(S.^2));
        if (diff<min_diff && S(1)<=1 && S(1)>=0 && S(2)<=1 && S(2)>=0 )
            min_diff=diff;            
            g_temp=[vpa(S(1),4) vpa(g2_init(j),4) vpa(S(2),4) vpa(min_diff,4)];              
        end
    end
    min_diff=Inf;
    gain_temp(i,5:8)=g_temp;
end

for i=1:subbands_number 
    SL=  source_energy_l(i);
    SR=  source_energy_r(i);
    SPL= sp_energy_l(i,:);
    SPR= sp_energy_r(i,:);
    syms  g1 g2 
    for j=1:length(g3_init)
        S=solve(SPL(1)*g1+ SPL(2)*g2+ SPL(3)*g3_init(j)==SL,SPR(1)*g1+SPR(2)*g2+SPR(3)*g3_init(j)==SR);
        S=[S.g1 S.g2];
        diff=abs(1-sum(S.^2));
        if (diff<min_diff && S(1)<=1 && S(1)>=0 && S(2)<=1 && S(2)>=0 )
            min_diff=diff;            
            g_temp=[vpa(S(1),4) vpa(S(2),4) vpa(g3_init(j),4) vpa(min_diff,4)];              
        end
    end
    min_diff=Inf;
    gain_temp(i,9:12)=g_temp;
end

for i=1:subbands_number
    diffs=[gain_temp(i,4) gain_temp(i,8) gain_temp(i,12)];
    [min_diff index]=min(diffs);
    gain(i,:)=gain_temp(i,index*4-3 :index*4-1);
end

gain


%% 原始声源及扬声器方位处的hrtf的各子带的能量
% for i=1:subbands_number %子带
%     for j=1:2 %左右耳
%           source_bands_energy(i,j)=sum(source_subbands{i,j} .*conj(source_subbands{i,j}) );  
%           sp1_bands_energy(i,j)=sum(sp1_subbands{i,j} .*conj(sp1_subbands{i,j}) ); 
%           sp2_bands_energy(i,j)=sum(sp2_subbands{i,j} .*conj(sp2_subbands{i,j}) ); 
%           sp3_bands_energy(i,j)=sum(sp3_subbands{i,j} .*conj(sp3_subbands{i,j}) ); 
%     end
% %           左右耳相位差
%           source_bands_phase_diff(i)=phase( sum(source_subbands{i,1} .*conj(source_subbands{i,2})) );  
% %           source_bands_phase_diff(i)= sum(source_subbands{i,1} .*conj(source_subbands{i,2})) ; 
% %           sp_bands_phase_diff(i)=phase(sum( (sp1_subbands{i,1}+sp2_subbands{i,1}+sp3_subbands{i,1}).* conj(sp1_subbands{i,2}+sp2_subbands{i,2}+sp3_subbands{i,2}) ) ) ; 
% 
% end
% 
% %各子带左右耳能量
% source_energy_l=source_bands_energy(:,1);
% source_energy_r=source_bands_energy(:,2);
% sp_energy_l=[sp1_bands_energy(:,1) sp2_bands_energy(:,1) sp3_bands_energy(:,1)];
% sp_energy_r=[sp1_bands_energy(:,2) sp2_bands_energy(:,2) sp3_bands_energy(:,2)];


%% 利用vpasolve解三元一次方程组  可能存在无解的情况
%各扬声器频域增益
% gain=zeros(subbands_number,3); 
% syms g1 g2 g3 

%各扬声器各子带加权hrtf能量之和与原始声源处各子带hrtf能量和守恒
% for i=1:subbands_number
%     if(i==2)
%         continue;
%     end
%     SL=source_energy_l(i);
%     SR=source_energy_r(i);
%     SPL=sp_energy_l(i,:);
%     SPR=sp_energy_r(i,:);  
%     S_PHASE_DIFF=source_bands_phase_diff(i);
%     SP_PHASE_DIFF=phase(sum( (g1*sp1_subbands{i,1}+g2*sp2_subbands{i,1}+g3*sp3_subbands{i,1}).* conj(g1*sp1_subbands{i,2}+g2*sp2_subbands{i,2}+g3*sp3_subbands{i,2}) ) ) ; 
%        
%     S=vpasolve([SPL(1)*g1+SPL(2)*g2+SPL(3)*g3==SL,SPR(1)*g1+SPR(2)*g2+SPR(3)*g3==SR,S_PHASE_DIFF==SP_PHASE_DIFF],[g1,g2,g3]);
%    
%     i
%     gain(i,:)=[S.g1 S.g2 S.g3];
%    
% end


%% 利用newton 迭代法求三元一次方程组近似解

% gain=zeros(subbands_number,3); 
% syms g1 g2 g3 
% g0=[1 1 1 ];
% eps=1;
% N=1000;
% 
% for i=1:subbands_number
% 
%     SL=source_energy_l(i);
%     SR=source_energy_r(i);
%     SPL=sp_energy_l(i,:);
%     SPR=sp_energy_r(i,:);  
%     S_PHASE_DIFF=source_bands_phase_diff(i);
%     SP_PHASE_DIFF=phase(sum( (g1*sp1_subbands{i,1}+g2*sp2_subbands{i,1}+g3*sp3_subbands{i,1}).* conj(g1*sp1_subbands{i,2}+g2*sp2_subbands{i,2}+g3*sp3_subbands{i,2}) ) ) ; 
%     
%     f1=SPL(1)*g1+SPL(2)*g2+SPL(3)*g3-SL;
%     f2=SPR(1)*g1+SPR(2)*g2+SPR(3)*g3-SR;
%     f3=S_PHASE_DIFF-SP_PHASE_DIFF;
%     f=[f1 f2 f3];
%     
%     df = [diff(f,'g1'); diff(f, 'g2'); diff(f, 'g3')];
%     df = df';
%     
%     
%     for j = 1:N
%         f = eval(subs(f, {'g1', 'g2', 'g3'}, {g0(1), g0(2), g0(3)}));
%         df = eval(subs(df, {'g1', 'g2', 'g3'}, {g0(1), g0(2), g0(3)}));
%         g = g0 - f/df;
%         if norm(g - g0) < eps
%             fprintf('i=%d\t', i);
%             for k = 1:length(g)
%                 
%                 fprintf('i=%d,%.2f\t', i,g(k));
%             end
%             break;
%         end
%         g0 = g;
%     end
%     
%     
%    
% end


%% 利用最小二乘法求近似解
%各扬声器频域增益
% gain=zeros(subbands_number,3); 
% syms g1 g2 g3 
% 
% for i=1:subbands_number
%     
%     SL=source_energy_l(i);
%     SR=source_energy_r(i);
%     SPL=sp_energy_l(i,:);
%     SPR=sp_energy_r(i,:);  
%     S_PHASE_DIFF=source_bands_phase_diff(i);
%     SP_PHASE_DIFF=phase(sum( (g1*sp1_subbands{i,1}+g2*sp2_subbands{i,1}+g3*sp3_subbands{i,1}).* conj(g1*sp1_subbands{i,2}+g2*sp2_subbands{i,2}+g3*sp3_subbands{i,2}) ) ) ; 
%   
%     f1=SPL(1)*g1+SPL(2)*g2+SPL(3)*g3-SL;
%     f2=SPR(1)*g1+SPR(2)*g2+SPR(3)*g3-SR;
%     f3=S_PHASE_DIFF-SP_PHASE_DIFF;
%     f=[f1;f2;f3];
%     
%     fun=@(g1,g2,g3)[SPL(1)*g1+SPL(2)*g2+SPL(3)*g3-SL;
%                     SPR(1)*g1+SPR(2)*g2+SPR(3)*g3-SR;
%                     S_PHASE_DIFF-SP_PHASE_DIFF;];
%     g0=[1 1 1];
%     options=optimset('Display','iter');
%     
%     [G,fval,exitflag]=fsolve(fun,g0,options);
%     G
% 
%    
% end



