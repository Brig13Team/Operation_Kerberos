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
SCRIPT(artypos);
private["_rad","_spawnposition","_einheit","_dir","_arty","_return","_pos"];
params["_position",["_rad",200,[0]]];
_spawnposition=[];
_einheit = dorb_veh_arty SELRND;

_spawnposition = [_position,_rad,0] call EFUNC(common,random_pos);
_spawnposition = _spawnposition findEmptyPosition [1,(_rad/2),_einheit];				//// to do: isFlatEmpty
if (count _spawnposition < 1) exitWith {
	ERROR(FORMAT_1("Keine Artillerie Spawnposition | %1",_spawnposition));
};

_dir = floor(random 360);
_return = [_spawnposition,_dir,_einheit,dorb_commandveh_side] call BIS_fnc_spawnVehicle;
_arty = (_return select 0);
_arty setFuel 0;
for "_i" from 0 to 4 do {
	_pos = [_spawnposition,8,(_dir + (360/5.3)*_i)]call BIS_fnc_relPos;
	_pos = ATLToASL _pos;
	SPAWNDIR = (_dir + (360/5.3)*_i);
	_return = [_pos,"Land_HBarrierBig_F",1,[0,0,0],0,{SPAWNDIR}] call BIS_fnc_spawnObjects;
};

for "_i" from 0 to 7 do {
	_pos = [_spawnposition,13,(_dir + (360/9)*_i)]call BIS_fnc_relPos;
	_pos = ATLToASL _pos;
	SPAWNDIR = (_dir + ((360/9)*_i)+180);
	_return = [_pos,"Land_Razorwire_F",1,[0,0,0],0,{SPAWNDIR}] call BIS_fnc_spawnObjects;
};
_arty