/*
 *  Author: Dorbedo
 *
 *  Description:
 *      checks if a jammer is active
 *
 *  Parameter(s):
 *      0 : OBJECT - the jammer to check
 *
 *  Returns:
 *      BOOL - the state of the jammer
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"
_this params [["_jammer",objNull,[objNull]]];

(_jammer getVariable [QGVAR(isActive),false]);
