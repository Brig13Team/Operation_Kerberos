/**
 * Author: Dorbedo
 * returns the current amount of an item
 *
 * Arguments:
 * 0: <STRING> the itemstring
 *
 * Return Value:
 * <SCALAR> the amount
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["_configstring"];

GVAR(curInventory) getVariable [_configstring,0];
