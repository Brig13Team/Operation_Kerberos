/*
 * Author: iJesuz
 *
 * Description:
 *   init mission "hold"
 *
 * Parameter:
 *   0 : HASH   - mission
 *
 * Return:
 *   -
 */
#include "script_component.hpp"

_this params ["_mission"];

private _position = HASH_GET(_mission, "location") select 1;
private _tickets = getNumber(missionConfig >> "mission" >> "main" >> "hold" >> "object" >> "tickets");
private _multiplier = getNumber(missionConfig >> "mission" >> "main" >> "hold" >> "objects" >> "multiplier");
private _radius = [] call FUNC(spawn_getRadius);

[LINKFUNC(mainmission__holdPFH), 1, [_position, _radius, _multiplier, _tickets, _mission]] call CBA_fnc_addPerFrameHandler;

// export settings
HASH_SET(_mission, "objects", []);
HASH_SET(_mission, "obj_counter_total", _tickets);
HASH_SET(_mission, "obj_counter", 0);
HASH_SET(_mission, "condition", QFUNC(mainmission__oneCounter_condition));
// not needed
HASH_SET(_mission, "trigger_failed", false);
HASH_SET(_mission, "time_to_end", -1);