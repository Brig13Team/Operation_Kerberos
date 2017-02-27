/*
 *  Author: iJesuz
 *
 *  Description:
 *      Killed Scarab Gunner
 *
 *  Parameter(s):
 *      0 : HASH    - mission
 *
 *  Returns:
 *      -
 */
#include "script_component.hpp"

if (isServer) then {
    _this params ["_gunner"];
    private _scarab = vehicle _gunner;

    TRACEV_2(_gunner,_scarab);

    private _mission = _scarab getVariable QGVAR(mission);
    HASH_SET(_mission, "obj_counter", HASH_GET(_mission, "obj_counter") + 1);
}
