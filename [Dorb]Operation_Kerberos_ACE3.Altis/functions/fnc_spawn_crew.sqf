/*
	Author: Dorbedo

	Description:
	Creates Crew for Vehicle/Static

	Parameter(s):
		0 :	OBJECT - Fahrzeug
		1 :	GROUP - Gruppe
		2 : BOOL - Mit Einheiten als Cargo

*/
#include "script_component.hpp"
CHECK(!isServer)

PARAMS_2(_vehicle,_gruppe);
DEFAULT_PARAM(2,_withCargo,false);
Private ["_crewmen","_unit"];

_createUnit = {
	_crewmen = dorb_crewmenlist SELRND;
	_unit = _crewmen createUnit [[0,0,500],_gruppe];
	_unit;
};

for "_i" from 1 to (_vehicle emptyPositions "Driver") do {
	_unit = call _createUnit;
	_unit assignAsDriver;
	_unit moveinDriver;
};

for "_i" from 1 to (_vehicle emptyPositions "Gunner") do {
	_unit = call _createUnit;
	_unit assignAsGunner;
	_unit moveinGunner;
};

for "_i" from 1 to (_vehicle emptyPositions "Commander") do {
	_unit = call _createUnit;
	_unit assignAsCommander;
	_unit moveinCommander;
};

If (_withCargo) then {
	private ["_platzanzahl",]
	_platzanzahl = (_return select 0) emptyPositions "cargo";
	for "_i" from 0 to (_platzanzahl - 1) do {
		_crewmen = dorb_menlist SELRND;
		_unit = call _createUnit;
		_unit assignAsCargo _vehicle;
		_unit moveInCargo _vehicle;
	};
};