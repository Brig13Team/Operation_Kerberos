/*
 *  Author: Dorbedo
 *
 *  Description:
 *      clear the spawnpos
 *
 *  Parameter(s):
 *      0 : ARRAY - Spawnposition
 *      1 : SCALAR - Radius
 *
 *  Returns:
 *      none
 *
 */
#include "script_component.hpp"

_this params [["_spawnpos",[],[[]],[3]],["_check_radius",5,[5]]];


{if (count crew _x == 0) then {deletevehicle _x};} foreach ((nearestObjects [_spawnpos, ["AllVehicles"], _check_radius]) select {_x getVariable [QGVARMAIN(canDelete),true]});
{deletevehicle _x;} foreach nearestObjects [_spawnpos,["CraterLong_small","CraterLong","WeaponHolder","GroundWeaponHolder"], _check_radius];
{deleteVehicle _x;} forEach ((nearestObjects [_spawnpos,["allDead"], _check_radius]) select {_x getVariable [QGVARMAIN(canDelete),true]});
{deleteVehicle _x;} forEach ((nearestObjects [_spawnpos,["Thing"], _check_radius]) select {_x getVariable [QGVARMAIN(canDelete),true]});
