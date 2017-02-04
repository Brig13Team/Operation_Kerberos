/*
 *  Author: Dorbedo
 *
 *  Description:
 *      can disable the device
 *
 *  Parameter(s):
 *      0 : OBJECT - interaction target
 *
 *  Returns:
 *      BOOL - device can be disabled
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [["_target",objNull,[objNull]]];
CHECK(isNull _target)
_target getVariable [QGVAR(isActive),false];
