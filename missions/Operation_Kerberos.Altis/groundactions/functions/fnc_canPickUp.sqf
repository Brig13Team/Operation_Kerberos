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

private _test = _target isKindOf "Weaponholder";

TRACEV_4(_target,GVAR(active),typeOf _target,_test);

If ((isNull _target) || {!GVAR(active)}) exitWith {false};

_target isKindOf "WeaponHolder"
