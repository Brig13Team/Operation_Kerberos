/*
	Author: Dorbedo
	
	Description:
		Spawns Units at arraypositions
	
	
	Parameter(s):
		0 : ARRAY	- Spawnpositions
		(Optional)
		1 : ARRAY	- Example
		2 : STRIN	- Example
	
	Return
	ARRAY - spawned Units
*/
#include "script_component.hpp"

PARAMS_1(_spawnposarray);
DEFAULT_PARAM(1,_side,dorb_side);
DEFAULT_PARAM(2,_unitarray,dorb_menlist);
CHECK(!IS_ARRAY(_spawnposarray))
Private["_spawnedunit","_spawnedunits","_typ","_gruppe","_dir","_position"];

For "_i" from 0 to ((count _spawnposarray)-1) do {
	_typ = _unitarray SELRND;
	_gruppe = createGroup _side;
	_dir = (_spawnposarray select _i)select 3;
	_position = [(_spawnposarray select _i)select 0,(_spawnposarray select _i)select 1,(_spawnposarray select _i)select 2];
	_spawnedunit = _gruppe createUnit [_typ,_position, [], _dir, "NONE"];
	_spawnedunits pushBack _spawnedunit;
};
_spawnedunits
