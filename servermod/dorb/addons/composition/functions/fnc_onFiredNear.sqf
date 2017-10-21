/**
 * Author: Dorbedo
 * FiredNear Event - used to reset the AI behavior
 *
 * Arguments:
 * 0: <OBJECT> Unit
 * 1: <OBJECT> vehicle wich fired
 * 2: <SCALAR> distance (max 69)
 * 3: <STRING> Weapon
 * 4: <STRING> Muzzle
 * 5: <STRING> Mode
 * 6: <STRING> AMMO
 * 7: <OBJECT> Gunner
 *
 * Return Value:
 * Nothing
 *
 */

#include "script_component.hpp"

params ["_unit","_vehicle"];

If ((_vehicle isKindOf "StaticWeapon")||{"Artillery" in getArray(configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "availableForSupportTypes")})exitWith {};
_unit removeEventHandler ["FiredNear",_thisEventHandler];
[QGVAR(enableAI),[_unit,"PATH"],_unit] call CBA_fnc_targetEvent;

