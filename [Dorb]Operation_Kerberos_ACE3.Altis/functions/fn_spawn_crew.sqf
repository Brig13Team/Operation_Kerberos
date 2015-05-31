/*
	Author: Dorbedo

	Description:
	Creates Crew for Vehicle

	Parameter(s):
		0 :	OBJECT - Fahrzeug
		1 :	GROUP - Gruppe

*/
#include "script_component.hpp"
CHECK(!isServer)






/*
_platzanzahl = (_return select 0) emptyPositions "cargo";
for "_i" from 0 to (_platzanzahl - 4) do {
	_einheit = dorb_menlist SELRND;
	_jaeger = [_spawnpos,_gruppe,_einheit] FCALL(spawn_unit);
	_jaeger assignAsCargo (_return select 0);
	_jaeger moveInCargo (_return select 0);
};
*/