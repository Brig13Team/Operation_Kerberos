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
{(GVAR(drones_lastAttackRequest) + GVAR(drones_attackIntervall)) > CBA_missiontime}
