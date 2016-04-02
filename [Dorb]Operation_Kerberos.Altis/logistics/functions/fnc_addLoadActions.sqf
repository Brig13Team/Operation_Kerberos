/*
    Author: Dorbedo
    
    Description:
        shows the loadable cargo
        
    Parameter(s):
        0 : OBJECT - Target
        
    Returns:
        ARRAY - ChildActions
*/
#include "script_component.hpp"

_this params [["_target",objNull,[objNull]]];
CHECKRET(isNull _target,[]);

private _load_point_offset = getArray(missionConfigFile >> "logistics" >> "vehicles" >> (typeOf _target) >> "load_point");
private _load_point = _target modelToWorld _load_point_offset;
private _nearObjects = nearestObjects[_load_point, ["AllVehicles","ThingX"], 3];


private _loadActions = [];


{
    _cargo = _x;   
    If ((_target != _cargo)&&{[_target,_cargo] call FUNC(canbeLoaded)}) then {
        private _action = [
            _cargo,
            getText(configFile >> "CfgVehicles" >> typeOf _cargo >> "displayName"),
            "",
            {_this spawn FUNC(doload);},
            {true},
            {},
            [_target,_cargo]
            ] call ace_interact_menu_fnc_createAction;
        _loadActions pushBack [_action,[],_target];
    };
} forEach _nearObjects;
_loadActions;