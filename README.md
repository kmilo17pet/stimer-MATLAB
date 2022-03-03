[![View stimer on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://la.mathworks.com/matlabcentral/fileexchange/106220-stimer)

# stimer-MATLAB
a nonblocking timer implementation for MATLAB and Simulink

## from MATLAB

stimer Perform a timer operation (check or set).  Sets a timer (a countdown set in seconds) and returns its status. 


This function instantiates up to 256 timers and each of them should be selected by using its own index. To set a new countdown for the selected timer, just pass the value as the second argument. 
 
check the expiration state of the timer 1. 
``` 
stimer(1).expired; 
```

set a new countdown to 10 seconds for the timer 1.
```
stimer(1,10); 
``` 

set a new countdown to 2 minutes for the timer 3.
```
stimer(3,minutes(2));
```

set multiple timers simultaneously.
```
stimer( [1 2 3], [minutes(5) hours(2) 30] );
```

get the current status of timer 1
```
status = stimer(1); 
``` 
 
## from Simulink

![Simulink library](https://user-images.githubusercontent.com/11412210/154407877-b18fe958-b94a-40ee-8476-9bf5fcee4a84.png)

