function y = sinewin(N)
% SINEWIN Sine window.ÕýÏÒ´°
%   y = sinewin(N)
%
%   Used in MDCT transform for TDAC
%   Maximum length, maximum overlap sine window
%
%   N: length of window to create
%   y: the window in column


x = (0:(N-1)).';
y = sin(pi*(x+0.5)/N);