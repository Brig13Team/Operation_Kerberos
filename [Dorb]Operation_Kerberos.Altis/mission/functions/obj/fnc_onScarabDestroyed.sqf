/*
 *  Author: iJesuz
 *
 *  Description:
 *      Destroyed Scarab event
 *
 *  Parameter(s):
 *      0 : OBJECT  - mission object
 *
 *  Returns:
 *      -
 */
#include "script_component.hpp"

if (isServer) then {
    _this params ["_scarab"];

    private _mission = _scarab getVariable QGVAR(mission);
    HASH_SET(_mission, "trigger_failed", true);

    [getPos _scarab] call FUNC(obj_spawnNuke);
}

// TODO: client fnc
