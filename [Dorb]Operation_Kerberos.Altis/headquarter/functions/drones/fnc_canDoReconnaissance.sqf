/*
 *  Author: Dorbedo
 *
 *  Description:
 *      an airstrike can be called
 *
 *  Parameter(s):
 *      none
 *
 *  Returns:
 *      BOOL - an airstrike can be requested
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

(GVAR(drones_isActive))&&
{(GVAR(drones_lastReconRequest) + GVAR(drones_reconIntervall)) > CBA_missiontime}
