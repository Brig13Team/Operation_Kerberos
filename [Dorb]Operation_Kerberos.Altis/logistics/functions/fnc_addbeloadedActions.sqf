/*
    Author: Dorbedo
    
    Description:
        shows the loadable vehicles
        
    Parameter(s):
        0 : OBJECT - cargo
        
    Returns:
        ARRAY - ChildActions
*/
#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [["_cargo",objNull,[objNull]]];
If (isNull _cargo) exitWith {[]};


private _nearVehicles = nearestObjects[getPos _cargo, ["AllVehicles"], VEHICLE_DETECTION_DISTANCE];
private _loadingActions = [];

{
    private _vehicle = _x;
    If (
        (_cargo != _vehicle)&&
        {isClass(missionConfigFile >> "logistics" >> "cargos" >> [_cargo] call FUNC(getCargoCfg))}&&
        {isClass(missionConfigFile >> "logistics" >> "vehicles" >> typeOf _vehicle)}&&
        {[_vehicle,_cargo] call FUNC(canbeLoaded)}&&
        {
            ((_vehicle modelToWorld getArray(missionConfigFile >> "logistics" >> "vehicles" >> (typeOf _vehicle) >> "load_point")) distance _cargo) < LOADING_DISTANCE
        }
        ) then {
        private _action = [
            _vehicle,
            getText(configFile >> "CfgVehicles" >> typeOf _vehicle >> "displayName"),
            "",
            {_this spawn FUNC(doload);},
            {true},
            {},
            [_cargo,_vehicle]
            ] call ace_interact_menu_fnc_createAction;
        _loadingActions pushBack [_action,[],_vehicle];
    };
} forEach _nearVehicles;
_loadingActions;