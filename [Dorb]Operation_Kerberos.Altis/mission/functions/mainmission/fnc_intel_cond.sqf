/*
    Author: iJesuz

    Description:
        Mission "Intel" : Conditional Function

    Parameter(s):
        0 : NUMBER  - number of intel to be found

    Return:
        STRING  - taskstate
*/
#include "script_component.hpp"

_this params [["_intelToFind",0,[0]]];

if (GVAR(found_intel) >= _intelToFind) exitWith { "Succeeded" };

""
