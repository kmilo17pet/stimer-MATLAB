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

get the current status of timer 1
```
status = stimer(1); 
``` 
 
## from Simulink

![image](https://user-images.githubusercontent.com/11412210/154200053-0060274e-d7d9-42b8-9103-c396cd8d8dcc.png)
