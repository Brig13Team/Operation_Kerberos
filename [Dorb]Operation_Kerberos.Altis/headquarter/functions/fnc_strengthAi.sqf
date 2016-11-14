/*
 *  Author: Dorbedo
 *
 *  Description:
 *      updates the strenght of a AI group
 *      registers unregistered groups
 *
 *  Parameter(s):
 *      0 : GROUP - The group to register/update
 *
 *  Returns:
 *      ARRAY - [type of group, value of group, threat of group]
 *
 */
#include "script_component.hpp"

_this params[["_group",grpNull,[grpNull]]];
if (isNull _group) exitWith {[-1,-1]};

private _soldiers = (units _group) select {alive _x};
private _vehicles = [];

private _threat = [0,0,0];
private _value = 0;
private _type = 0;
{
    If (!isNull (assignedVehicle _x)) then {
        _vehicles pushBackUnique (assignedVehicle _x);
    };
    private _temp = getArray(configFile >> "CfgVehicles" >> (typeOf _x) >> "threat");
    If !(_temp isEqualTo []) then {
        _threat = [
            (_threat select 0) max (_temp select 0),
            (_threat select 1) max (_temp select 1),
            (_threat select 2) max (_temp select 2),
        ];
    };
    _value = _value + ([typeOf _x] call FUNC(getCost));
}forEach _soldiers;


{
    _type = _type max (getNumber(configFile >> "CfgVehicles" >> (typeOf _x) >> "type"));
    private _temp = getArray(configFile >> "CfgVehicles" >> (typeOf _x) >> "threat")
    If !(_temp isEqualTo []) then {
        _threat = [
            (_threat select 0) max (_temp select 0),
            (_threat select 1) max (_temp select 1),
            (_threat select 2) max (_temp select 2),
        ];
    };
    _value = _value + ([typeOf _x] call FUNC(getCost));
} forEach _vehicles

[_type,_value,_threat];
