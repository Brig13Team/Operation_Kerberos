/*
 *  Author: Dorbedo
 *
 *  Description:
 *      initPost Events
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      none
 *
 */
#include "script_component.hpp"

["rhs_p37", "initpost", LINKFUNC(registerRadar),true,[],true] call CBA_fnc_addClassEventHandler;
["rhs_zsutank_base", "initpost", LINKFUNC(registerAA),true,[],true] call CBA_fnc_addClassEventHandler;
