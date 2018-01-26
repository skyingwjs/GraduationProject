function y = trapezwin(N)
% TRAPEZWIN Trapezoidal window£¨ÌÝÐÎ´°£©.
%   y = trapezwin(N)
%
%   Used in MDCT transform for TDAC.
%   Minimum length, minimum (null) overlap window
%
%   N: length of window to create
%   y: the window in column



if (rem(N,4)~=0)
    error('Window length must be a multiple of 4')
end
N4 = N/4;

% Preallocate window
y = zeros(N,1);

% Flat zero from 0 to N/4-1

% Flat one elsewere
i = (N4:(3*N4-1)).';
y(i+1) = 1;

% Flat zero from 3N/4 to N-1
