/*
 *  Author: Dorbedo
 *
 *  Description:
 *      onRespawn event
 *
 *  Parameter(s):
 *      0 : [TYPE] - [argument name]
 *
 *  Returns:
 *      [TYPE] - [return name]
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

If(!hasInterface)exitWith{};

_this params ["_unit","_corpse"];
CHECK(!(local _unit))

If !(isNull _unit) then {
    [
        _unit,
        missionNamespace getVariable QGVAR(respawnLoadout),
        missionNamespace getVariable QGVAR(Weapons)
    ] call FUNC(setLoadout);
};
