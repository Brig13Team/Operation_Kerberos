/*
    Author: Dorbedo

    Description:
        initialization for logistics
*/
#include "script_component.hpp"

If ((!hasInterface)||(!isClass(missionconfigFile >> "logistics"))) exitWith {};

[
    {time > 20},
    LINKFUNC(initialize)
] call CBA_fnc_waitUntilAndExecute;
