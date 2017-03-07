/*
 *  Author: Dorbedo
 *
 *  Description:
 *      Server PostInit
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

[QGVAR(add),LINKFUNC(add)] call CBA_fnc_addEventHandler;
[QGVAR(remove),LINKFUNC(remove)] call CBA_fnc_addEventHandler;
