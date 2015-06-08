/*
	Author: Dorbedo
	
	Description:
	
	Requirements:
	
	Parameter(s):
		0 : ARRAY	- Example
		1 : ARRAY	- Example
		2 : STRIN	- Example
	
	Return
	BOOL
*/
#include "script_component.hpp"
LOG("Commandveh Artillery");
PARAMS_1(_position);
private["_dir","_spawnposition","_einheit","_return","_veh","_rand_pos","_attack_pos"];
_spawnposition=[];
_einheit = "rhs_prp3_tv";
_spawnposition = [_position,200,0] call FM(random_pos);
_spawnposition = _spawnposition findEmptyPosition [1,100,_einheit];				//// to do: isFlatEmpty
if (count _spawnposition < 1) exitWith {ERROR("Keine Spawnposition | Commandveh Artillery");};

_dir = floor(random 360);
_return = [_spawnposition,_dir,_einheit,EAST] call BIS_fnc_spawnVehicle;
_veh = (_return select 0);
[_veh, _position, 400] call CBA_fnc_taskPatrol;
_veh lock 3;

DORB_COMMANDVEH_ARTY=[];

for "_i" from 0 to 2 do {
	_rand_pos=[];
	_rand_pos = [_position,1800,1] call FM(random_pos);
	if ((count _rand_pos)>1) then {
		_unit = [_rand_pos,100] call FM(spawn_artypos);
		if (alive _unit) then {DORB_COMMANDVEH_ARTY pushBack _unit};
	}else{ERROR("Keine Spawnposition");};
};


while {alive _veh} do {
	LOG("COMMANDVEH-CHECK | Arty");
	_attack_pos=[];
	_attack_pos=[getPos _veh,0] call FM(spawn_commandveh_check);
	if ((count _attack_pos)>1) then {
		LOG("COMMANDVEH | Fire Arty");
		{
			if (alive _x) then {_x commandArtilleryFire [_attack_pos, ((getArtilleryAmmo [_x])select 0),3];};
		} forEach DORB_COMMANDVEH_ARTY;
		sleep (300 + (random 300));
	};
	sleep 300;
};
