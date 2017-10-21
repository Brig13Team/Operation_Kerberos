/**
 * Author: Dorbedo
 * Closes the dialog
 *
 * Arguments:
 * Nothing
 *
 * Return Value:
 * Nothing
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params [["_display", displayNull]];

if (isNull _display) exitWith {};

If (IS_CONTROL(_display)) then {
    _display = ctrlParent _display;
};

TRACEV_2(_this,_display);

_display closeDisplay 0;
nil;
