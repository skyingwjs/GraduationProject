function y = winit(x,wintype)
%—————给信号加窗————————————————————————————————
% WINIT Applies a window to a signal.
%   y = winit(x,wintype)
%
%   Applies window to a signal. Includes extra windows that guarantee
%   perfect TDAC MDCT reconstruction.
%
%   x:       input signal    
%   wintype: window name eg: 'hanning'(default), 'sinewin', 'kbdwin'
%            'lowin'
%   y:       windowed signal   输出加窗的信号



% Check arguments
if (nargin < 2)
    wintype = 'hanning';
end

[flen,fnum] = size(x);%flen:帧长   fnum：帧数目
% Make column
if (flen==1)
    x = x(:);
end

switch wintype
case 'rectwintdac'
    % For TDAC in MDCT
    % Never used in practice only theoritical use
    w = rectwintdac(flen);
case 'trapezwin'
    % For TDAC in MDCT
    % Never used in practice only theoritical use
    w = trapezwin(flen);
case 'sinewin'
    % For TDAC in MDCT
    w = sinewin(flen);
case 'kbdwin'
    % For TDAC in MDCT
    w = kbdwin(flen,6.5);
case 'lowin'
    % For Low-Overlap TDAC in MDCT (transients)
    w = lowin(flen);
case 'oggwin'
    % For Low-Overlap TDAC in MDCT (transients)
    w = oggwin(flen);
otherwise
    w = window(wintype,flen);
end
% Tony's Trick produces a very large intermediate variable
% We use the sparse matrix trick instead (mathworks.com Tech-Note 1109)
% Multiplies each column of the signal x by w !!!
y = diag(sparse(w)) * x;%sparse稀疏表示
