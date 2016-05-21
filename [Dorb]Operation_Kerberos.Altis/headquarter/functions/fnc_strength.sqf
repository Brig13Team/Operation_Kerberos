/*
    Author: Dorbedo
    
    Description:
        updates_strength
        do not call directly
    
    Parameter(s):
        none

    Returns:
        none
*/
#include "script_component.hpp"
_this params[["_group",grpNull,[grpNull]]];
if (isNull _group) exitWith {[-1,-1]};

private _soldiers = (units _group) select {alive _x};
private _vehicles = [];

private _thread = [0,0,0];
private _value = 0;
private _type = 0;
{
    If (!isNull (assignedVehicle _x)) then {
        _vehicles pushBackUnique (assignedVehicle _x);
    };
    private _temp = getArray(configFile >> "CfgVehicles" >> (typeOf _x) >> "thread");
    If !(_temp isEqualTo []) then {
        _thread = [
            (_thread select 0) max (_temp select 0),
            (_thread select 1) max (_temp select 1),
            (_thread select 2) max (_temp select 2),
        ];
    };
    _value = _value + getNumber(configFile >> "CfgVehicles" >> (typeOf _x) >> "cost");
}forEach _soldiers;


{
    _type = _type max (getNumber(configFile >> "CfgVehicles" >> (typeOf _x) >> "type"));
    private _temp = getArray(configFile >> "CfgVehicles" >> (typeOf _x) >> "thread")
    If !(_temp isEqualTo []) then {
        _thread = [
            (_thread select 0) max (_temp select 0),
            (_thread select 1) max (_temp select 1),
            (_thread select 2) max (_temp select 2),
        ];
    };
    _value = _value + getNumber(configFile >> "CfgVehicles" >> (typeOf _x) >> "cost");
} forEach _vehicles

[_type,_value,_thread];