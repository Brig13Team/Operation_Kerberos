/*
 *  Author: iJesuz
 *
 *  Description:
 *      Mission "SCARAB"
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
    _this params ["_scarab"];
    private _gunner = gunner _scarab;

    _gunner addEventHandler ["Killed", LINKFUNC(obj_onScarabGunnerKilled)];
    _scarab addEventHandler ["Killed", LINKFUNC(obj_onScarabDestroyed)];
}, 60] call FUNC(mainmission__oneCounter);
