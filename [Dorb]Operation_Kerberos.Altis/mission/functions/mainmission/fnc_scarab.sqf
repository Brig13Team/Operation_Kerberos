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

    _gunner addEventHandler ["Killed", { [vehicle (_this select 0)] call FUNC(obj__increaseCounter); }];
    _scarab addEventHandler ["Killed", LINKFUNC(obj__triggerFailed)];
    _scarab addEventHandler ["Killed", { [getPos (_this select 0)] call FUNC(obj_spawnNuke); }];
}, 60] call FUNC(mainmission__oneCounter);
