/*
 *  Author: Dorbedo
 *
 *  Description:
 *      spawn the enemy chopper
 *
 *  Parameter(s):
 *      0 : ARRAY - the mission position
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params ["_centerpos"];

private _spawnpos = [_centerpos,800,0] call EFUNC(common,pos_random);
private _curType = selectRandom (["chopper"] call FUNC(spawn_getObjects));

private _safespawnpos = _spawnpos findEmptyPosition [0,100,_curType];

if !(_safespawnpos isEqualTo []) then {
    _spawnpos = _safespawnpos;
};

([_spawnpos,GVARMAIN(side),_curType,random(360),true,true] call EFUNC(spawn,vehicle)) params ["_curgroup","_vehicle"];
_vehicle setFuel 0;
{
    _x allowFleeing 0;
} forEach (crew _vehicle);

[_vehicle]
