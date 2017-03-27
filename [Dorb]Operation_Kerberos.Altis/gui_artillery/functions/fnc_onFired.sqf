/*
 *  Author: [Name of Author(s)]
 *
 *  Description:
 *      [Description]
 *
 *  Parameter(s):
 *      0 : [TYPE] - [argument name]
 *
 *  Returns:
 *      [TYPE] - [return name]
 *
 */
#define DEBUG_MODE_FULL
#include "script_component.hpp"


_this params ["_vehicle","_weapon","_muzzle","_mode","_ammo","_magazine","_projectile","_gunner"];


private _muzzleSpeed = _vehicle getVariable [QGVAR(muzzleSpeed),vectorMagnitude (velocity _projectile)];

TRACEV_1(_muzzleSpeed);

private _projectileVec = velocity _projectile;
private _projectileVelo = (vectorNormalized _projectileVec) vectorMultiply (_muzzleSpeed);

_projectile setVelocity _projectileVelo;

_vehicle setVariable [QGVAR(lastShot),CBA_missiontime];
