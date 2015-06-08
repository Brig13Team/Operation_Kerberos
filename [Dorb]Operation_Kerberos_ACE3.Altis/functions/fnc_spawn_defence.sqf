/*
	Author: Dorbedo
	
	Description:
		Spawns defence around position
*/
#include "script_component.hpp"

Private["_pos","_group","_spawnpos","_dir","_einheit","_unit"];
//_pos = _this select 0;
_pos = _this;
_group = createGroup dorb_side;
_spawnpos=[];
_dir=(random 360);

for "_i" from 0 to 3 do {
	_dir = _dir + 90;
	_einheit = dorb_staticlist SELRND;

	_spawnpos=[_pos, 15, _dir] call BIS_fnc_relPos;
	
	_spawnpos = _spawnpos findEmptyPosition [1,5,_einheit];
	if (count _spawnpos<1) exitWith {
		ERROR(FORMAT_1("Defence Pos nicht gefunden / %1",_this));
	};
	_unit = createVehicle [_einheit,_spawnpos, [], 0, "NONE"];
	_unit setDir _dir;
	
	[_unit,_group] call FM(spawn_crew);
	//[_unit,_group] call BIS_fnc_spawnCrew;

};
