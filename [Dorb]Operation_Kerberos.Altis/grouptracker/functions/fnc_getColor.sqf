/*
 *  Author: DOrbedo
 *
 *  Description:
 *      Returns the Color of a Group
 *
 *  Parameter(s):
 *      0 : GROUP - the group
 *
 *  Returns:
 *      STRING - the Color
 *
 */
#include "script_component.hpp"

_this params ["_group"];

If (side _group == west) exitWith {"ColorBLUFOR"};
If (side _group == east) exitWith {"ColorOPFOR"};
If (side _group == resistance) exitWith {"ColorIndependent"};
If (side _group == civilian) exitWith {"ColorCivilian"};
"ColorBlack";
