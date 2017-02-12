/*
 *  Author: DOrbedo
 *
 *  Description:
 *      starts general display functions
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      none
 *
 */
#define INCLUDE_GUI
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

disableSerialization;
_this params ["_dialog"];
TRACEV_1(_this);

[_dialog] call EFUNC(gui_echidna,setBackground);

[_dialog] call EFUNC(gui_echidna,initHeader);
[] call FUNC(showMetro);
