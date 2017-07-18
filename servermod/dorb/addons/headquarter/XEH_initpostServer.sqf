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

["rhs_zsutank_base", "initpost", LINKFUNC(registerAA),true,[],true] call CBA_fnc_addClassEventHandler;
["B_APC_Tracked_01_AA_F", "initpost", LINKFUNC(registerAA),true,[],true] call CBA_fnc_addClassEventHandler;
