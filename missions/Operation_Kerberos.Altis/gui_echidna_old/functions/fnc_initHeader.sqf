/*
 *  Author: Dorbedo
 *
 *  Description:
 *      initializes the header
 *
 *  Parameter(s):
 *      0 : DISPLAY - display
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params ["_dialog"];

if (!canSuspend) then {_this spawn FUNC(initHeader);};

[_dialog] spawn FUNC(clock);
