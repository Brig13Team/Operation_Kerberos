/*
 *  Author: iJesuz
 *
 *  Description:
 *      init mission "SCARAB"
 *
 *  Parameter(s):
 *      0 : HASH        - mission hash
 *      1 : [OBJECT]    - mission target
 *
 *  Returns:
 *      -
 */
#include "script_component.hpp"

_this params ["_mission", "_targets"];

{
    [_curTarget, createGroup GVARMAIN(side), false] call EFUNC(spawn,crew);

    (gunner _x) addEventHandler ["Killed", { [vehicle (_this select 0)] call FUNC(obj__increaseCounter); }];
    _x addEventHandler ["Killed", LINKFUNC(obj__triggerFailed)];
    _x addEventHandler ["Killed", { [getPos (_this select 0)] call FUNC(obj_spawnNuke); }];
} forEach _targets;

//[_mission, _targets, 60] call FUNC(mainmission__oneCounter);
