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

private _pos = getArray (missionConfigFile >> "mission_config" >> "main" >> _mission >> "location" >> "areas");
_pos = _pos - [_oldPos];

_pos apply (missionNamespace getVariable [_x,[]]);

selectRandom selectRandom _pos
