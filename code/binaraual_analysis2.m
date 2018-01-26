%———————根据实验得到的双耳信号进行分析————————————————
clc;
clear all;
initpath();

azi_single=0:5:30;
azi_loudspeaker=[-30 30];

for i=1:length(azi_single)
    VBAP_gain_factor(i,:)=get_init_gain(azi_loudspeaker,azi_single(i))
end

%主观测试最接近  left_gain
subject_left_gain_0=[0.635,0.68,0.635,0.66,0.665,0.685,0.665];
subject_left_gain_5=[0.545,0.57,0.57,0.59,0.53,0.565,0.545];
subject_left_gain_10=[0.42,0.46,0.42,0.46,0.465,0.47,0.455];
subject_left_gain_15=[0.305,0.365,0.27,0.27,0.36,0.365,0.375,0.355];
subject_left_gain_20=[0.16,0.21,0.145,0.15,0.18];
subject_left_gain_25=[0.05,0.105,0.05,0.04,0.03,0.05];
subject_left_gain_30=[0,0,0,0,0,0];

%主观测试最接近  right_gain
subject_left_gain_0=mean(subject_left_gain_0);
subject_left_gain_5=mean(subject_left_gain_5);
subject_left_gain_10=mean(subject_left_gain_10);
subject_left_gain_15=mean(subject_left_gain_15);
subject_left_gain_20=mean(subject_left_gain_20);
subject_left_gain_25=mean(subject_left_gain_25);
subject_left_gain_30=mean(subject_left_gain_30);


VBAP_left_gain=VBAP_gain_factor(:,1);
% subject_left_gain=[0.68,0.57,0.46,0.365,0.21,0.105,0];%wjs
subject_left_gain=[subject_left_gain_0,subject_left_gain_5,subject_left_gain_10,subject_left_gain_15,subject_left_gain_20,subject_left_gain_25,subject_left_gain_30];
subject_left_gain=subject_left_gain';

VBAP_left_gain(find(VBAP_left_gain==0))=eps;
subject_left_gain(find(subject_left_gain==0))=eps;

VBAP_gain_ratio=VBAP_left_gain./sqrt(1-VBAP_left_gain.^2);
subject_gain_ratio=subject_left_gain./sqrt(1-subject_left_gain.^2);

figure(1);
plot(azi_single,VBAP_gain_ratio,'-*r');
hold on;
plot(azi_single,subject_gain_ratio,'-og');

xlabel('单声源方位角');
ylabel('左右扬声器增益比');
title('主观感知与VBAP估计的扬声器增益偏差');
legend('VBAP估计的扬声器增益比','主观感知所对应的扬声器增益比');






