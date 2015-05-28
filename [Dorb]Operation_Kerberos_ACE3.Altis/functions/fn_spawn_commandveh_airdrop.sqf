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

private["_position","_spawnposition","_einheit","_veh","_dir","_attack_pos"];

_position = [];
_position = _this select 0;

d_log("Commandveh Airdrop")

_spawnposition=[];

_einheit = "rhs_gaz66_r142_vdv";

_spawnposition = [_position,200,0] call dorb_fnc_random_pos;
_spawnposition = _spawnposition findEmptyPosition [1,100,_einheit];				//// to do: isFlatEmpty
if (count _spawnposition < 1) exitWith {d_error(FORMAT_1("Keine Spawnposition Commandveh | ",_spawnposition))};

_dir = floor(random 360);
d_log(FORMAT_3("Spawnpos=%1 / dir=%2 / einheit=%3",_spawnposition, _dir, _einheit))

_return = [_spawnposition,_dir,_einheit,EAST] call BIS_fnc_spawnVehicle;
_veh = (_return select 0);
_veh setFuel 0;
_veh lock 3;

//"CamoNet_OPFOR_big_F" createVehicle (getPos _veh);

[_veh,1,true] spawn RHS_fnc_gaz66_radioDeploy;

while {alive _veh} do {
	d_log("COMMANDVEH-CHECK | Airdrop")
	_attack_pos=[];
	_attack_pos=[getPos _veh,0] FCALL(spawn_commandveh_check);
	if ((count _attack_pos)>1) then {
		d_log_o("COMMANDVEH | Call Airdrop")
		[_attack_pos,0,40] FCALL(spawn_attack_airdrop);
		sleep (200 + (random 300));
	};
	sleep 240;
};
