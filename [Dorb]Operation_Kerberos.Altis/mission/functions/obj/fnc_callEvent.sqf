/*
 *  Author: iJesuz
 *
 *  Description:
 *      event caller for device
 *
 *  Parameter(s):
 *      0 : HASH    - mission hash
 *
 *  Returns:
 *      STRING
 */
#include "script_component.hpp"

_this params ["_mission"];

private _last     = HASH_GET(_mission, "event_last");
private _interval = HASH_GET(_mission, "event_interval");
private _active   = HASH_GET(_mission, "event_active");

if (_active && {(_last + _interval) < CBA_missionTime}) then {
    HASH_SET(_mission, "event_last", CBA_missionTime);

    private _name = HASH_GET(_mission, "name");
    private _event_name = HASH_GET(_mission, "event_name");
    TRACEV_2(_name,_event_name);
    private _event_parameter = HASH_GET(_mission, "event_parameter");
    [_event_name, [HASH_GET(_mission, "object")] call _event_parameter] call CBA_fnc_serverEvent;
};
