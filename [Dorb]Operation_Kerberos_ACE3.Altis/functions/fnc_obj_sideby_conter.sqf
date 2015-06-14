/*
	Author: iJesuz
	
	Description:

	Parameter(s):
		0 : STRING - type of reinforcements
		1 : Array - Position
		2 : code - task
		3 : Array - Extra arguments

	Example:
		["small",getMarkerPos "spawn_sideby", { (driver (_this select 0)) move (position player); }] call DORB_fnc_obj_sideby_conter;
*/
#include "script_component.hpp"

private ["_type", "_position", "_task", "_args", "_vehicle", "_inf", "_veh", "_group", "_unit", "_i"];

_type = _this select 0;
_position = _this select 1;
_task = _this select 2;
_args = [_this, 3, []] call BIS_fnc_param;

switch (_type) do
{
	case "small":
	{
		_vehicle = "rhs_tigr_msv";
		_inf = [["rhs_msv_sergeant",1],["rhs_msv_marksman",1],["rhs_msv_medic",1],["rhs_msv_rifleman",1],["rhs_msv_grenadier",1]];
	};
	case "medium":
	{
		_vehicle = "rhs_gaz66_msv";
		_crew = [["rhs_msv_driver",1]];
		_inf = [["rhs_msv_sergeant",1],["rhs_msv_marksman",1],["rhs_msv_medic",1],["rhs_msv_rifleman",2],["rhs_msv_grenadier",1],["rhs_msv_at",1],["rhs_msv_machinegunner",1],["rhs_msv_machinegunner_assistant",1]];
	};
	case "big":
	{
		_vehicle = "rhs_btr80a_msv";
		_inf = [["rhs_msv_sergeant",1],["rhs_msv_marksman",1],["rhs_msv_medic",1],["rhs_msv_rifleman",3],["rhs_msv_grenadier",2],["rhs_msv_aa",2]];
	};
	case "air":
	{
		_vehicle = "RHS_Mi24P_vvsc";
		_inf = [["rhs_msv_sergeant",1],["rhs_msv_medic",1],["rhs_msv_rifleman",3],["rhs_msv_grenadier",3]];
	};
	default // same as "small"
	{
		_vehicle = "rhs_tigr_msv";
		_inf = [["rhs_msv_sergeant",1],["rhs_msv_marksman",1],["rhs_msv_medic",1],["rhs_msv_rifleman",1],["rhs_msv_grenadier",1]];
	};
};

_veh = _vehicle createVehicle _position;
createVehicleCrew _veh;
_group = createGroup east;
{
	for "_i" from 1 to (_x select 1) do {
		_unit = [_position, _group, _x select 0] call FM(spawn_unit);
		_unit moveInCargo _veh;
	};
} forEach _inf;

[_veh, _group, _args] call _task;
