/*
 *  Author: Dorbedo
 *
 *  Description:
 *      Mission "Artillery"
 *
 *  Parameter(s):
 *      0 : HASH      - mission hash
 *      1 : [OBJECT]  - mission targets
 *
 *  Returns:
 *      -
 */
#include "script_component.hpp"

_this params ["_mission", "_targets"];

{
    [_x,GVARMAIN(side),false] call EFUNC(spawn,crew);
    _x setFuel 0;
    _x addEventHandler ["Killed", LINKFUNC(obj__increaseCounter)];
    [QEGVAR(headquarter,registerArtillery),_x] call CBA_fnc_localEvent;
} forEach _targets;
