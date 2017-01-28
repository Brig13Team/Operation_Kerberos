/*
    Author: iJesuz

    Description:
        Mission "capture" : Conditional Function

    Parameter(s):
        0 : NUMBER  - number of commanders

    Return:
        STRING  - taskstate
*/
#include "script_component.hpp"

_this params [["_commanders",[],[[]],["_amount",-1,[0]]]];


if (((GVAR(commander_captured) + GVAR(commander_killed)) < _amount)&&{({alive _x} count _commanders)>0}) exitWith { "" };

if (GVAR(commander_captured) > _amount*0.66) exitWith { "Succeeded" };
if (GVAR(commander_killed) >= _amount*0.66) exitWith { "Failed" };

"Canceled"
