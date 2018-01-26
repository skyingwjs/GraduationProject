% page overview:
% 
% Let's see how we can implement various MDCT algorithms in Matlab and at the same time let the Giraffe help this page be easily searchable in Google. For now I am only including the m-files without proofs. However, one can easily understand the code since it's well commented. If you're curious about the various Matlab tricks I use take a look at my Matlab tips and tricks page.
% sanity check:
% 
% Here is a simple example to test the MDCT functionality.
% Here I am using the mdct4(), imdct4() pair but you can use any version and notice the speed difference.
% 
% randn('state',0); % seed the generator to get the same results
% x  = randn(10000,1); % our test signal
% [fx,fpad] = linframe(x,128,256,'sym'); % hop=128 and win=256, thus 50% overlap
% fx = winit(fx,'kbdwin'); % kbd win is TDAC
% FX = mdct4(fx);
% fy = imdct4(FX);
% fy = winit(fy,'kbdwin'); % rewindow
% y  = linunframe(fy,128,fpad); % OLA
% e  = mean((x-y).^2) % so our error for mdct4
% e =
%    1.0962e-31
% MDCT m-files:
% 
% Note that all the functions follow Matlab's fft() interface. 
% This means that if a 2D matrix is passed as an argument to any of the mdctX() functions, 
% then the mdct of each column is performed and returned in a 2D matrix. 
% This way one can speed up per frame processing, since it's possible to avoid loops completely.
% 
%     Naive with three nested loops. Fwd: mdctl.m, Inv: imdctl.m
%     Not so naive substituting loops with matrix operations. Fwd: mdctv.m, Inv: imdctv.m
%     Moderately naive using a 2*N-point FFT. (To be added)
%     Clever using an N-point FFT. (To be added)
%     Really clever using an N/2-point FFT. (To be added)
%     Super smart using an N/4-point FFT. Fwd: mdct4.m, Inv. imdct4.m
%     Recursive (To be added)
% 
% TDAC Window m-files:
% 
%     Rectangular: rectwintdac.m
%     Trapezoidal: trapezwin.m
%     Sinusoid: sinewin.m
%     Kaiser-Bessel Derived: kbdwin.m, kbdwin.c, kbdwin.dll (windows), kbdwin.mexglx (linux)
%     (mex-file, setup your compiler with 'mex -setup' and compile using 'mex kbdwin.c')
%     Low-Overlap: lowin.m
%     Ogg-Vorbis: oggwin.m
% 
% misc m-files:
% 
%     vectorized framing: linframe.m
%     vectorized OLA: linunframe.m
%     vectorized windowing: winit.m
%     fast ind2sub: ind2sub2.m
% 

