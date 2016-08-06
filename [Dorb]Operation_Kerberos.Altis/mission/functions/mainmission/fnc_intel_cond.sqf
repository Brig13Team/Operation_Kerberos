/*
    Author: iJesuz

    Description:
        Mission "Intel" : Conditional Function

    Parameter(s):
        -

    Return:
        -
*/
#include "script_component.hpp"

_this params [["_intelToFind",0,[0]]];

if (GVAR(found_intel) >= _intelToFind) exitWith { "Succeeded" };

""
