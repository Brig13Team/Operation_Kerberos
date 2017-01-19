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
_this params [["_curObj",objNull,[objNull]]];
(({_curObj isKindOf _x} count ["CAManBase","Static","LandVehicle","Air","Ship"])<1);
