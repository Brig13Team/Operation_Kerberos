/*
 *  Author: Dorbedo
 *
 *  Description:
 *      handleFired Event
 *
 *  Parameter(s):
 *      0 : [TYPE] - [argument name]
 *
 *  Returns:
 *      [TYPE] - [return name]
 *
 */
#include "script_component.hpp"

_this params ["_vehicle","_weapon","_muzzle","_mode","_ammo","_magazine","_projectile","_gunner"];


private _muzzleSpeedVector = _vehicle getVariable ["muzzleSpeedVector",vectorMagnitude (velocity _projectile)];

_projectile setVelocity _muzzleSpeedVector;

private _reloadTime = 12;
[{(_this select 0) setVariable [QGVAR(ready),true]},[_vehicle],_reloadTime] call CBA_fnc_waitAndExecute;
