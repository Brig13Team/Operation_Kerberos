/*
    Author: iJesuz

    Description:
        Choose mission location

    Parameter(s):
        0 : STRING          - Mission name
        1 : [STRING,ARRAY]  - [Locatoin Name, Position]

    Return:
        [STRING,ARRAY]

*/
#include "script_component.hpp"

_this params [["_mission", "", [""]], ["_oldPos", ["",[]], ["",[]]]];

private _pos = getArray (missionConfigFile >> "missions_config" >> "main" >> _mission >> "location" >> "areas");
private _newPos = [];

{
	private _var = missionNamespace getVariable [_x, [[0,0,0]]];
	_newPos = _newPos + _var;
} forEach _pos;
_newPos = _newPos - _oldPos;

selectRandom _newPos