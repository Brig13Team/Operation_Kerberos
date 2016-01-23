/*
    Author: Dorbedo
    
    Description:
        
    
*/
#include "script_component.hpp"
SCRIPT(device_effect_sandstorm_init);

If (hasInterface) exitWith {
    [{
        If !(GVAR(sandstormIsActive)) exitWith {
            [_this select 1] call CBA_fnc_removePerFrameHandler;
            [false] call FUNC(objects_device_effect_sandstorm);
        };
        [true] call FUNC(objects_device_effect_sandstorm);
    } , 1, [] ] call CBA_fnc_addPerFrameHandler;
};

If (isServer) then {
    [{
        [] call FUNC(objects_device_effect_sandstorm_init);
    }, [],-2] call EFUNC(events,globalExec);
};
