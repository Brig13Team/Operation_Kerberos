/*
 *  Author: Dorbedo
 *
 *  Description:
 *      [Description]
 *
 *  Parameter(s):
 *      0 : [TYPE] - [argument name]
 *
 *  Returns:
 *      [TYPE] - [return name]
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"
_this params [["_jammer",objNull,[objNull]]];

If (isNull _jammer) exitWith {false;};

(_jammer getVariable [QGVAR(isActive),false]);
