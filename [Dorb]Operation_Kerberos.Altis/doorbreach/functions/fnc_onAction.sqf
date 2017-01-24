/*
 *  Author: Dorbedo
 *
 *  Description:
 *      onActionCalled
 *
 *  Parameter(s):
 *      0 : OBJECT - house
 *      1 : OBJECT - caller
 *      2 : STRING - Animation
 *
 *  Returns:
 *     none
 *
 */
#define DEBUG_MODE_FULL
#include "script_component.hpp"
_this params ["_house","_caller","_door"];
TRACEV_1(_this);
_house setVariable [format[QGVAR(%1),_door],true,true];
//CHECK(!("DemoCharge_Remote_Ammo" in (magazines _caller)))
_caller removeMagazineGlobal "DemoCharge_Remote_Ammo";
[
    5,
    _this,
    {_args call FUNC(onActionSuccess);},
    {_args call FUNC(onActionFailure);},
    localize LSTRING(PLACING_CHARGE)
] call ACE_common_fnc_progressBar;
