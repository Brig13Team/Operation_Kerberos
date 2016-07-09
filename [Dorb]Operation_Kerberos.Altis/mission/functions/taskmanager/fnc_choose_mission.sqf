/*
    Author: iJesuz, Dorbedo

    Description:
        Choose mission

    Parameter(s):
        0 : CONFIG  - MissionConfigClass which contains the mission classes
        1 : STRING  - mission name to be scipted

    Return:
        [STRING,ARRAY]

*/
#include "script_component.hpp"


_this params [["_cfg", missionConfigFile >> "mission_config" >> "main", [missionConfigFile]], ["_oldMission", "", [""]]];

private _mission = [];

{
    _mission pushBack [configName _x, getNumber (_x >> "propability")];
} forEach _cfg;
_mission = _mission - [_oldMission];

// ([_taskarray,1] call EFUNC(common,sel_array_weighted)) select 0;
[_mission select 0, _mission select 1] call BIS_fnc_selectRandomWeighted;
