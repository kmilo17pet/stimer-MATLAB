%WARNING Do not call this function directly, instead use stimer().
%   See also STIMER.
function status = fx_stimer_ctrl( varargin )
    persistent xTimer

    if isempty( xTimer )
        tmp = num2cell( zeros( 1, 256 ) );
        xTimer = struct( 'st', tmp, 'tv', tmp );
        tic();
    end

    index = varargin{ 1 };
    elapsed = 0;
    remaining = 0;
    expired = 0;
    value = 0;
    if 1 == nargin 
        if xTimer( index ).tv > 0
            elapsed = toc( uint64( 0 ) ) - xTimer( index ).st;
            remaining = xTimer( index ).tv - elapsed;
            if remaining < 0
                remaining = 0;
            end
            expired = elapsed >= xTimer( index ).tv;
            value = xTimer( index ).tv;
        end
    elseif 2 == nargin
        xTimer( index ).tv = varargin{ 2 };
        xTimer( index ).st = toc( uint64( 0 ) );
        value = xTimer( index ).tv;
        remaining = xTimer( index ).tv;
    end

    status = [ expired, elapsed, remaining, value ];
end

