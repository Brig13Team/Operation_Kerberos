/**
 * Author: Dorbedo
 * checks if the spawn is clear
 *
 * Arguments:
 * 0: <ARRAY> the spawnposition
 *
 * Return Value:
 * <BOOL> the spawn is empty
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params [["_position",GVAR(curPos),[[]],[3]]];
_position = ASLToAGL _position;
((nearestObjects [_position, ["AllVehicles","Land_DataTerminal_01_F"], CHECK_RADIUS_MIN]) select {_x getVariable [QGVARMAIN(canDelete),true]}) isEqualTo []
