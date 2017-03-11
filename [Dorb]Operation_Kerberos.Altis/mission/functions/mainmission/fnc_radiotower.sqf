/*
 *  Author: iJesuz
 *
 *  Description:
 *      Mission "Radiotower"
 *
 *  Parameter(s):
 *      0 : HASH    - mission hash
 *
 *  Returns:
 *      -
 */
#include "script_component.hpp"

_this params ["_mission"];

private _position = HASH_GET(_mission,"location") select 1;

[_mission, {
    _this params ["_radiotower"];

    _radiotower setVariable [QGVAR(isActive), true, true];
    _radiotower addEventHandler ["HandleDamage", LINKFUNC(obj_onRadiotowerDamaged)];
}] call FUNC(mainmission__oneCounter);
