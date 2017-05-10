/*
 *  Author: iJesuz, Dorbedo
 *
 *  Description:
 *      Checks the counter
 *
 *  Parameter(s):
 *      0 : LOCATION - the mission
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params ["_mission"];

private _position = HASH_GET(_mission, "location") select 1;
private _tickets = getNumber(missionConfigFile >> "mission" >> "main" >> "hold" >> "object" >> "tickets");
private _multiplier = getNumber(missionConfigFile >> "mission" >> "main" >> "hold" >> "object" >> "multiplier");
private _radius = ["hold"] call FUNC(spawn_getRadius);


HASH_SET(_mission, "obj_counter_total", _tickets);
HASH_SET(_mission, "obj_counter", 0);
HASH_SET(_mission, "trigger_failed", false);

[LINKFUNC(statemachine_holdPFH), 1, [_position, _radius, _multiplier, _tickets, _mission]] call CBA_fnc_addPerFrameHandler;
