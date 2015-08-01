/*
	Author: iJesuz
	
	Description:
		Erstellt ein gesunkenes SDV mit Wachen

	Parameter(s):
		0 : Array - Position
		1 : Array of String - [Sidetaskname, Taskname]
*/
#include "script_component.hpp"

SCRIPT(obj_sideby_sdv);

private ["_position", "_pos", "_rescue_point", "_task_array", "_sdv", "_radius", "_description", "_depth"];

params ["_position", "_task_array"];

DORB_SIDEBY_OBJECTS = [];

#ifdef TEST
	_position = getMarkerPos "spawn_side";
#endif

_rescue_point = getMarkerPos "rescue_marker";

_pos = [_position, 50, 3] call FM(random_pos);

_sdv = createVehicle ["B_SDV_01_F", _position, [], 0, "NONE"];
LOG(FORMAT_2("%1 at %2", _sdv, _pos));

if (isNull _sdv) exitWith {};

DORB_SIDEBY_OBJECTS pushBack _sdv;

_sdv setPos _pos;
_sdv setPosATL [(position _sdv) select 0, (position _sdv) select 1, ((position _sdv) select 2) + 0.5];
_sdv setFuel 0.3;
_sdv setDamage 0.5;
/*
private "_marker";
_marker = createMarker["sdv_marker", _pos];
_marker setMarkerType "hd_dot";
_marker setMarkerColor "ColorOPFOR";
*/
_sdv setVariable ["DORB_IS_TARGET",true];

{ DORB_SIDEBY_OBJECTS pushBack _x; } forEach ([_position,  50, 0, 5] call FM(spawn_patrol_water));
{ DORB_SIDEBY_OBJECTS pushBack _x; } forEach ([_position, 100, 1, 0] call FM(spawn_patrol_water));
{ DORB_SIDEBY_OBJECTS pushBack _x; } forEach ([_position, 50, 50, 3] call FM(spawn_naval_minefield));

["STR_DORB_SIDE_SIDEMISSION",["STR_DORB_SIDE_SDV_DESCRIPTION_SHORT"],"",false] call FM(disp_info_global);
#ifdef TEST
	LOG("[SIDEBY] U-Boot erstellt!");
#else
	[_task_array, true, ["STR_DORB_SIDE_SDV_DESCRIPTION", "STR_DORB_SIDE_SDV_DESCRIPTION_SHORT", "STR_DORB_SIDE_SDV_MARKER"], _position,"AUTOASSIGNED",0,false,true,"",true] spawn BIS_fnc_setTask;
#endif

LOG("SCHLEIFE GESTARTET");
while { (!(DORB_SIDEBY_OBJECTS isEqualTo [])) AND { ((position _sdv) distance _rescue_point) > 25 } AND {(damage _sdv) != 1} } do { uiSleep 5; };
LOG("SCHLEIFE ABGEBROCHEN");
if (DORB_SIDEBY_OBJECTS isEqualTo []) exitWith {};

if ((damage _sdv == 1)) then {
	["STR_DORB_SIDE_SIDEMISSION",["STR_DORB_SIDE_FAILED"],"",false] call FM(disp_info_global);
	[_task_array select 0, "Failed", false] call BIS_fnc_taskSetState;
} else {
	["STR_DORB_SIDE_SIDEMISSION",["STR_DORB_SIDE_FINISHED"],"",false] call FM(disp_info_global);
	[_task_array select 0, "Succeeded", false] call BIS_fnc_taskSetState;
	[_task_array select 1, "targets", [3, 50]] call FM(obj_reward);
};
