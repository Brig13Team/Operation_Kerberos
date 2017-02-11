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

[_mission, QGVAR(earthquake), {
    _this params ["_mission"];
    private _obj = HASH_GET(_mission, "object");
    getPos _obj
}] call FUNC(mainmission___device);

// init device event
HASH_SET(_mission, "event_callback",  QFUNC(mainmission___device_event));
HASH_SET(_mission, "event_name",      QGVAR(emp));
HASH_SET(_mission, "event_parameter", { getPos (_this select 0) });
HASH_SET(_mission, "event_last",      CBA_missionTime);
HASH_SET(_mission, "event_interval",  60 * getNumber(missionConfigFile >> "missions_config" >> "main" >> _type >> "intervall"));
