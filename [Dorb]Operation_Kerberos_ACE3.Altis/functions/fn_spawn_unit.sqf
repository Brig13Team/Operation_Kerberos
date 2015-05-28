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
#include "makros.hpp"

private ["_position","_gruppe","_typ","_unit"];

_position = _this select 0;
_gruppe = _this select 1;
_typ = _this select 2;
if (count _position < 3) exitWith {d_log_p("Keine Spawnpos uebergeben")};
d_log(FORMAT_3("Spawning Unit | pos=%1 | grupp=%2 | typ=%3 |",_position,_gruppe,_typ))
_unit = _gruppe createUnit [_typ,_position, [], 0, "NONE"];
[_gruppe] FCALL(moveToHC);
_unit

