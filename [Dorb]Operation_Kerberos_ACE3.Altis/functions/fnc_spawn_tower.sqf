/*
	Author: Dorbedo
	
	Description:
		Spawns a Mil-Tower with units
	
*/
#include "script_component.hpp"
private["_pos","_i","_spawnposition","_einheit","_dir","_unit","_fertig","_geb_pos","_gebauedepos","_i","_return"];

LOG("Spawn Mil-Tower");
_i=0;
_fertig=false;
_gebauedepos=[];
_geb_pos=[];
_spawnposition=[];
_einheit = "Land_Cargo_Tower_V1_F";

_spawnposition = [(_this select 0),200,0] call FM(random_pos);
_spawnposition = _spawnposition findEmptyPosition [1,60,_einheit];				//// to do: isFlatEmpty

_dir = floor(random 360);
_unit = createVehicle [_einheit,_spawnposition, [], 0, "NONE"];
_unit setVectorUp [0,0,1];

while {!_fertig} do {
	_geb_pos = _unit buildingPos _i;
	if ((str _geb_pos == "[0,0,0]") and !(isNil "_geb_pos")) then {
		_fertig=true;
	}else{
		_gebauedepos pushBack _geb_pos;
	};
	INC(_i);
};
LOG(FORMAT_1("Towerposistionen=%1",_gebauedepos));

[[_gebauedepos],20,30] spawn FM(spawn_in_building);
_spawnposition spawn FM(spawn_defence);

for "_i" from 0 to 12 do {
	_pos = [_spawnposition,20,(_dir + (360/16)*_i)] call BIS_fnc_relPos;
	_pos = ATLToASL _pos;
	SPAWNDIR = (_dir + ((360/16)*_i)+180);
	_return = [_pos,"Land_Razorwire_F",1,[0,0,0],0,{SPAWNDIR}] call BIS_fnc_spawnObjects;
};