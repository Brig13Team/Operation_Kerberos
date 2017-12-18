/**
 * Author: Dorbedo
 * checks if a jammer is active
 *
 * Arguments:
 * 0: <OBJECT> the jammer to check
 *
 * Return Value:
 * <BOOL> is active
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params [["_jammer",objNull,[objNull]]];

((_jammer getVariable [QGVAR(isActive),false]) && {alive _jammer})
