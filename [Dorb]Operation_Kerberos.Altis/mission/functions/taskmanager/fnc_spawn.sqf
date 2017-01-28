/*
    Author: iJesuz,Dorbedo

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

private _distance = getNumber (missionConfigFile >> "mission_config" >> "main" >> _nextMission >> "location" >> "distance");

// set army
private _armys = getArray (missionConfigFile >> "mission_config" >> "main" >> _nextMission >> "armys");
private _army = [_armys,1] call EFUNC(common,sel_array_weighted);
//private _army = [_armys select 0, _armys select 1] call BIS_fnc_selectRandomWeighted;
[_army select 0] call EFUNC(spawn,army_set);


// create task
TRACEV_2(_nextMission,_nextLocation);
private _curMainTaskID = [_nextMission, _nextLocation] call FUNC(taskmanager_add);
// spawn all the missionthings
[_nextLocation select 1] call EFUNC(spawn,createMission);
/*
// setUp the sidemissions
private _allSideMissions = configProperties [(missionConfigFile >> "mission_config" >> "main" >> _nextMission >> "sidemissions"), "(getNumber(_x >> 'probability') > (random 1))", true];
{
    private _delaySpawn = abs(getNumber(missionConfigFile >> "mission_config" >> "side" >> configName _x >> "spawn_delay")) + 5;
    [
        LINKFUNC(taskmanager_spawnSide),
        [_x,_nextMission,_nextLocation,_curMainTaskID],
        _delaySpawn
    ] call CBA_fnc_waitAndExecute;
} forEach _allSideMissions;
*/
[QEGVAR(mission,start),[_nextLocation select 1,_nextMission]] call CBA_fnc_localEvent;
// initialize next mission
GVAR(current_mission)  = _nextMission;
GVAR(current_location) = _nextLocation;
GVAR(next_mission)  = [nil,_nextMission] call FUNC(taskmanager_choose_mission);
GVAR(next_location) = [GVAR(next_mission),_nextLocation] call FUNC(taskmanager_choose_location);
