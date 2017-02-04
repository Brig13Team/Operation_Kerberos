/*
 *  Author: Dorbedo
 *
 *  Description:
 *      spawn a nuke at given position
 *
 *  Parameter(s):
 *      0 : ARRY - targetPosition
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params["_pos"];
private _yield = getNumber(configFile >> "cfgAmmo" >> "RHS_9M79B" >> "yield");
private _radius = 500;
[
    _pos,
    _yield,
    _radius
] call RHS_fnc_ss21_nuke;
