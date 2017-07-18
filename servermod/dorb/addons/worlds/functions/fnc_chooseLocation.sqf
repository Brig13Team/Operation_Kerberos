/*
 *  Author: iJesuz,Dorbedo
 *
 *  Description:
 *      choose mission location
 *
 *  Parameter(s):
 *      0 : STRING  - mission type
 *
 *  Returns:
 *      [STRING,ARRAY]
 */
#include "script_component.hpp"

_this params ["_allLocationtypes"];

private _newPos = [];

{
    private _var = missionNamespace getVariable _x;
    If !(isNil "_var") then {
        _newPos = _newPos + _var;
    };
} forEach _allLocationtypes;

selectRandom _newPos
