clc;
clear all;
len=1024;
%！！！！！！！！！！plot kbdwin！！！！！！！！！！！！！！！！！！！！！！！！！！！！
alpha1=4;
alpha2=6.5;
y1 =  kbdwin( len ,alpha1);
figure(1);
plot(y1);
title('kbdwin len=1024 alpha=4');
axis([0 1024 0 1 ]);

y2=kbdwin(len ,alpha2);
figure(2);
plot(y2);
title('kbdwin len=1024 alpha=6.5');
axis([0 1024 0 1 ]);

%！！！！！！！！！！plot sinwin！！！！！！！！！！！！！！！！！！！！！！！！！！！！
y3=sinwin(len)
figure(3)
plot(y3)
title('sinwin len=1024')
axis([0 1024 0 1 ]);

%！！！！！！！！！！plot trapezwin！！！！！！！！！！！！！！！！！！！！！！！！！！！！
y4=trapezwin(len)
figure(4)
plot(y4)
title('trapezwin len=1024')
axis([0 1024 0 1 ]);

%！！！！！！！！！！plot oggwin！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！
y5=oggwin(len)
figure(5)
plot(y5)
title('oggwin len=1024')
axis([0 1024 0 1 ]);

%！！！！！！！！！！plot lowin！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！
y6=lowin(len)
figure(6)
plot(y6)
title('lowin len=1024')
axis([0 1024 0 1 ]);

%！！！！！！！！！！plot rectwintdac！！！！！！！！！！！！！！！！！！！！！！！！！！！！
y7=rectwintdac(len)
figure(7)
plot(y7)
title('rectwintdac len=1024')
axis([0 1024 0 1 ]);


