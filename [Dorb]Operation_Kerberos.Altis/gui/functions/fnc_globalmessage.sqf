/*
 *  Author: Dorbedo
 *
 *  Description:
 *      Displays a message global
 *
 *  Parameter(s):
 *      0 : STRING - Title
 *      1 : STRING - Content
 *      2 : STRING - Color
 *
 *  Returns:
 *      none
 *
 */
#include "script_component.hpp"

[QGVAR(message),_this] call CBA_fnc_globalEvent;
