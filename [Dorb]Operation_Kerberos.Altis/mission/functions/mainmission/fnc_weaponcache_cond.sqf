/*
    Author: iJesuz

    Description:
        Mission "Weaponcache" : Conditional Function

    Parameter(s):
        0 : NUMBER  - number of intel to be found

    Return:
        STRING  - taskstate
*/
#include "script_component.hpp"

_this params [["_cachesToDestroy",0,[0]]];

if (GVAR(destroyed_caches) >= _cachesToDestroy) exitWith { "Succeeded" };

""
