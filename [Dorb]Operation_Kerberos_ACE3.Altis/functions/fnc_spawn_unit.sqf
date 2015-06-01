/*
	Author: Dorbedo

	Description:
	Spawns Units

	Parameter(s):
		0 : ARRAY 	- Position (3D)
		1 : STRING 	- Groupname
		2 :	OBJECT 	- Unittyp

	Returns:
	Object
*/
#include "script_component.hpp"
PARAMS_3(_position,_gruppe,_typ);
private ["_unit"];
if (count _position < 3) exitWith {LOG("Keine Spawnpos uebergeben")};
LOG_3(_position,_gruppe,_typ);
_unit = _gruppe createUnit [_typ,_position, [], 0, "NONE"];
//[_gruppe] call FM(moveToHC);
_unit

