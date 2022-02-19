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
    status = struct( 'expired', false, 'elapsed', 0, 'remaining', 0, 'value', 0 );
    if 1 == nargin 
        if xTimer( index ).tv > 0
            status.elapsed = toc( uint64( 0 ) ) - xTimer( index ).st;
            status.remaining = xTimer( index ).tv - status.elapsed;
            if status.remaining < 0
                status.remaining = 0;
            end
            status.expired = status.elapsed >= xTimer( index ).tv;
            status.value = xTimer( index ).tv;
        end
    elseif 2 == nargin
        xTimer( index ).tv = varargin{ 2 };
        xTimer( index ).st = toc( uint64( 0 ) );
        status.value = xTimer( index ).tv;
        status.remaining = xTimer( index ).tv;
    end
end

