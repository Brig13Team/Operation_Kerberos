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
private _tickets = getNumber(missionConfigFile >> "mission" >> "main" >> "hold" >> "object" >> "tickets");
private _multiplier = getNumber(missionConfigFile >> "mission" >> "main" >> "hold" >> "object" >> "multiplier");
private _radius = ["hold"] call FUNC(spawn_getRadius);

[LINKFUNC(mainmission__holdPFH), 1, [_position, _radius, _multiplier, _tickets, _mission]] call CBA_fnc_addPerFrameHandler;

[_mission,[]] call FUNC(mainmission__oneCounter);
HASH_SET(_mission, "obj_counter_total", _tickets);
