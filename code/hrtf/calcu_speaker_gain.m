%subject_index:CIPIC库的subject index
%source_theta:单声源的方位(即将要合成的虚拟声像的方位) source_theta=[azi,elev]
%speaker_theta:扬声器方位 speaker_theta=[sp1_azi,sp1_elev;sp2_azi,sp2_elev;sp3_azi,sp3_elev;...]
%gain: 扬声器频域信号增益 gain=[sp1_gain;sp2_gain;sp3_gain;...]
%type: 子带划分类型，通过subbands_type(type)可获得不同子带划分方式的数据

function gain=calcu_speaker_gain(subject_index,source_theta,speaker_theta,start_end_index)



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

syms g1 g2 g3 
% N=100;
% eps=0.001;
% g0=[1 1 1];
% assume(g1>=0);
% assume(g2>=0);
% assume(g3>=0);
%各扬声器各子带加权hrtf能量之和与原始声源处各子带hrtf能量和守恒
for i=1:subbands_number
%     SL=  sqrt(source_energy_l(i));
%     SR=  sqrt(source_energy_r(i));
%     SPL= sqrt(sp_energy_l(i,:));
%     SPR= sqrt(sp_energy_r(i,:));    
    SL=  source_energy_l(i);
    SR=  source_energy_r(i);
    SPL= sp_energy_l(i,:);
    SPR= sp_energy_r(i,:);
    

    S=vpasolve( [SPL(1)*g1+ SPL(2)*g2+ SPL(3)*g3==SL,SPR(1)*g1+SPR(2)*g2+SPR(3)*g3==SR,g1*g1+g2*g2+g3*g3==1],[g1,g2,g3]);
    %gain 可能有很多组解 这里只取第一组解
    gain(i,:)=[S.g1(1) S.g2(1) S.g3(1)]';
end

end



