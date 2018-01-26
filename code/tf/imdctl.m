function y = imdctl(x)
% IMDCTL Calculates the Modified Discrete Cosine Transform using loops
%   y = imdctl(x)
%
%   x: input signal (can be either a column or frame per column)
%   y: IMDCT of x
%
%   Slow ! ! !



[flen,fnum] = size(x);
% Make column if it's a single row
if (flen==1)
    x = x(:);
    flen = fnum;
    fnum = 1;
end

% We need these for furmulas below
M  = flen;    % Number of coefficients
N  = 2*M;     % Length of window
N0 = (M+1)/2; % Used in the loop
N4 = N/4;     % Do we really need the division by N/4 ?

% Frame loop
for i=1:fnum
    % Sample loop
    for n=0:(N-1)
        % Initialize
        y(n+1,i) = 0;
        % Coefficient loop
        for k=0:(M-1)
            y(n+1,i) = y(n+1,i) + x(k+1,i)*cos(pi*(n+N0)*(k+0.5)/M)/N4;
        end
    end
end