/*
 *  Author: Dorbedo
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

_this params [["_vehiclelist",[],["",[]]],["_spawnposition",[],[[]],[2,3]],["_spawnDir",0,[0]]];

If ((_spawnposition isEqualTo [])||(_vehicleList isEqualTo [])) exitWith {""};

If ((count _spawnposition)<3) then {_spawnposition pushBack 0;};

private _id = HASH_GET_DEF(GVAR(spawns),"id",-1) + 1;
TRACEV_4(_vehicleList,_spawnposition,_spawnDir,_id);
private _value = [_vehicleList,_spawnposition,_spawnDir];
HASH_SET(GVAR(spawns),str _id,_value);
HASH_SET(GVAR(spawns),"id",_id);
str _id;
