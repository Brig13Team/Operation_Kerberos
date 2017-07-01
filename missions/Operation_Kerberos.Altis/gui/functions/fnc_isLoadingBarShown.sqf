/*
 *  Author: Dorbedo
 *
 *  Description:
 *      checks if the loadingbar is shown
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      BOOL - true if the loadingbar is shown
 *
 */
//#define DEBUG_MODE_FULL
#define INCLUDE_GUI
#include "script_component.hpp"

private _display = uiNamespace getvariable [QGVAR(loadingbar),displayNull];
(!isNull _display);
