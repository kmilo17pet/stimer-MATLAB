%STIMER Perform a timer operation (check or set).
%   STATUS = STIMER(INDEX, TVALUE) Sets a timer (a countdown set in 
%   seconds) and returns its status. 
%
%   This function instantiates up to 256 timers and each of them should 
%   be selected by using its own index. To set a new countdown for the 
%   selected timer, just pass the value as the second argument. 
%
%   stimer(1).expired; check the expiration state of the timer 1.
%
%   stimer(1,10); set a new countdown to 10 seconds for the timer 1.
%
%   status = stimer(1); get the current status of timer 1
%
%   See also TIMER, CPUTIME, TIC, TOC.
%
%   Author: J. Camilo Gomez C.
function status = stimer( varargin )
    persistent xTimer

    if isempty( xTimer )
        tmp = num2cell( zeros( 1, 256 ) );
        xTimer = struct( 'st', tmp, 'tv', tmp );
        tic();
    end

    if nargin < 1
        error( 'Timeout index must be supplied' );
    end

    index = varargin{1};
    if any(~isnumeric(index)) || any(isnan(index)) || isempty(index) || any(isinf(index)) || any(~isreal(index))
        error( 'Index argument not allowed, use only integer values from 1 to 256' );
    end
    index = fix(index);
    newtime = 0;

    if any( index <= 0 | index > 256 )
        error( 'Index exceeds the number of timer instances. Index must not exceed 256' );
    end

    if 2 == nargin 
        newtime = varargin{ 2 };
        if any( ~isnumeric( newtime  )) || any( isnan( newtime ) ) || isempty( newtime ) || any( isinf( newtime ) ) || any( ~isreal( newtime ) )
            error( 'Time value argument not allowed, use only positive real numbers' );
        end
        if newtime < 0 
            error( 'Time value can not be negative, use only positive real numbers' );
        end        
    end
    
    if ~isscalar( index ) %operate on multiple requests
        if 1 == nargin 
            status = arrayfun( @timeout, index );
            return;
        elseif 2 == nargin
            status = arrayfun( @timeout, index, varargin{ 2 } );
            return;
        end
    end

    status = struct( 'expired', false, 'elapsed', 0, 'remaining' ,0 );
    if 1 == nargin 
        if xTimer( index ).tv > 0
            status.elapsed = toc( uint64( 0 ) ) - xTimer( index ).st;
            status.remaining = xTimer( index ).tv - status.elapsed;
            if status.remaining < 0
                status.remaining = 0;
            end
            status.expired = status.elapsed >= xTimer( index ).tv;
        end
    elseif 2 == nargin
        xTimer( index ).tv = newtime;
        xTimer( index ).st = toc( uint64( 0 ) );
        status.remaining = newtime;
    else
        error( 'Too many arguments' );
    end
end