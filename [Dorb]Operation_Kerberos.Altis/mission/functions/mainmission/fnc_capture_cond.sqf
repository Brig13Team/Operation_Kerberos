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

_this params [["_commanders",-1,[0]]];

if ((GVAR(commander_captured) + GVAR(commander_killed)) < _commanders) exitWith { "" };

if (GVAR(commander_captured) > _hostages*0.66) exitWith { "Succeeded" };
if (GVAR(commander_killed) >= _hostages*0.66) exitWith { "Failed" };

"Canceled"
