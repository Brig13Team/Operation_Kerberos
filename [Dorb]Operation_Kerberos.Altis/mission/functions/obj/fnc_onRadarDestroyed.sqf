/*
 *  Author: iJesuz
 *
 *  Description:
 *      on radar destroyed
 *
 *  Parameter(s):
 *      0 : OBJECT  - radar
 *
 *  Returns:
 *      -
 */
#include "script_component.hpp"

if (isServer) then {
    _this params ["_gunner"];
    private _scarab = vehicle _gunner;

    private _mission = _scarab getVariable QGVAR(mission);
    HASH_SET(_mission, "obj_counter", HASH_GET(_mission, "obj_counter") + 1);
}

// TODO: client fnc
