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
		d_error(FORMAT_1("Defence Pos nicht gefunden / %1",_this))
	};
	_unit = createVehicle [_einheit,_spawnpos, [], 0, "NONE"];
	_unit setDir _dir;
	[_unit,_group] call BIS_fnc_spawnCrew;
	

	/*
	_einheit = dorb_staticlist select floor random count dorb_staticlist;
	_spawnpos = [_pos,15,1] call dorb_fnc_random_pos;
	_spawnpos = _spawnpos findEmptyPosition [1,5,_einheit];
	if (count _spawnpos<1) exitWith {[format ["Defence Pos not found",_this],1] call dorb_fnc_debug;};
	_unit = createVehicle [_einheit,_spawnpos, [], 0, "NONE"];
	[_unit,_group] call BIS_fnc_spawnCrew;
	*/
};
