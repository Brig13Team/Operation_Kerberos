/*
    Author: Dorbedo
    
    Description:
        postinit client
*/
#include "script_component.hpp"

CHECK(!hasInterface)

If (isNil QGVAR(sandstormIsActive)) then {GVAR(sandstormIsActive) = false;};
[] spawn FUNC(objects_device_effect_sandstorm_init);


[QGVAR(earthquake),{
    If (!(vehicle player isKindOf "Air")) then {
        _this params ["_strenght"];
        [_rand]spawn BIS_fnc_earthquake;
    };
}] call EFUNC(events,addEventHandler);

