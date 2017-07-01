/*
 *  Author: Dorbedo
 *
 *  Description:
 *      stops the drones
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

GVAR(drones_isActive) = false;

GVAR(drones_requestedAirstrikes) = [];
GVAR(drones_requestedReconnaissances) = [];
GVAR(drones_availableReconDrones) = [];
GVAR(drones_availableAttackDrones) = [];
