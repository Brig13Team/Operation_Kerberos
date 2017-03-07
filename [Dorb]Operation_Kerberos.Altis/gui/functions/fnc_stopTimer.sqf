/*
 *  Author: Dorbedo
 *
 *  Description:
 *      stops the timer
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#define INCLUDE_GUI
#include "script_component.hpp"

GVAR(timer_code) = {};
GVAR(timer_parameter) = [];
GVAR(timer_finish) = -1;

If !(isNil QGVAR(timer_handle)) then {
    [GVAR(timer_handle)] call CBA_fnc_removePerFrameHandler;
    GVAR(timer_handle) = nil;
};
CHECK(!hasInterface)
QAPP(timer) cutRsc ["","PLAIN"];
