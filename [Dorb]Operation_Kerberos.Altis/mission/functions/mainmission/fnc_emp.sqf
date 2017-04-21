/*
 *  Author: iJesuz
 *
 *  Description:
 *      init mission "emp"
 *
 *  Parameter(s):
 *      0 : HASH        - mission hash
 *      1 : [OBJECT]    - mission target
 *
 *  Returns:
 *      -
 */
#include "script_component.hpp"

_this params ["_mission", "_targets"];

{
    _x setVariable [QGVAR(isActive), true, true];
    _x addEventHandler ["Killed", LINKFUNC(obj__triggerFailed)];
} forEach _targets;

[_mission, _targets] call FUNC(mainmission__oneCounter);

// init device event
HASH_SET(_mission, "event_callback",  QFUNC(obj_callEvent));
HASH_SET(_mission, "event_name",      QGVAR(emp));
HASH_SET(_mission, "event_parameter", [getPos (_this select 0) ]);
HASH_SET(_mission, "event_last",      CBA_missionTime);
HASH_SET(_mission, "event_interval",  900);
HASH_SET(_mission, "event_active",    true);
