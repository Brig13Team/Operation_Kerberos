/*
    Author: Dorbedo

*/
#include "script_component.hpp"

[
    QGVAR(changeOwner),
    {_this call FUNC(changeOwner);}
] call CBA_fnc_addEventHandler;