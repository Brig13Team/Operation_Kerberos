/*
 *  Author: Dorbedo
 *
 *  Description:
 *      Mission "radiotower" : Conditional Function
 *
 *  Parameter(s):
 *      0 : ARRAY - tower-Objects
 *
 *  Returns:
 *      STRING - taskstate
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [["_towers",[],[[]]]];

private _living_towers = {
    (alive _x)||
    (_x getVariable[QGVAR(isAlive),true])
} count _towers;

If (_living_towers < 1) exitWith { "Succeeded" };
""
