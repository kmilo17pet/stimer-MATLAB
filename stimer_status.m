classdef stimer_status
    % stimer_status A class to describe the current status of a sTimer
    %
    % stimer_status Properties:
    %    expired - True if the programed time value expires.
    %    elapsed - Elapsed time of the selected timer in seconds.  
    %    remaining - Remaining time of the selected timer in seconds.
    %    value - The current programmed value of the timer in seconds.    
    properties ( SetAccess=immutable )
        expired
        elapsed
        remaining
        value
    end
    
    methods
        function obj = stimer_status( expired, elapsed, remaining, value)
            obj.expired = logical(expired);
            obj.elapsed = seconds(elapsed);
            obj.remaining = seconds(remaining);
            obj.value = seconds(value);
        end
    end
end