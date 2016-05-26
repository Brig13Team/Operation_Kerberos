/*
    Author: Dorbedo
    
    Description:
        shows the loadable cargo
        
    Parameter(s):
        0 : OBJECT - vehicle
        
    Returns:
        ARRAY - ChildActions
*/
#include "script_component.hpp"

_this params [["_vehicle",objNull,[objNull]]];
If (isNull _vehicle) exitWith {[]};

private _load_point_offset = getArray(missionConfigFile >> "logistics" >> "vehicles" >> (typeOf _vehicle) >> "load_point");
private _load_point = _vehicle modelToWorld _load_point_offset;
private _nearObjects = nearestObjects[_load_point, ["AllVehicles","ThingX"], LOADING_DISTANCE];


private _loadActions = [];


{
    _cargo = _x;   
    If ((_vehicle != _cargo)&&{[_vehicle,_cargo] call FUNC(canbeLoaded)}) then {
        private _action = [
            _cargo,
            getText(configFile >> "CfgVehicles" >> typeOf _cargo >> "displayName"),
            "",
            {_this spawn FUNC(doload);},
            {true},
            {},
            [_cargo,_vehicle]
            ] call ace_interact_menu_fnc_createAction;
        _loadActions pushBack [_action,[],_vehicle];
    };
} forEach _nearObjects;
_loadActions;