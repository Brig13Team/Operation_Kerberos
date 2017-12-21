/*
 *  Author: Dorbedo
 *
 *  Description:
 *      Returns the lenght of a barrel
 *
 *  Parameter(s):
 *      0 : STRING - the vehicle
 *      1 : ARRAY - Turretpath
 *
 *  Returns:
 *      SCALAR - Lenght of the barrel
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params params [["_vehicle", "", [objNull,""]], ["_turret", [-1], [[]]]];

CHECK(_vehicle isEqualTo "")

private _turretConfig = [_vehicle, _turret] call CBA_fnc_getTurret;

private _gunBeg = _vehicle selectionPosition getText (_turretConfig >> "gunBeg");
private _gunEnd = _vehicle selectionPosition getText (_turretConfig >> "gunEnd");

_gunEnd distance _gunEnd;
