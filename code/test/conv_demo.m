clc;
clear all;
A=[1 2 3 4];
B=[5 6 7 8 9 10];
C=conv(A,B)

A1=fft(A,9);
B1=fft(B,9);
C1=ifft(A1.*B1)

