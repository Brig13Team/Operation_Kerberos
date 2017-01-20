/*
    Author: iJesuz

    Description:
        Create new Mission

    Parameter(s):
        0 : STRING          - next mission's name
        1 : [STRING,ARRAY]  - [Location Name, Position]

    Return:
        -

*/
#include "script_component.hpp"

private _nextMission  = _this param [0, GVAR(next_mission), [""]];
private _nextLocation = _this param [1, GVAR(next_location), ["",[]]];

private _distance = getNumber (missionNamespace >> "mission_config" >> "main" >> _nextMission >> "location" >> "distance");

// set army
private _armys = getArray (missionConfigFile >> "mission_config" >> "main" >> _nextMission >> "armys");
private _army = [_armys select 0, _armys select 1] call BIS_fnc_selectRandomWeighted;
[_army] call EFUNC(spawn,army_set);


// create task
[_nextMission, _nextLocation] call FUNC(taskmanager_add);

[_nextMission,_nextLocation,_distance] call EFUNC(spawn,createMission);



// initialize next mission
GVAR(current_mission)  = _nextMission;
GVAR(current_location) = _nextLocation;
GVAR(next_mission)  = [_nextMission] call FUNC(taskmanager_choose_mission);
GVAR(next_location) = [_nextLocation] call FUNC(taskmanager_choose_location);
