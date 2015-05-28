/*
	Author: Dorbedo

	Description:
	Creates an array with all Groups and filters it

	Returns:
	ARRAY: includes the filtered groups
*/
#include "makros.hpp"
private ["_alleGruppen","_gruppen"];

_alleGruppen = allGroups;
_gruppen = [];

//		Gruppen filtern und auflisten Kriterien: WEST, Einheiten vorhanden, keine "nur-KI" Gruppen

//		KI-Gruppen: (isPlayer(leader _x ))
{
	If (((isPlayer(leader _x ))) and (side(leader _x ) == (side player))and((count (units _x)) >0)) then {
		PUSH(_gruppen,_x);
	};
}forEach _alleGruppen;
_gruppen