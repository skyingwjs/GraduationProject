function y = mdctl(x)
% MDCTL Calculates the Modified Discrete Cosine Transform using loops
%   y = mdctl(x)
%
%   Use either a Sine or a Kaiser-Bessel Derived window (KBDWin)with 
%   50% overlap for perfect TDAC reconstruction.
%   Remember that MDCT coefs are symmetric: y(k)=-y(N-k-1) so the full
%   matrix (N) of coefs is: yf = [y;-flipud(y)];
%
%   x: input signal (can be either a column or frame per column)
%   y: MDCT of x
%
%   Slow ! ! !



[flen,fnum] = size(x);
% Make column if it's a single row
if (flen==1)
    x = x(:);
    flen = fnum;
    fnum = 1;
end
% Make sure length is even
if (rem(flen,2)~=0)
    error('MDCT is defined only for even lengths.');
end

% We need these for furmulas below
N  = flen;    % Length of window
M  = N/2;     % Number of coefficients
N0 = (M+1)/2; % Used in the loop

% Frame loop
for i=1:fnum
    % Coefficient loop
    for k=0:(M-1)
        % Initialize
        y(k+1,i) = 0;
        % Sample loop
        for n=0:(N-1)
            y(k+1,i) = y(k+1,i) + x(n+1,i)*cos(pi*(n+N0)*(k+0.5)/M);
        end
    end
end