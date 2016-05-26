/*
    Author: Dorbedo
    
    Description:
        Checks if Unit can load
        
    Parameter(s):
        0 : OBJECT - Target
        
    Returns:
        BOOL
*/
#include "script_component.hpp"
_this params ["_target",["_player",ACE_player,[objNull]]];
if (_player getVariable [QGVAR(isloading),false]) exitWith {false;};

if (!(isNull attachedTo _target)) exitWith {false;};

private _vehicle_class = typeOf _target;
private _max_width = getNumber(missionConfigFile >> "logistics" >> "vehicles" >> _vehicle_class >> "max_width");
private _load_point_offset = getArray(missionConfigFile >> "logistics" >> "vehicles" >> _vehicle_class >> "load_point");
If (!(_max_width>0)) exitWith {false};

private _load_point = _target modelToWorld _load_point_offset;
private _nearObjects = nearestObjects[_load_point, ["AllVehicles","ThingX"], LOADING_DISTANCE];

(
    ({([_target,_x] call FUNC(canbeloaded))} count _nearObjects)
>0)