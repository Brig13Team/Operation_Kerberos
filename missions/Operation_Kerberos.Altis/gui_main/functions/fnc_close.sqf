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

If (!dialog) exitWith {};

[] call FUNC(closeMetro);

closeDialog IDD_GUI_MAIN;
nil;
