/*
 *  Author: Dorbedo
 *
 *  Description:
 *      returns if the player can disconnect an external Antenna (own or other antenna)
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

_this params [["_target",objNull,[objNull]]];

If (isNull(_target getVariable [QGVAR(externalAntenna),objNull])) exitWith {false;};

true;
