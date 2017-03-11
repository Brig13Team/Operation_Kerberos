/*
 *  Author: iJesuz
 *
 *  Description:
 *      Mission "EMP"
 *
 *  Parameter(s):
 *      0 : HASH    - mission hash
 *
 *  Returns:
 *      -
 */
#include "script_component.hpp"

_this params ["_mission"];

[_mission, {
    _this params ["_emp"];

    _emp setVariable [QGVAR(isActive), true, true];
    _emp addEventHandler ["Killed", LINKFUNC(obj__triggerFailed)];
    // deactivate event initialized via EH_clientPostInit
}] call FUNC(mainmission__oneCounter);

// init device event
HASH_SET(_mission, "event_callback",  QFUNC(obj_callEvent));
HASH_SET(_mission, "event_name",      QGVAR(emp));
HASH_SET(_mission, "event_parameter", { getPos (_this select 0) });
HASH_SET(_mission, "event_last",      CBA_missionTime);
HASH_SET(_mission, "event_interval",  54000);
HASH_SET(_mission, "event_active",    true);
