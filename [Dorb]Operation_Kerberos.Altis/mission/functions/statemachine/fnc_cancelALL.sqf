/*
 *  Author: Dorbedo
 *
 *  Description:
 *      cancels all Missions
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

{
    _x setVariable ['progress','cancel'];
} forEach GVAR(missions);
