function y = rectwintdac(N)
% RECTWINTDAC Rectangular window for TDAC.
%   y = rectwintdac(N)
%
%   Used in MDCT transform for TDAC
%   Maximum length, maximum overlap window
%
%   N: length of window to create
%   y: the window in column


y = sqrt(0.5)*ones(N,1);