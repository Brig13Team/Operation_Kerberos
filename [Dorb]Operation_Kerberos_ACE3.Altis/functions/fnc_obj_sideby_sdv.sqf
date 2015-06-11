/*
	Author: iJesuz
	
	Description:
		Erstellt ein gesunkenes SDV mit Wachen

	Parameter(s):
		0 : Array - Position
*/
#include "script_component.hpp"

private ["_position", "_sdv", "_enemyPos", "_i", "_radius", "_dir", "_enemy", "_boot"];

_position = _this select 0;

_sdv = "B_SDV_01_F" createVehicle _position;
_sdv setDamage 1;
_sdv setPosATL _position;

LOG(FORMAT_1("[SIDEBY] SDV an Position %1 erstellt!", _position));
uiSleep 5;

_enemyPos = [];
for "_i" from 1 to 5 do {
	_radius = floor(random 11) + 15;
	_dir = random 360;
	_enemyPos = _enemyPos + [[((cos _dir) * _radius) + (_position select 0), ((sin _dir) * _radius) + (_position select 1), 5]];
};

{
	_enemy = [_x, createGroup east, "O_diver_F"] call FM(spawn_unit);
	_enemy setPosATL _x;
	[_enemy, _x, 50, 6, "MOVE", "CARELESS", "WHITE", "NORMAL", "STAG COLUMN", "", [3,4,5]] call CBA_fnc_taskPatrol;
} forEach _enemyPos;

fnc_SDVAction = {
	private ["_target", "_caller", "_id", "_pos"];
	_target = _this select 0;
	_caller = _this select 1;
	_id = _this select 2;

	_target removeAction _id;

	_caller setVariable ["DORB_HAS_INTEL", true];

	LOG(FORMAT_1("[SIDEBY] %1 hat die Intel aufgehoben", _caller));
	hint "Informationen wurden vom Computer des SDV runtergeladen!";

	_pos = getMarkerPos "respawn_west";
	while { (_pos distance (getPos _caller)) > 25 } do  {};
	
	hint "Informationen wurden erfolgreich ausgewertet!";

	#ifndef TEST
		["random", [3, 0, 50] call FM(examine);
	#else
		LOG(FORMAT_3("[SIDEBY] pos: %1, fehlpos: %2, durchmesser: %3", 3, 0, 50));
	#endif
};

_sdv addAction ["Take Intel", {_this call fnc_SDVAction;}];
