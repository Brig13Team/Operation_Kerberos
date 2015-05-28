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
#include "makros.hpp"

private["_position","_spawnposition","_einheit"];

_position = [];
_position = _this select 0;

d_log("Commandveh Arty")

_spawnposition=[];

_einheit = "rhs_prp3_tv";

_spawnposition = [_position,200,0] call FM(random_pos);
_spawnposition = _spawnposition findEmptyPosition [1,100,_einheit];				//// to do: isFlatEmpty
if (count _spawnposition < 1) exitWith {d_error(FORMAT_1("Keine Spawnposition Commandveh | ",_spawnposition))};

_dir = floor(random 360);
d_log(FORMAT_3("Spawnpos=%1 / dir=%2 / einheit=%3",_spawnposition, _dir, _einheit))

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
	}else{d_error("Keine Spawnposition | ")};
};


while {alive _veh} do {
	d_log("COMMANDVEH-CHECK | Arty")
	_attack_pos=[];
	_attack_pos=[getPos _veh,0] call FM(spawn_commandveh_check);
	if ((count _attack_pos)>1) then {
		d_log_o("COMMANDVEH | Fire Arty")
		{
			if (alive _x) then {_x commandArtilleryFire [_attack_pos, ((getArtilleryAmmo [_x])select 0),3];};
		} forEach DORB_COMMANDVEH_ARTY;
		sleep (300 + (random 300));
	};
	sleep 300;
};
