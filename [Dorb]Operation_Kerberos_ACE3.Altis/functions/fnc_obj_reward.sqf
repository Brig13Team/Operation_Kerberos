/*
	Author: iJesuz
	
	Description:

	Parameter(s):
		0 : String - Reward Typ (Optional)
		1 : String - task
		2 : Array - Depending on 1 (see below)

*/
#include "script_component.hpp"

private["_reward", "_main_task", "_parameter", "_anz", "_durchmesser", "_anz_normal", "_anz_random", "_durchmesser_normal", "_durchmesser_random", "_commando_vehicles"];

_reward = [_this, 0, ""] call BIS_fnc_param;
_main_task = [_this, 1, ""] call BIS_fnc_param;
_parameter = [_this, 2, []] call BIS_fnc_param;

_commando_vehicles = ["rhs_gaz66_r142_vdv", "rhs_gaz66_r142_vv", "rhs_p37", "rhs_prv13", "rhs_prp3_tv"];
_position = taskDestination _main_task;
_radius = 1500;

_reward_types = ["targets", "patrols", "ieds", "radar", "satcom", "useless_intel"];
_reward_types_per = [1,1,1,1,1,1];

if ((_reward == "") or !(_reward in _reward_types)) then { _reward = [_reward_types, _reward_types_per] call BIS_fnc_selectRandomWeighted; };

switch (_reward) do {
	case "targets":
	{
		_anz = [_parameter, 0, 2] call BIS_fnc_param;
		_durchmesser = [_parameter, 1, 50] call BIS_fnc_param;
		["random", [_anz, 0, _durchmesser, 0]] call FM(examine);
	};
	case "patrols":
	{
		_counter = 1;
		{
			if ( (side (leader _x) == EAST) && ((leader _x) distance _pos)<radius ) then {
				_marker = createMarker[ format ["enemy_group_%1_%2",_counter-1, position leader _x], position leader _x ];
				if ((leader _x) == (vehicle leader _x)) then {
					_marker setMarkerType "o_inf";
				} else {
					_marker setMarkerType "o_motor_inf";
				};
				_marker setMarkerText "ColorOPFOR";
				_marker setMarkerText FORMAT_1("Enemy patrol (%1)",_counter);
				_counter = _counter + 1;
			};
		} forEach allGroups;
	};
	case "radar":
	{
		_veh = nearestObjects [_position, _commando_vehicles, _radius];
		_counter = 0;
		{
			_marker = createMarker [ format ["commando_vehicle_%1_%2", _counter, position _x], position _x ];
			_marker setMarkerType "o_hq";
			_marker setMarkerColor "ColorOPFOR";
			_marker setMarkerText "MHQ";
			_counter = _counter + 1;
		} forEach _veh;
	};
	case "satcom":
	{
		// write own or use existing ?
	};
	case "useless_intel":
	{
		_anz_normal = [_parameter, 0, 0] call BIS_fnc_param;
		_anz_random = [_parameter, 1, 2] call BIS_fnc_param;
		_durchmesser_normal = [_parameter, 2, 50] call BIS_fnc_param;
		_durchmesser_random = [_parameter, 3, 50] call BIS_fnc_param;
		["random", [_anz_normal, _anz_random, _durchmesser_normal, _durchmesser_random]] call FM(examine);
	};
	default
	{
		_anz = [_parameter, 0, 2] call BIS_fnc_param;
		_durchmesser = [_parameter, 1, 50] call BIS_fnc_param;
		["random", [_anz, 0, _durchmesser, 0]] call FM(examine);
	};
};
