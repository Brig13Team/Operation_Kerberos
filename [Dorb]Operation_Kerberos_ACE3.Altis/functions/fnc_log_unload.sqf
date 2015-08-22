/*
	Author: iJesuz

	Description:
		logistic script

*/
#include "script_component.hpp"

#define SPACE_BETWEEN_CARGO 0.1

params ["_vehicle"];

private ["_vehicle_class","_logistic_stack"];

_vehicle_class = typeOf _vehicle;
_logistic_stack = _vehicle getVariable ["LOGISTIC_CARGO_STACK",[]];

if (!isClass(missionConfigFile >> "logistics" >> "vehicles" >> _vehicle_class)) exitWith {
	["unsupported vehicle",["unsupported vehicle"],"",false] call FM(disp_info);
};
if (_logistic_stack isEqualTo []) exitWith {
	["vehicle is empty",["vehicle is empty"],"",false] call FM(disp_info);
};

private ["_last_cargo","_cargo_mass","_vehicle_mass","_load_point","_detach_point","_cargo_width","_cargo_length","_detach_point","_position","_height"];

_last_cargo = _logistic_stack select ((count _logistic_stack) - 1);
_load_point = getArray(missionConfigFile >> "logistics" >> "vehicles" >> _vehicle_class >> "load_point");
_cargo_width = _last_cargo select 1 select 0;
_cargo_length = _last_cargo select 1 select 1;
_cargo_height = _last_cargo select 1 select 2;
_detach_point = [_load_point select 0, (_load_point select 1) - (_cargo_length / 2), _load_point select 2];

detach (_last_cargo select 0);
_cargo_mass = getMass (_last_cargo select 0);
_vehicle_mass = getMass _vehicle;
(_last_cargo select 0) setPos (_vehicle modelToWorld _detach_point);

if ([_vehicle] call FM(log_candrop)) then {
	private "_para";
	_para = createVehicle ["B_Parachute_02_F",[0,0,0],[],0,"FLY"];
	_para setDir (getDir (_last_cargo select 0));
	_para setPos (getPos (_last_cargo select 0));
	(_last_cargo select 0) attachTo [_para,[0,0,0]];
};

_logistic_stack resize ((count _logistic_stack) - 1);
_vehicle setVariable ["LOGISTIC_CARGO_STACK",_logistic_stack,true];
_vehicle setMass (_vehicle_mass - _cargo_mass);
