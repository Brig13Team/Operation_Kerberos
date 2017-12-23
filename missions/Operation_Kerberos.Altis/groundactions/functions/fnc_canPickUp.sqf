/*
 *  Author: Dorbedo
 *
 *  Description:
 *      checks if a doorcharge can be placed
 *
 *  Parameter(s):
 *      0 : OBJECT - House
 *      1 : SCALAR - Doornumber
 *
 *  Returns:
 *      BOOL - the charge can be placed
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"
params [["_target", objNull, [objNull]]];

If ((isNull _target) || {!GVAR(active)}) exitWith {false};

_target isKindOf "GroundWeaponHolder"
