/*
    Author: Dorbedo
    
    Description:
        Returns the rotation angles of an rotation matrix
        
    Parameter(s):
        0 : ARRAY    - rotation matrix
    
    Return
        [alpha,betha,gamma]
*/
#include "script_component.hpp"
_this params ["_rotMatrix"];
CHECKRET(_rotMatrix isEqualTo [],[]);
CHECKRET((count (_rotMatrix select 0) !=3),[]);
[((_rotMatrix select 0) select 1) atan2 ((_rotMatrix select 0) select 0),
 (-((_rotMatrix select 0) select 2)) atan2 (sqrt((((_rotMatrix select 0) select 0)^2)+(((_rotMatrix select 0) select 1)^2))),
 ((_rotMatrix select 1) select 2) atan2 ((_rotMatrix select 2) select 2)];