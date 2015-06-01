/*
	Author: Dorbedo
	
	Description:
		Creates a Motarpos
*/
#include "script_component.hpp"

private["_pos","_position","_spawnposition","_einheit","_dir","_return"];
PARAMS_1(_position);

_spawnposition=[];
_einheit = dorb_veh_mortar SELRND;

_spawnposition = [_position,200,0] call FM(random_pos);
_spawnposition = _spawnposition findEmptyPosition [1,15,_einheit];				//// to do: isFlatEmpty

_dir = floor(random 360);

_return = [_spawnposition,_dir,_einheit,EAST] call BIS_fnc_spawnVehicle;

for "_i" from 0 to 3 do {
	_pos = [_spawnposition,3,(_dir + 90*_i)]call BIS_fnc_relPos;
	_pos = ATLToASL _pos;
	SPAWNDIR = (_dir + (90*_i)+180);
	_return = [_pos,"Land_BagFence_Round_F",1,[0,0,0],0,{SPAWNDIR}] call BIS_fnc_spawnObjects;
	
};