/*
    Author: iJesuz

    Description:
        Mission "Hostage" : Conditional Function

    Parameter(s):
        0 : NUMBER  - number of intel to be found

    Return:
        STRING  - taskstate
*/
#include "script_component.hpp"

_this params [["_hostages",-1,[0]]];

if ((GVAR(killed_hostages) + GVAR(rescued_hostages)) < _hostages) exitWith { "" };

if (GVAR(rescued_hostages) > _hostages*0.66) exitWith { "Succeeded" };
if (GVAR(killed_hostages) >= _hostages*0.66) exitWith { "Failed" };

"Canceled"
