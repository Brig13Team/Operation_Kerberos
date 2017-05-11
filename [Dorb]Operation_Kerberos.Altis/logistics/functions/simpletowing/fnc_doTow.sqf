/*
 *  Author: Dorbedo
 *
 *  Description:
 *      the vehicle is towed
 *
 *  Parameter(s):
 *      0 : OBJECT - the vehicle to tow
 *
 *  Returns:
 *      BOOL - it can be untowed
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [["_target",objNull,[objNull]]];


private _partner = _target getVariable [QGVAR(towingPartner),objNull];

detach _partner;
detach _target;

_target setVariable [QGVAR(towingPartner),objNull,true];
_target setVariable [QGVAR(towingPartner),objNull,true];
