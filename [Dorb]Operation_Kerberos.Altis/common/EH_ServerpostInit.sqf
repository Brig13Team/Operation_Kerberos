/*
    Author: Dorbedo

*/
#include "script_component.hpp"
CHECK(!isServer)
[
    QGVAR(changeOwner),
    {_this call FUNC(changeOwner);}
] call CBA_fnc_addEventHandler;
