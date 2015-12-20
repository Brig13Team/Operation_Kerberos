/*
    Author: Dorbedo
    
    Description:
    
    Requirements:
    
    Parameter(s):
        0 : ARRAY    - Example
        1 : ARRAY    - Example
        2 : STRIN    - Example
    
    Return
    BOOL
*/
#include "script_component.hpp"
SCRIPT(found_intel);
PARAMS_1(_obj);


_obj addAction [localize LSTRING(INTEL_GRAB), 
    {
        deleteVehicle (_this select 0);
        [{[_this select 0,format[localize (_this select 1),_this select 2]] spawn EFUNC(interface,disp_message);},[LSTRING(INTEL_TASK),LSTRING(INTEL_FOUND),name player],-1] call EFUNC(common,NetEvent);
    },[], 2, true, true, "",""];