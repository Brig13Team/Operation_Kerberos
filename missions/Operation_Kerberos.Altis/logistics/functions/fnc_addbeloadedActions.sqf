/*
    Author: Dorbedo

    Description:
        shows the loadable vehicles

    Parameter(s):
        0 : OBJECT - cargo

    Returns:
        ARRAY - ChildActions
*/
#include "script_component.hpp"

_this params [["_cargo",objNull,[objNull]]];
CHECKRET(isNull _cargo,[]);

private _nearVehicles = nearestObjects[getPos _cargo, ["AllVehicles"], VEHICLE_DETECTION_DISTANCE, true];
private _loadActions = [];

{
    private _vehicle = _x;
    If (
        (_cargo != _vehicle)&&
        {isClass(missionConfigFile >> "logistics" >> "cargos" >> [_cargo] call FUNC(getCargoCfg))}&&
        {isClass(missionConfigFile >> "logistics" >> "vehicles" >> typeOf _vehicle)}&&
        {[_vehicle,_cargo] call FUNC(canbeLoaded)}&&
        {
            ((_vehicle modelToWorldWorld getArray(missionConfigFile >> "logistics" >> "vehicles" >> (typeOf _vehicle) >> "load_point")) distance (getPosASL _cargo)) < LOADING_DISTANCE
        }
        ) then {
        private _action = [
            _vehicle,
            [typeOf _vehicle,"displayName",""] call EFUNC(common,getCfgVehicles),
            "",
            {_this spawn FUNC(doload);},
            {true},
            {},
            [_cargo,_vehicle]
            ] call ace_interact_menu_fnc_createAction;
        _loadActions pushBack [_action,[],_vehicle];
    };
} forEach _nearVehicles;
_loadActions;
