/*
	Author: iJesuz
	
	Description:
		Erstellt ein gesunkenes SDV mit Wachen

	Parameter(s):
		0 : Array - Position
		1 : Array of String - [Sidetaskname, Taskname]
*/
#include "script_component.hpp"

SCRIPT(sdv);

private ["_position", "_pos", "_rescue_point", "_task_array", "_sdv", "_radius", "_description", "_depth", "_temp"];

params ["_position", "_task_array"];

GVAR(sideby_objects) = [];

#ifdef TEST
	_position = getMarkerPos "spawn_side";
#endif

_rescue_point = getMarkerPos "rescue_marker";

_pos = [_position, 50, 3] call EFUNC(common,random_pos);

_sdv = createVehicle ["B_SDV_01_F", _position, [], 0, "NONE"];
LOG(FORMAT_2("%1 at %2", _sdv, _pos));

if (isNull _sdv) exitWith {};

GVAR(sideby_objects) pushBack _sdv;

_sdv setPos _pos;
_sdv setPosATL [(position _sdv) select 0, (position _sdv) select 1, ((position _sdv) select 2) + 0.5];
_sdv setFuel 0.3;
_sdv setDamage 0.5;
_sdv setVariable [QGVAR(istarget),true];

{ GVAR(sideby_objects) pushBack _x; } forEach ([_position,  50, 0, 5] call EFUNC(spawn,patrol_water));
{ GVAR(sideby_objects) pushBack _x; } forEach ([_position, 100, 1, 0] call EFUNC(spawn,patrol_water));
{ GVAR(sideby_objects) pushBack _x; } forEach ([_position, 50, 50, 3] call EFUNC(spawn,naval_minefield));

[LSTRING(SIDE_SIDEMISSION),[LSTRING(SIDE_SDV_DESCRIPTION_SHORT)],"",false] call EFUNC(interface,disp_info_global);

_temp = [_task_array, true, [LSTRING(SIDE_SDV_DESCRIPTION), LSTRING(SIDE_SDV_DESCRIPTION_SHORT), LSTRING(SIDE_SDV_MARKER)], _position,"AUTOASSIGNED",0,false,true,"",true] call BIS_fnc_setTask;
missionNamespace setVariable [QGVAR(current_sidemission),_temp];

LOG("SCHLEIFE GESTARTET");
while { (!(_temp isEqualTo "")) AND { ((position _sdv) distance _rescue_point) > 25 } AND {(damage _sdv) != 1} } do { uiSleep 5; _temp = missionNamespace getVariable [QGVAR(current_sidemission),""]; };
LOG("SCHLEIFE ABGEBROCHEN");
if (_temp isEqualTo "") exitWith {};

if ((damage _sdv == 1)) then {
	[LSTRING(SIDE_SIDEMISSION),[LSTRING(SIDE_FAILED)],"",false] call EFUNC(interface,disp_info_global);
	[_task_array select 0, "Failed", false] call BIS_fnc_taskSetState;
	missionNamespace setVariable [QGVAR(current_sidemission),""];
} else {
	[LSTRING(SIDE_SIDEMISSION),[LSTRING(SIDE_FINISHED)],"",false] call EFUNC(interface,disp_info_global);
	[_task_array select 0, "Succeeded", false] call BIS_fnc_taskSetState;
	[_task_array select 1, "targets", [3, 50]] call FUNC(reward);
	missionNamespace setVariable [QGVAR(current_sidemission),""];
};
