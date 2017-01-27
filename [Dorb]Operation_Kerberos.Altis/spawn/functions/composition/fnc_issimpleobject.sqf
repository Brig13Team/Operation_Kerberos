/*
 *  Author: Dorbedo
 *
 *  Description:
 *      check if a object should be marked as a simple object
 *
 *  Parameter(s):
 *      0 : STRING - Objectclass
 *
 *  Returns:
 *      BOOL - can be spawned as simple object
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"
_this params [["_curObj",objNull,[objNull]],["_isStacked",false,[true]]];

If (({_curObj isKindOf _x} count ["CAManBase","Static","LandVehicle","Air","Ship"])>0) exitWith {false;};

/*
 * TODO:    the lower objects should be less likely simpleObjects to prevent AI moving through walls.
 *          the objects on top should be simpleObjects if there is no restriction
 */




true;
