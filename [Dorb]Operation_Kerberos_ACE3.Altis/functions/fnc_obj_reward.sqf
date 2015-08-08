/*
	Author: iJesuz
	
	Description:

	Parameter(s):
		0 : String or Task
		1 : String - Reward Typ (Optional)
		2 : Array - Parameters (Optional)
		3 : Scalar - Radius (Optional)

	Reward Types:
		patrols
		car_patrols
		apc_patrols
		tank_patrols
		air_patrols
		water_patrols
		commandovehicles
		targets
		useless_intel
		inf
*/
#include "script_component.hpp"

SCRIPT(obj_reward);

private["_reward", "_main_task", "_parameter", "_anz", "_durchmesser", "_position", "_radius", "_reward_types", "_reward_types_per", "_function"];

_main_task = [_this, 0, ""] call BIS_fnc_param;
_reward = [_this, 1, "targets"] call BIS_fnc_param;
_parameter = [_this, 2, []] call BIS_fnc_param;
_radius = [_this, 3, 1500] call BIS_fnc_param;

LOG(FORMAT_2("_reward = %1 | _parameter = %2",_reward,_parameter));

if (typeName _main_task == "STRING") then {
	_position = [_main_task] call BIS_fnc_taskDestination;
} else {
	_position = taskDestination _main_task;
};

_function = {
	private ["_marker", "_marker_array", "_dir", "_mposition", "_veh", "_function", "_blacklist"];
	
	_blacklist = [_this, 5, [], [[]]] call BIS_fnc_param;

	_marker_array = missionNamespace getVariable [FORMAT_1("DORB_REWARD_MARKER_%1", _this select 4), []];
	MAPL("deleteMarker", _marker_array);
	_marker_array = [];

	_veh = nearestObjects[_this select 0, _this select 1, _this select 2];
	{
		if ((side _x == DORB_SIDE) && ( ( [_x, _blacklist] call { private["_ret", "_var", "_blacklist"]; params["_var", "_blacklist"]; _ret = { _var isKindOf _x } count _blacklist; _ret } ) == 0 ) ) then {
			_mposition = position driver _x;
			_dir = direction _x;

			// LOG(FORMAT_1("marker created at %1", _mposition));
			_marker = createMarker[ FORMAT_2("Reward_Marker_%1_%2", _this select 3, count _marker_array), _mposition];
			_marker setMarkerType (_this select 3);
			_marker setMarkerColor "ColorOPFOR";
			_marker setMarkerText ( FORMAT_2("Patrol (%1:%2)", date select 3, date select 4) );
			_marker_array pushBack _marker;

			_marker = createMarker[ FORMAT_2("Reward_Marker_%1_%2", _this select 3, count _marker_array), [(_mposition select 0) + ((sin _dir) * 2), (_mposition select 1) + ((cos _dir) * 2)] ];
			_marker setMarkerType "hd_arrow";
			_marker setMarkerColor "ColorOPFOR";
			_marker setMarkerDir _dir;
			_marker_array pushBack _marker;
		};	
	} forEach _veh;
	missionNamespace setVariable [FORMAT_1("DORB_REWARD_MARKER_%1", _this select 4),_marker_array];
};

if (_reward in ["patrols", "car_patrols", "apc_patrols", "tank_patrols", "air_radar", "water_patrols", "commandovehicles", "targets", "useless_intel", "inf"]) then {
	LOG(FORMAT_1("[REWARD] %1", _reward));
} else {
	LOG("[REWARD] default");
};

#define APC_CLASSNAMES ["APC","APC_Tracked_01_base_F","APC_Tracked_02_base_F","APC_Tracked_03_base_F","APC_Wheeled_01_base_F","APC_Wheeled_02_base_F","APC_Wheeled_03_base_F","Wheeled_Apc_F","Wheeled_APC","Tracked_APC", "rhs_bmp_base"]

