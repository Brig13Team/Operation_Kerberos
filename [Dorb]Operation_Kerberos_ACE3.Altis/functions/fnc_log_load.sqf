/*
	Author: iJesuz

	Description:
		logistic script

*/
#include "script_component.hpp"

#define SPACE_BETWEEN_CARGO 0.1

params ["_cargo","_vehicle"];

private ["_cargo_class","_vehicle_class"];

_vehicle_class = typeOf _vehicle;
_cargo_class = [typeOf _cargo] call FM(log_getCargoCfg);

if (!isClass(missionConfigFile >> "logistics" >> "vehicles" >> _vehicle_class)) exitWith {
	["unsupported vehicle",["unsupported vehicle"],"",false] call FM(disp_info);
};
if (_cargo_class isEqualTo "") exitWith {
	["unsupported cargo",["unsupported cargo"],"",false] call FM(disp_info);
};
if (!(isNull attachedTo _cargo)) exitWith {
	["cargo already attached",["cargo already attached"],"",false] call FM(disp_info);
};

private ["_cargo_width","_cargo_length","_cargo_height","_point","_max_width","_max_length","_max_height","_logistic_stack"];

_cargo_width = getNumber(missionConfigFile >> "logistics" >> "cargos" >> _cargo_class >> "width");
_cargo_length = getNumber(missionConfigFile >> "logistics" >> "cargos" >> _cargo_class >> "length");
_cargo_height = getNumber(missionConfigFile >> "logistics" >> "cargos" >> _cargo_class >> "height");

_point = getArray(missionConfigFile >> "logistics" >> "vehicles" >> _vehicle_class >> "cargo_point");
_max_width = getNumber(missionConfigFile >> "logistics" >> "vehicles" >> _vehicle_class >> "max_width");
_max_length = getNumber(missionConfigFile >> "logistics" >> "vehicles" >> _vehicle_class >> "max_length");
_max_height = getNumber(missionConfigFile >> "logistics" >> "vehicles" >> _vehicle_class >> "max_height");
_logistic_stack = _vehicle getVariable ["LOGISTIC_CARGO_STACK",[]];

if ((_max_height > 0) && {_cargo_height > _max_height}) exitWith {
	["cargo to high",["cargo to high"],"",false] call FM(disp_info);
};
if (_cargo_width > _max_width) exitWith {
	["cargo to wide",["cargo to wide"],"",false] call FM(disp_info);
};

private "_attach_point";

if (!(_logistic_stack isEqualTo [])) then {
	private "_last_cargo";
	_last_cargo = _logistic_stack select ((count _logistic_stack) - 1); // [_lastElement,[_width,_length,_height],_left_length]

	if ((_max_length - (_last_cargo select 2) - SPACE_BETWEEN_CARGO) < _cargo_length) exitWith { _attach_point = []; };

	_attach_point = [_point select 0, (_point select 1) - (_cargo_length / 2) - (_last_cargo select 2) - SPACE_BETWEEN_CARGO, (_point select 2) + (_cargo_height / 2)];
	_logistic_stack pushBack [_cargo,[_cargo_width,_cargo_length,_cargo_height],_max_length - SPACE_BETWEEN_CARGO - _last_cargo select 2];
} else {
	if (_cargo_length > _max_length) exitWith { _attach_point = []; };

	_attach_point = [_point select 0, (_point select 1) - (_cargo_length / 2), (_point select 2) + (_cargo_height / 2)];
	_logistic_stack pushBack [_cargo,[_cargo_width,_cargo_length,_cargo_height],_max_length - _cargo_length];
};

if (_attach_point isEqualTo []) exitWith {
	["cargo to long",["cargo to long"],"",false] call FM(disp_info);
};

private ["_cargo_mass","_vehicle_mass"];

_cargo_mass = getMass _cargo;
_vehicle_mass = getMass _vehicle;

_cargo attachTo [_vehicle,_attach_point];
_vehicle setVariable ["LOGISTIC_CARGO_STACK",_logistic_stack,true];
_vehicle setMass (_vehicle_mass + _cargo_mass);
