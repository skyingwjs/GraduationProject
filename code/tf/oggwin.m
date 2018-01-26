function y = oggwin(N)
% OGGWIN Ogg-vorbis window.
%   y = oggwin(N)
%
%   Used in MDCT transform for TDAC
%   The window used in Ogg-Vorbis open source codec
%
%   N: length of window to create
%   y: the window in column


x = (0:(N-1)).';
y = sin(0.5*pi*sin(pi*(x+0.5)/N).^2); 