switch (_reward) do {
	case "targets":
	{
		LOG("targets");
		private ["_anz", "_durchmesser"];
		_anz = [_parameter, 0, 2] call BIS_fnc_param;
		_durchmesser = [_parameter, 1, 50] call BIS_fnc_param;
		["random", [_anz, 0, _durchmesser, 0]] call FM(examine);
	};
	case "useless_intel":
	{
		private["_anz_normal", "_anz_random", "_durchmesser_normal", "_durchmesser_random"];
		_anz_normal = [_parameter, 0, 0] call BIS_fnc_param;
		_anz_random = [_parameter, 1, 2] call BIS_fnc_param;
		_durchmesser_normal = [_parameter, 2, 50] call BIS_fnc_param;
		_durchmesser_random = [_parameter, 3, 50] call BIS_fnc_param;
		["random", [_anz_normal, _anz_random, _durchmesser_normal, _durchmesser_random]] call FM(examine);
	};
	case "patrols":
	{
		private ["_marker", "_marker_array", "_dir", "_mposition"];

		_marker_array = missionNamespace getVariable ["DORB_REWARD_MARKER", []];
		MAPL("deleteMarker", _marker_array);
		_marker_array = [];
		{
			if ( (side _x == DORB_SIDE) && ((leader _x) == (vehicle (leader _x))) && ((count units _x) > 1) && (((leader _x) distance _position) <= _radius)) then {
				_mposition = position (leader _x);
				_dir = direction (leader _x);

				_marker = createMarker[ FORMAT_1("Reward_Marker_%1", count _marker_array), _mposition];
				_marker setMarkerType "o_inf";
				_marker setMarkerColor "ColorOPFOR";
				_marker setMarkerText ( FORMAT_2("Patrol (%1:%2)", date select 3, date select 4) );
				_marker_array pushBack _marker;

				_marker = createMarker[ FORMAT_1("Reward_Marker_%1", count _marker_array), [(_mposition select 0) + ((sin _dir) * 2), (_mposition select 1) + ((cos _dir) * 2)] ];
				_marker setMarkerType "hd_arrow";
				_marker setMarkerColor "ColorOPFOR";
				_marker setMarkerDir _dir;
				_marker_array pushBack _marker;
			};	
		} forEach allGroups;
		missionNamespace setVariable ["DORB_REWARD_MARKER",_marker_array];
	};
	case "car_patrols":
	{
		[_position, ["Car"], _radius, "o_motor_inf", 2] call _function;
	};
	case "apc_patrols":
	{
		[_position, APC_CLASSNAMES, _radius, "o_mech_inf", 3] call _function;
	};
	case "tank_patrols":
	{
		[_position, ["Tank"], _radius, "o_armor", 4, APC_CLASSNAMES] call _function;
	};
	case "water_patrols":
	{
		[_position, ["Ship"], _radius, "o_naval", 5, APC_CLASSNAMES] call _function;
	};

	case "air_radar":
	{
		[_position, ["Plane"], _radius, "o_plane", 6] call _function;
		[_position, ["Helicopter"], _radius, "o_air", 7] call _function;
	};
	case "commandovehicles":
	{
		private ["_commando_vehicles", "_veh", "_marker", "_marker_array"];
		
		_marker_array = missionNamespace getVariable ["DORB_REWARD_MARKER_8", []];
		MAPL("deleteMarker", _marker_array);
		_marker_array = [];
		_commando_vehicles = dorb_commandveh_radio + dorb_radar;
		_veh = nearestObjects [_position, _commando_vehicles, _radius];
		{
			_marker = createMarker [ FORMAT_1("Reward_Marker_8_%1", count _marker_array), position _x];
			_marker setMarkerType "o_hq";
			_marker setMarkerColor "ColorOPFOR";
			_marker setMarkerText ( FORMAT_2("MHQ (%1:%2)", date select 3, date select 4) );
		} forEach _veh;
		missionNamespace setVariable ["DORB_REWARD_MARKER_8",_marker_array];
	};
	case "inf": // not made for ingame usage
	{
		private ["_marker", "_marker_array", "_men"];

		_marker_array = missionNamespace getVariable ["DORB_REWARD_MARKER_INF", []];
		MAPL("deleteMarker", _marker_array);
		{
			if ( (side _x == DORB_SIDE) && ((_x distance _position) <= _radius) ) then {
				_marker = createMarker[ FORMAT_1("Reward_Marker_Unit_%1", count _marker_array), position _x];
				_marker setMarkerType "hd_dot";
				_marker setMarkerColor "ColorOPFOR";
				_marker_array pushBack _marker;
			};
		} forEach allUnits;
		missionNamespace setVariable ["DORB_REWARD_MARKER_INF",_marker_array];
	};
	default
	{
		LOG("default");
		private ["_anz", "_durchmesser"];
		_anz = [_parameter, 0, 2] call BIS_fnc_param;
		_durchmesser = [_parameter, 1, 50] call BIS_fnc_param;
		["random", [_anz, 0, _durchmesser, 0]] call FM(examine);
	};
};

#undef APC_CLASSNAMES
