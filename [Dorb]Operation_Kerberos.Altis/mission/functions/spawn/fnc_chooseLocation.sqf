/*
 *  Author: iJesuz
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

_this params ["_name"];

private _pos = getArray (missionConfigFile >> "mission" >> "main" >> _name >> "location" >> "areas");
private _newPos = [];

{
    private _var = missionNamespace getVariable [_x, [["",[0,0,0]]]];
    _newPos = _newPos + _var;
} forEach _pos;

selectRandom _newPos
