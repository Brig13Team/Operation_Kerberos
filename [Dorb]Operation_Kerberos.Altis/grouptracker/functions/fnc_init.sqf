/*
 *  Author: Dorbedo
 *
 *  Description:
 *      initializes the grouptracker
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      none
 *
 */
#include "script_component.hpp"

If !(canSuspend) exitWith {
    [] spawn FUNC(init);
};

If !(isNil QGVAR(handler)) then {
    GVAR(active) = false;
    [GVAR(handler)] call FUNC(terminate);
    uiSleep (GVAR(intervall) + 3);
};

GVAR(active) = true;
GVAR(handler) = [
    {[] call FUNC(handler);},
    GVAR(Intervall)
] call CBA_fnc_addPerFrameHandler;
