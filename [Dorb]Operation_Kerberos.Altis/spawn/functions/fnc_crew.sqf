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
SCRIPT(crew);
params["_vehicle","_gruppe",["_withCargo",false,[true]]];
Private ["_crewmen","_unit","_crew"];
_crew = [];
If (IS_SIDE(_gruppe)) then {_gruppe = createGroup _gruppe;};

for "_i" from 1 to (_vehicle emptyPositions "Driver") do {
	_crewmen = dorb_crewmenlist SELRND;
	_unit = _gruppe createUnit [_crewmen, [0,0,500], [], 0, "NONE"];
	_unit assignAsDriver _vehicle;
	_unit moveinDriver _vehicle;
	_crew pushBack _unit;
};

for "_i" from 1 to (_vehicle emptyPositions "Gunner") do {
	_crewmen = dorb_crewmenlist SELRND;
	_unit = _gruppe createUnit [_crewmen, [0,0,500], [], 0, "NONE"];
	_unit assignAsGunner _vehicle;
	_unit moveinGunner _vehicle;
	_crew pushBack _unit;
};

for "_i" from 1 to (_vehicle emptyPositions "Commander") do {
	_crewmen = dorb_crewmenlist SELRND;
	_unit = _gruppe createUnit [_crewmen, [0,0,500], [], 0, "NONE"];
	_unit assignAsCommander _vehicle;
	_unit moveinCommander _vehicle;
	_crew pushBack _unit;
};

If (_withCargo) then {
	private ["_platzanzahl"];
	_platzanzahl = _vehicle emptyPositions "cargo";
	for "_i" from 0 to (_platzanzahl - 1) do {
		_crewmen = dorb_menlist SELRND;
		_unit = _gruppe createUnit [_crewmen, [0,0,500], [], 0, "NONE"];
		_unit assignAsCargo _vehicle;
		_unit moveInCargo _vehicle;
		_crew pushBack _unit;
	};
};
_crew
