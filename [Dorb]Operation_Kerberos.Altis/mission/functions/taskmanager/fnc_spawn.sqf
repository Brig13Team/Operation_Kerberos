/*
    Author: iJesuz, Dorbedo

    Description:
        create new mission

    Parameter(s):
        0 : STRING          - next mission's name
        1 : [STRING,ARRAY]  - [Location Name, Position]

    Return:
        -

*/
#include "script_component.hpp"

private _mission = _this param [0, "", [""]];
private _location = _this param [1, [], ["",[]]];

if (!(THIS_GET("next_mission") isEqualTo "")) then { _mission = THIS_GET("next_mission"); };
if (_mission isEqualTo "") exitWith { -1 };
if (!(THIS_GET("next_location") isEqualTo [])) then { _location = THIS_GET("next_location"); };
if (_location isEqualTo []) exitWith { -1 };

private _distance = getNumber (missionConfigFile >> "mission_config" >> "main" >> _nextMission >> "location" >> "distance");

// set army
private _init = {
    _this params ["_name"];

    private _armys = getArray (missionConfigFile >> "mission_config" >> "main" >> _name >> "armys");
    private _army = [_armys,1] call EFUNC(common,sel_array_weighted);
    // private _army = [_armys select 0, _armys select 1] call BIS_fnc_selectRandomWeighted;
    [_army select 0] call EFUNC(spawn,army_set);
};

// spawn army and defence stuff
private _post = {
    _this params ["_name", "_location"]
    // [_location select 1] call EFUNC(spawn,createMission);
};

// create task
TRACEV_2(_nextMission,_nextLocation);
[_nextMission, _nextLocation, _pre, _post] call FUNC(taskmanager_add);
