/*
 *  Author: iJesuz
 *
 *  Description:
 *      Mission "Device"
 *
 *  Parameter(s):
 *      0 : HASH    - mission hash
 *
 *  Returns:
 *      -
 */
#include "script_component.hpp"

_this params ["_mission"];

[_mission] call FUNC(mainmission___device);

// init device event
HASH_SET(_mission, "event_callback",  FUNC(mainmission___device_event));
HASH_SET(_mission, "event_name",      QGVAR(earthquake));
HASH_SET(_mission, "event_parameter", { floor( random 4) + 1 });
HASH_SET(_mission, "event_last",      CBA_missionTime);
HASH_SET(_mission, "event_interval",  60 * getNumber(missionConfigFile >> "missions_config" >> "main" >> _type >> "intervall"));
