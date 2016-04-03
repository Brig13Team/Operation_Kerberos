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
_this params ["_cargo",["_player",ACE_player,[objNull]]];
if (_player getVariable [QGVAR(isloading),false]) exitWith {false;};

if (!(isNull attachedTo _cargo)) exitWith {false;};

private _width = getNumber(missionConfigFile >> "logistics" >> "cargos" >> [_cargo] call FUNC(getCargoCfg) >> "width");
If (!(_width>0)) exitWith {false};

private _nearVehicles = nearestObjects[getPos _cargo, ["AllVehicles"], VEHICLE_DETECTION_DISTANCE];

(
    ({(
        
        (_cargo != _x)&&
        {isClass(missionConfigFile >> "logistics" >> "cargos" >> [_cargo] call FUNC(getCargoCfg))}&&
        {[_x,_cargo] call FUNC(canbeLoaded)}&&
        {
            ((_x modelToWorld getArray(missionConfigFile >> "logistics" >> "vehicles" >> (typeOf _x) >> "load_point")) distance _cargo) < LOADING_DISTANCE
        }
    )} count _nearVehicles)
>0)