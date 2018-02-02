%subject_index:CIPIC库的subject index
%source_theta:单声源的方位(即将要合成的虚拟声像的方位) source_theta=[azi,elev]
%speaker_theta:扬声器方位 speaker_theta=[sp1_azi,sp1_elev;sp2_azi,sp2_elev;sp3_azi,sp3_elev;...]
%gain: 扬声器频域信号增益 gain=[sp1_gain;sp2_gain;sp3_gain;...]

function gain=calcu_speaker_gain(subject_index,source_theta,speaker_theta)

subject_index=1;
source_theta=[0,0];
speaker_theta=[-30,0;30,0;0,22.5];

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

%计算幅度谱
% source_hrtf=abs(source_hrtf);
% sp1_hrtf=abs(sp1_hrtf);
% sp2_hrtf=abs(sp2_hrtf);
% sp3_hrtf=abs(sp3_hrtf);

%将hrtf频谱划分子带
source_subbands=subbands_divide_1024(source_hrtf);
sp1_subbands=subbands_divide_1024(sp1_hrtf);
sp2_subbands=subbands_divide_1024(sp2_hrtf);
sp3_subbands=subbands_divide_1024(sp3_hrtf);


subbands_number=size(source_subbands,2);%子带数

for i=1:2
    for j=1:subbands_number
          source_bands_energy(i,j)=sum(source_subbands{i,j} .*conj(source_subbands{i,j}) );  
          sp1_bands_energy(i,j)=sum(sp1_subbands{i,j} .*conj(sp1_subbands{i,j}) ); 
          sp2_bands_energy(i,j)=sum(sp2_subbands{i,j} .*conj(sp2_subbands{i,j}) ); 
          sp3_bands_energy(i,j)=sum(sp3_subbands{i,j} .*conj(sp3_subbands{i,j}) ); 
    end
end

source_energy_l=source_bands_energy(1,:);
source_energy_r=source_bands_energy(2,:);
sp_energy_l=[sp1_bands_energy(1,:); sp2_bands_energy(1,:); sp3_bands_energy(1,:)];
sp_energy_r=[sp1_bands_energy(2,:); sp2_bands_energy(2,:); sp3_bands_energy(2,:)];


gain=zeros(3,subbands_number);
one=ones(1,subbands_number);
syms g1 g2 g3 
for i=1:subbands_number
    SL=source_energy_l(i);
    SR=source_energy_r(i);
    SPL=sp_energy_l(:,i);
    SPR=sp_energy_r(:,i);    
    S=vpasolve(SPL(1)*g1+SPL(2)*g2+SPL(3)*g3==SL(1),SPR(1)*g1+SPR(2)*g2+SPR(3)*g3==SR,g1*g1+g2*g2+g3*g3==1,g1,g2,g3);
    %gain 可能有很多组解 这里只取第一组解
    gain(:,i)=[S.g1(1) S.g2(1) S.g3(1)]';
end

% i=1;
% for j=1:25
%     band1=sp1_subbands{1,j};   
%     band2=sp2_subbands{1,j}; 
%     band3=sp3_subbands{1,j}; 
%     freq_num=length(band1);
%     band1(1)
%     for k=1:freq_num
%         sythesis_hrtf(i)= band1(k)*gain(1,j)+band2(k)*gain(2,j)+band3(k)*gain(3,j);
%         i=i+1;
%     end
% end    


% 
% for j=1:25
%     sythesis_hrtf(j)= sp1_bands_energy(1,j)*gain(1,j)+sp2_bands_energy(1,j)*gain(2,j)+sp3_bands_energy(1,j)*gain(3,j);   
% end  
% 
% 
% plot(1:25,abs(source_bands_energy(1,:)),'-b',1:25,abs(sythesis_hrtf'),'-r')



