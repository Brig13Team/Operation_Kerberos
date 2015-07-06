/*
	Author: iJesuz
	
	Description:
		Erstellt ein gesunkenes SDV mit Wachen

	Parameter(s):
		0 : Array - Position
		1 : Array of String - [Sidetaskname, Taskname]
*/
#include "script_component.hpp"

private ["_position", "_task_array", "_sdv", "_enemyPos", "_i", "_radius", "_dir", "_enemy", "_description", "_boat"];

_position = _this select 0;
_task_array = _this select 1;

_sdv = "B_SDV_01_F" createVehicle _position;
SETPVAR(_sdv, DORB_ISTARGET, true);
_sdv setDamage 1;
uiSleep 5;
_sdv setPosATL [_position select 0, _position select 1, 0];

_enemyPos = [];
for "_i" from 1 to 5 do {
	_radius = floor(random 11) + 15;
	_dir = random 360;
	_enemyPos = _enemyPos + [[((cos _dir) * _radius) + (_position select 0), ((sin _dir) * _radius) + (_position select 1), 0]];
};

{
	_enemy = [_x, createGroup east, "O_diver_F"] call FM(spawn_unit);
	_enemy swimInDepth ( ((getPosASL _enemy) select 2) - ((getPosATL _enemy) select 2) + 1 );
	[group _enemy, position _enemy, 50, 6, "MOVE", "CARELESS", "WHITE", "NORMAL", "STAG COLUMN", "", [3,4,5]] call CBA_fnc_taskPatrol;
} forEach _enemyPos;

_boat = "O_Boat_Armed_01_hmg_F" createVehicle _position;
createVehicleCrew _boat;
[group (driver _boat), position (driver boat), 100, 6, "MOVE", "CARELESS", "WHITE", "NORMAL", "STAG COLUMN", "", [1,1,1]] call CBA_fnc_taskPatrol;

fnc_SDVAction = {
	private ["_target", "_caller", "_id", "_task", "_main_task", "_pos"];
	_target = _this select 0;
	_caller = _this select 1;
	_id = _this select 2;
	_task = _this select 3 select 0;
	_main_task = _this select 3 select 1;

	_target removeAction _id;

	_caller setVariable ["DORB_HAS_INTEL", true];

	hint "Informationen wurden vom Computer des SDV runtergeladen!";

	_pos = getMarkerPos "respawn_west";
	while { (_pos distance (getPos _caller)) > 25 AND (_caller != objNull) AND (alive caller)} do  {};
	
	hint "Informationen wurden erfolgreich ausgewertet!";
		
	#ifdef TEST
		LOG("[SIDEBY] U-Boot abgeschlossen!");
		LOG(FORMAT_3("[SIDEBY] pos: %1, fehlpos: %2, durchmesser: %3", 3, 0, 50));
	#else
		_task setTaskState "Succeeded";
		["random", _main_task, [3, 0, 50]] call FM(examine);
	#endif
};

_description = "Eines unserer U-Boote ist gesunken. An Bord befanden sich sensible Informationen. Bergen Sie diese und bringen Sie sie zurück zur Basis.";

#ifdef TEST
	LOG("[SIDEBY] U-Boot erstellt!");
#else
	[_task_array, true, [_description, "gesunkenes U-Boot", "Bergen"], _position,"AUTOASSIGNED",0,false,true,"",true] spawn BIS_fnc_setTask;
#endif

_sdv addAction ["Take Intel", {_this call fnc_SDVAction;}, _task_array];
