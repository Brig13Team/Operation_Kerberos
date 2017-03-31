/*
 *  Author: Dorbedo
 *
 *  Description:
 *      unUnloadEvent
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
    deleteMarkerLocal _x;
} forEach GVAR(tempMarker);
GVAR(tempMarker) = [];
