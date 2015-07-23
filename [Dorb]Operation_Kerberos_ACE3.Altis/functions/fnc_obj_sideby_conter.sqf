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

private ["_type", "_position", "_task", "_args", "_vehicle", "_inf", "_infc", "_veh", "_group", "_unit", "_i"];

_type = [_this, 0, "small", ["small","medium","big","air"], [""]] call BIS_fnc_param;
_position = _this select 1;
_task = _this select 2;
_args = [_this, 3, []] call BIS_fnc_param;

_vehicle = getText (missionConfigFile >> "sideby_config" >> "conter" >> _type >> "vehicle");
_inf = getArray (missionConfigFile >> "sideby_config" >> "conter" >> _type >> "inf");
_infc = getArray (missionConfigFile >> "sideby_config" >> "conter" >> _type >> "infc");

_veh = _vehicle createVehicle _position;
createVehicleCrew _veh;
_group = createGroup DORB_SIDE;
{
	for "_i" from 1 to (_infc select _forEachIndex) do {
		_unit = _group createUnit [_x, _position, [], 0, "FORM"];
		_unit moveInCargo _veh;
	};
} forEach _inf;

[_veh, _group, _args] spawn _task;
