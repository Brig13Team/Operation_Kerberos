/**
 * Author: Dorbedo
 * returns if the menu can be opened
 *
 * Arguments:
 * Nothing
 *
 * Return Value:
 * <BOOL> the menu can be opened
 *
 */

#include "script_component.hpp"

params [
    ["_target",objNull,[objNull]],
    ["_caller",objNull,[objNull]]
];


_caller getVariable [QGVAR(canUse), true];
