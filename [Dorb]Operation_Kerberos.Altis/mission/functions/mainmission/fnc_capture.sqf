/*
 *  Author: Dorbedo, iJesuz
 *
 *  Description:
 *      Mission "Capture"
 *
 *  Parameter(s):
 *      0 : HASH    - mission hash
 *
 *  Returns:
 *      -
 */
#include "script_component.hpp"

_this params ["_mission"];

private _position = HASH_GET(_mission, "location") select 1;

// get settings
private _min = getNumber(missionConfigFile >> "missions_config" >> "main" >> "capture" >> "objectsamount_min");
private _max = getNumber(missionConfigFile >> "missions_config" >> "main" >> "capture" >> "objectsamount_max");
private _avg = (floor (random ((_max - _min) + 1))) + _min;

// spawn target
private _objs = [_position, "capture", _avg] call EFUNC(spawn,createMissionTarget);
{
    _x setVariable [QGVAR(mission), _mission];
    _x setVariable [QGVAR(rescueEvent), QGVAR(commander_captured)];
    _x addEventHandler ["Killed", LINKFUNC(obj_onCommanderKilled)];
} forEach _objs;

// export settings
HASH_SET(_mission, "objects", _objs);
HASH_SET(_mission, "obj_counter_total", count _objs);
HASH_SET(_mission, "obj_counter_1", 0); // captured commanders
HASH_SET(_mission, "obj_counter_2", 0); // killed commanders
HASH_SET(_mission, "condition", QFUNC(mainmission_condition_twoCounters));
