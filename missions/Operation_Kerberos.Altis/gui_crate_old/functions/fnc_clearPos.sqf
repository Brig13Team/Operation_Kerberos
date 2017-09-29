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
#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [["_spawnpos",[],[[],objNull],[3]],["_check_radius",5,[5]]];
TRACEV_2(_spawnpos,_check_radius);

{if (count crew _x == 0) then {deletevehicle _x};} foreach ((nearestObjects [_spawnpos, ["AllVehicles"], _check_radius]) select {_x getVariable [QGVARMAIN(canDelete),true]});
{deletevehicle _x;} foreach nearestObjects [_spawnpos,["CraterLong_small","CraterLong","WeaponHolder","GroundWeaponHolder"], _check_radius];
{deleteVehicle _x;} forEach ((nearestObjects [_spawnpos,["allDead","Box_NATO_Ammo_F","Box_NATO_WpsLaunch_F","Box_NATO_Wps_F","Box_NATO_WpsSpecial_F","IG_supplyCrate_F",
            "B_CargoNet_01_ammo_F","B_Slingload_01_Cargo_F"], _check_radius]) select {_x getVariable [QGVARMAIN(canDelete),true]});
{deleteVehicle _x;} forEach ((nearestObjects [_spawnpos,["Thing"], _check_radius]) select {_x getVariable [QGVARMAIN(canDelete),true]});
