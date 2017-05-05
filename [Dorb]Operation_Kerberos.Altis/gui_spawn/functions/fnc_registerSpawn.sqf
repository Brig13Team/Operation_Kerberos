/*
 *  Author: Dorbedo
 *
 *  Description:
 *      registers a new spawn
 *
 *  Parameter(s):
 *      0 : ARRAY/STRING - Array with vehicles or a string (presetname)
 *
 *  Returns:
 *      STRING - the spawn-ID
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params [["_vehiclelist",[],["",[]]],["_spawnposition",[],[[]],[2,3]],["_spawnDir",0,[0]]];

If ((_spawnposition isEqualTo [])||(_vehicleList isEqualTo [])) exitWith {""};

If ((count _spawnposition)<3) then {_spawnposition pushBack 0;};

// carrier detection
private _nearCarriers = _spawnposition nearObjects ["Land_Carrier_01_base_F",400];
If !(_nearCarriers isEqualTo []) then {
    private _offset = ((getPosASL (_nearCarriers select 0)) select 2) + 23.7;
    _spawnposition set[2,_offset];
}else{
    If (surfaceIsWater _spawnposition) then {
        _spawnposition set [2,0];
    }else{
        _spawnposition = AGLtoASL _spawnposition;
    };
};

private _id = HASH_GET_DEF(GVAR(spawns),"id",-1) + 1;
TRACEV_4(_vehicleList,_spawnposition,_spawnDir,_id);
private _value = [_vehicleList,_spawnposition,_spawnDir];
HASH_SET(GVAR(spawns),str _id,_value);
HASH_SET(GVAR(spawns),"id",_id);
str _id;
