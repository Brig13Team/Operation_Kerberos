/*
	Author: iJesuz
	
	Description:
		Erstellt ein gesunkenes SDV mit Wachen

	Parameter(s):
		0 : Array - Position
		1 : Array of String - [Sidetaskname, Taskname]
*/
#include "script_component.hpp"

private ["_position", "_task_array", "_sdv", "_enemyPos", "_i", "_radius", "_dir", "_enemys", "_description", "_boat"];

params ["_position", "_task_array"];

DORB_SIDEBY_OBJECTS = [];

#ifdef TEST
	_position = getMarkerPos "spawn_side";
#endif

_sdv = createVehicle ["B_SDV_01_F", [-100,-100,0], [], 0, "NONE"];
DORB_SIDEBY_OBJECTS pushBack _sdv;
if (isMultiplayer) then {
    _sdv enableSimulationGlobal false;
} else {
    _sdv enableSimulation false;
};
_sdv setDamage 1;
uiSleep 5;
_sdv setVariable ["DORB_HAS_INTEL",true];
_sdv setVariable ["DORB_IS_TARGET",true];
_sdv setPosATL [_position select 0, _position select 1, 0];

{ DORB_SIDEBY_OBJECTS pushBack _x; } forEach ([_position,  50, 0, 5] call FM(spawn_patrol_water));
{ DORB_SIDEBY_OBJECTS pushBack _x; } forEach ([_position, 100, 1, 0] call FM(spawn_patrol_water));

fnc_SDVAction = {
	private ["_target", "_caller", "_id", "_task", "_main_task", "_pos"];
	_target = _this select 0;
	_caller = _this select 1;
	_id = _this select 2;
	_task = _this select 3 select 0;
	_main_task = _this select 3 select 1;

	_target removeAction _id;

	if (_target getVariable ["DORB_HAS_INTEL", false]) then {
		_caller setVariable ["DORB_HAS_INTEL", true];
		_target setVariable ["DORB_HAS_INTEL", false];

		hint localize "STR_DORB_SIDE_SDV_INFORMATION_DOWNLOADED";

		[0, {
			private ["_pos","_caller","_main_task"];
			params ["_caller","_main_task"];
			_pos = getMarkerPos "respawn_west";

			LOG("SCHLEIFE GESTARTET");
			while { (!(DORB_SIDEBY_OBJECTS isEqualTo [])) AND {(_pos distance (getPos _caller)) > 25 AND (_caller != objNull) AND (alive _caller)} } do  { uiSleep 5; };
			LOG("SCHLEIFE ABGEBROCHEN");
			if (DORB_SIDEBY_OBJECTS isEqualTo []) exitWith {};
			
			["STR_DORB_SIDE_SIDEMISSION",["STR_DORB_SIDE_FINISHED"],"",false] call FM(disp_info_global);	
			#ifdef TEST
				LOG("[SIDEBY] U-Boot abgeschlossen!");
				LOG(FORMAT_3("[SIDEBY] pos: %1, fehlpos: %2, durchmesser: %3", 3, 0, 50));
			#else
				[_task, "Succeeded", true] call BIS_fnc_taskSetState;
				[_main_task, "targets", [3, 50]] call FM(obj_reward);
			#endif
		}, [_caller,_main_task]] FMP;
	} else {
		hint localize "STR_DORB_SIDE_SDV_NO_INTEL_FOUND";
	};
};

["STR_DORB_SIDE_SIDEMISSION",["STR_DORB_SIDE_SDV_DESCRIPTION_SHORT"],"",false] call FM(disp_info_global);
#ifdef TEST
	LOG("[SIDEBY] U-Boot erstellt!");
#else
	[_task_array, true, ["STR_DORB_SIDE_SDV_DESCRIPTION", "STR_DORB_SIDE_SDV_DESCRIPTION_SHORT", "STR_DORB_SIDE_SDV_MARKER"], _position,"AUTOASSIGNED",0,false,true,"",true] spawn BIS_fnc_setTask;
#endif

[-1, {
	private["_sdv", "_task_array"];
	params["_sdv","_task_array"];
	_sdv addAction [localize "STR_DORB_SIDE_SDV_TAKE_INTEL", {_this call fnc_SDVAction;}, _task_array];
}, [_sdv,_task_array]] FMP;

ISNILS(DORB_MISSION_FNC,[]);
DORB_MISSION_FNC = DORB_MISSION_FNC + [ [_sdv, _task_array], "(_this select 0) addAction [localize 'STR_DORB_SIDE_SDV_TAKE_INTEL', {_this call fnc_SDVAction;}, _this select 1];" ];
publicVariable "DORB_MISSION_FNC";
