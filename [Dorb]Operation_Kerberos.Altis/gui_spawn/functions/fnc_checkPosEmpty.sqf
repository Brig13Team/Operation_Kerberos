/*
 *  Author: Dorbedo
 *
 *  Description:
 *      Spawn Position is empty
 *
 *  Parameter(s):
 *      0 : ARRAY - Position
 *
 *  Returns:
 *      BOOL - pad is empty
 *
 */
#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params ["_position"];
_position = ASLtoAGL (+ _position);
((nearestObjects [_position, ["AllVehicles"], CHECK_RADIUS]) select {_x getVariable [QGVARMAIN(canDelete),true]}) isEqualTo [];
