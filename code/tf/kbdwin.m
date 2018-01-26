function y =  kbdwin( N ,alpha)
%��������������������Kaiser�CBessel Derived (KBD) window ��������������������������������������������������������
%��������������������NΪ����Ĵ������������Ϊż�����ô���Ҫʹ����1024��MDCT��������������������������������������
%��������������������alpha=4������ѧ�߲��Ե�������ֵ��������������������������������������������������������������

% KBDWIN Kaiser-Bessel Derived window.
%   y = kbdwin(N,alpha)
%
%   Used in MDCT transform for TDAC
%
%   N:   length of window to create
%   alpha: alpha parameter for window shape
%   y:     the window in column

% Original C code by:
% Programmer:    Craig Stuart Sapp <craig@ccrma.stanford.edu>
% Creation Date: Sat Jan 27 14:27:14 PST 2001
% Last Modified: Sat Jan 27 15:24:58 PST 2001
% Filename:      kbdwindow.cpp
% $Smake:        g++ -O6 -o %b %f
% Syntax:        C++; functions in ANSI C
%
% Description:   This is a sample program for generating
%                Kaiser-Bessel Derived Windows for audio signal
%                processing -- in particular for the Time-Domain
%                Alias Cancellation procedure which has the
%                overlap-add requirements:
%                   Window_m[N-1-n] + Window_m+1[n]^2 = 1.0;
%                which means: The squares of the overlapped
%                windows must add to the constant value 1.0
%                for time domain alias cancellation to work.
%
%                The two function necessary to create the KBD window are:
%                   KBDWindow -- calculates the window values.
%                   BesselI0  -- bessel function needed for KBDWindow.


M=N/2;    %KBD������Ҫ���õ�Kaiser����ΪN/2+1 
n=0:N/2;
% alpha=4;
wn=besseli(0,pi*alpha*sqrt(1-(2*n/(M-1)-1).^2))/besseli(0,pi*alpha);    %MATLAB�Դ�Kaiser���е�beta��pi*alpha

y=zeros(N,1);
temp=sum(wn);
    for n=1:N/2
        y(n)=sqrt(sum(wn(1:n))/temp);
    end
    
    for n=N/2+1:N
        y(n)=sqrt(sum(wn(1:N+1-n))/temp);
    end
end
