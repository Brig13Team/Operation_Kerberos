/*
 *  Author: iJesuz
 *
 *  Description:
 *      init mission "weaponcache"
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
    _x setDamage 0;

    _x addEventHandler ["Killed", LINKFUNC(obj__increaseCounter)];
    _x setVariable ["ace_cookOff_enable", false, true];
} forEach _targets;
