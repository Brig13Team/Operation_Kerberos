/**
 * Author: Dorbedo
 * returns the current arsenal list
 *
 * Arguments:
 * None
 *
 * Return Value:
 * <ARRAY> list with items
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

if !(GVAR(isPreloaded)) then {
    [] call FUNC(preload);
};

If (GVAR(level)<1) exitWith {
    uiNamespace getVariable ["ace_arsenal_configItems", []];
};

(profileNamespace getVariable [format[QGVAR(arsenalList_%1), str (side ace_player)], ["", []]]) param [1, [], [[]]];
