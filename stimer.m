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
%   stimer(3,minutes(2)); set a new countdown to 2 minutes for the timer 3.
%
%   stimer( [1 2 3], [minutes(5) hours(2) 30] ); set multiple timers simultaneously.
%
%   status = stimer(1); get the current status of timer 1
%
%   See also TIMER, CPUTIME, TIC, TOC, DURATION, MILLISECONDS, SECONDS, MINUTES, HOURS, DAYS, YEARS.
%
%   Author: J. Camilo Gomez C.
function status = stimer( varargin )
    narginchk( 1, 2 );
    isBadArgument = @( arg ) any( ~isnumeric( arg ) ) || any( isnan( arg ) ) || isempty( arg ) || any( isinf( arg) ) || any( ~isreal( arg ) );
    
    varargin{ 1 } = fix( varargin{ 1 } );
    if isBadArgument( varargin{ 1 } )
        error( 'Index argument not allowed, use only integer values from 1 to 256' );
    end

    if any( varargin{ 1 } <= 0 | varargin{ 1 } > 256 )
        error( 'Index exceeds the number of timer instances. Index must not exceed 256' );
    end

    if 2 == nargin 
        if isduration( varargin{ 2 } )
            varargin{ 2 } = seconds( varargin{ 2 } );
        end
        if isBadArgument( varargin{ 2 } )
            error( 'Time value argument not allowed, use only positive real numbers' );
        end
        if varargin{ 2 } < 0 
            error( 'Time value can not be negative, use only positive real numbers' );
        end        
    end

    if ~isscalar( varargin{ 1 } ) %operate on multiple requests
        status = arrayfun( @stimer, varargin{:} );
        return;
    end

    s = fx_stimer_ctrl( varargin{:} );
    status = stimer_status( s(1), s(2), s(3), s(4) );
end
