#include "script_component.hpp"

/*
  Name: dorb_composition_fnc_onFiredNear
  Author: Dorbedo
  FiredNear Event - used to reset the AI behavior

  Arguments:
    0: unit <OBJECT>
    1: vehicle which fired <OBJECT>
    2: distance (max 69) <SCALAR>
    3: weapon <STRING>
    4: muzzle <STRING>
    5: firemode <STRING>
    6: ammo <STRING>
    7: gunner <OBJECT>

  Return Value:
    None

  Public: Yes
*/

params ["_unit", "_vehicle"];

If ((_vehicle isKindOf "StaticWeapon")||{"Artillery" in getArray(configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "availableForSupportTypes")})exitWith {};
_unit removeEventHandler ["FiredNear", _thisEventHandler];
[QGVAR(enableAI), [_unit, "PATH"], _unit] call CBA_fnc_targetEvent;

