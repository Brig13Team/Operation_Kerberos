/**
 * Author: Dorbedo
 * clear the inventory-list
 *
 * Arguments:
 * 0: <CONTROL> the button
 *
 * Return Value:
 * Nothing
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["_button"];

private _display = ctrlParent _button;

HASH_DELETE(GVAR(inventory));
GVAR(inventory) = HASH_CREATE;

[_display displayCtrl ]
