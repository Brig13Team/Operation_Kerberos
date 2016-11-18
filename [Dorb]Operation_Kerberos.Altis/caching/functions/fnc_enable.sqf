/*
    Author: Dorbedo

    Description:
        moves groups to HC

    Parameter(s):
        
        0 : Group

*/
#include "script_component.hpp"

GVAR(enabled) = true;
GVAR(cachedGroups) = [];
[FUNC(handler),1] call CBA_fnc_addPerFrameHandler;
