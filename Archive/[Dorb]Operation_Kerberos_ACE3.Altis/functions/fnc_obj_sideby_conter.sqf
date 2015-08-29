/*
	Author: iJesuz
	
	Description:
		selfexplaining

	Parameter(s):
		0 : STRING - type of reinforcements
		1 : Array - Position
		2 : code - task
		3 : Array - Extra arguments

	Example:
		["small",getMarkerPos "spawn_sideby", { (driver (_this select 0)) move (position player); }] call DORB_fnc_obj_sideby_conter;
*/
#include "script_component.hpp"

SCRIPT(obj_sideby_conter);

private ["_type", "_position", "_task", "_args", "_vehicle", "_inf", "_infc", "_veh", "_group", "_unit", "_i"];

_type = [_this, 0, "small", ["small","medium","big","air"], [""]] call BIS_fnc_param;
_position = _this select 1;
_task = _this select 2;
_args = [_this, 3, []] call BIS_fnc_param;

_vehicle = getText (missionConfigFile >> "sideby_config" >> "conter" >> _type >> "vehicle");
_inf = getArray (missionConfigFile >> "sideby_config" >> "conter" >> _type >> "inf");
_infc = getArray (missionConfigFile >> "sideby_config" >> "conter" >> _type >> "infc");

/*
private "_marker";
_marker = createMarker[FORMAT_1("marker_conter_%1",_position),_position];
_marker setMarkerColor "ColorOPFOR";
_marker setMarkerType "hd_dot";
*/

_veh = createVehicle [_vehicle, _position, [], 0, "NONE"];
DORB_SIDEBY_OBJECTS pushBack _veh;
createVehicleCrew _veh;
{ DORB_SIDEBY_OBJECTS pushBack _x; } forEach (crew _veh);
ISNILS(DORB_SIDE,east);
_group = createGroup DORB_SIDE;
{
	for "_i" from 1 to (_infc select _forEachIndex) do {
		_unit = _group createUnit [_x, _position, [], 0, "NONE"];
		_unit moveInCargo _veh;
		DORB_SIDEBY_OBJECTS pushBack _unit;
	};
} forEach _inf;

[_veh, _group, _args] spawn _task;
