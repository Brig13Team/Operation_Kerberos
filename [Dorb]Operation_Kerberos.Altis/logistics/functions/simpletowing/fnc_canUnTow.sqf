/*
 *  Author: Dorbedo
 *
 *  Description:
 *      the vehicle can be untowed
 *
 *  Parameter(s):
 *      0 : OBJECT - the vehicle to be untowed
 *
 *  Returns:
 *      BOOL - it can be untowed
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [["_target",objNull,[objNull]]];

!isNull(_target getVariable [QGVAR(towingPartner),objNull])
