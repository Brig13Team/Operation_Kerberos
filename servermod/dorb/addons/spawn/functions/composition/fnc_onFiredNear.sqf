/*
 *  Author: Dorbedo
 *
 *  Description:
 *      onFired near Event - used to reset the AI behavior
 *
 *  Parameter(s):
 *      0 : OBJECT - Unit
 *      1 : OBJECT - vehicle wich fired
 *      2 : SCALAR - distance (max 69)
 *      3 : STRING - Weapon
 *      4 : STRING - Muzzle
 *      5 : STRING - Mode
 *      6 : STRING - AMMO
 *      7 : OBJECT - Gunner
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"


_this params ["_unit","_vehicle"];

If ((_vehicle isKindOf "StaticWeapon")||{"Artillery" in getArray(configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "availableForSupportTypes")})exitWith {};
_unit removeEventHandler ["FiredNear",_thisEventHandler];
_unit enableAI "PATH";
