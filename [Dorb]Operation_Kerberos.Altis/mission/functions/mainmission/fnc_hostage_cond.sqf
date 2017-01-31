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

_this params [["_hostages",[],[[]]], ["_amount",-1,[0]]];

if (({ alive _x } count _hostages) > 0) exitWith { "" };

if (GVAR(rescued_hostages) > _amount*0.66) exitWith { "Succeeded" };
if (GVAR(killed_hostages) >= _amount*0.66) exitWith { "Failed" };

"Canceled"
