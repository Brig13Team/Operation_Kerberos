/*
 *  Author: Dorbedo
 *
 *  Description:
 *      updates the strength of a AI group
 *      registers unregistered groups
 *
 *  Parameter(s):
 *      0 : GROUP - The group to register/update
 *
 *  Returns:
 *      ARRAY - [value of the group, strenght of group, defence of group]
 *
 */
//define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params[["_group",grpNull,[grpNull]]];
if (isNull _group) exitWith {[0,[0,0,0],[0,0,0]]};

private _soldiers = (units _group) select {alive _x};
private _vehicles = [];
{
    If (!isNull (assignedVehicle _x)) then {
        _vehicles pushBackUnique (assignedVehicle _x);
    };
} forEach _soldiers;

private _value = 0;
private _strenght = [0,0,0];
private _defence = [0,0,0];

private _fnc_Add = {
    _this params ["_cur","_add"];
    {
        _cur set [_forEachIndex,(_cur select _forEachIndex) max _x];
    } forEach _add;
};

{
    private _curUnit = _x;
    _value = _value + [_curUnit] call FUNC(getCost);
    [_strenght,[_curUnit] call FUNC(getStrenght)] call _fnc_Add;
    [_defence, [_curUnit] call FUNC(getDefence) ] call _fnc_Add;
} forEach (_soldiers + _vehicles);

[_value,_strenght,_defence];
