/*
 *  Author: Dorbedo
 *
 *  Description:
 *      Mission "dronecommand" : Conditional Function
 *
 *  Parameter(s):
 *      0 : ARRAY - dronecommand-Objects
 *
 *  Returns:
 *      STRING - taskstate
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [["_dronecommandos",[],[[]]]];

private _living_dronecommandos = {
    (alive _x)&&
    (!(_x getVariable [QGVAR(active),false]))
} count _dronecommandos;

If (_living_dronecommandos < 1) exitWith { "Succeeded" };
""
