/*
	Author: iJesuz

	Description:
		logistic script

	Parameter(s):
		0: OBJECT - cargo
		1: OBJECT - vehicle

*/
#include "script_component.hpp"
SCRIPT(log_load);

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

private ["_cargo_width","_cargo_length","_cargo_height", "_cargo_offset","_point","_max_width","_max_length","_max_height","_logistic_stack"];

_cargo_width = getNumber(missionConfigFile >> "logistics" >> "cargos" >> _cargo_class >> "width");
_cargo_length = getNumber(missionConfigFile >> "logistics" >> "cargos" >> _cargo_class >> "length");
_cargo_height = getNumber(missionConfigFile >> "logistics" >> "cargos" >> _cargo_class >> "height");
_cargo_offset = [0,0,0];
if (isArray(missionConfigFile >> "logistics" >> "cargos" >> _cargo_class)) then {
	_cargo_offset = getArray(missionConfigFile >> "logistics" >> "cargos" >> _cargo_class >> "offset");
};

_point = getArray(missionConfigFile >> "logistics" >> "vehicles" >> _vehicle_class >> "cargo_point");
_max_width = getNumber(missionConfigFile >> "logistics" >> "vehicles" >> _vehicle_class >> "max_width");
_max_length = getNumber(missionConfigFile >> "logistics" >> "vehicles" >> _vehicle_class >> "max_length");
_max_height = getNumber(missionConfigFile >> "logistics" >> "vehicles" >> _vehicle_class >> "max_height");
_logistic_stack = _vehicle getVariable ["LOGISTIC_CARGO_STACK",[]];

if ((_max_height > 0) && {_cargo_height > _max_height}) exitWith {
	["cargo to high",["cargo to high"],"",false] call FM(disp_info);
};

private ["_attach_point","_rotate"];

if (!(_logistic_stack isEqualTo [])) then {
	private ["_last_cargo","_length"];
	_last_cargo = _logistic_stack select ((count _logistic_stack) - 1); // [_lastElement,[_width,_length,_height],_left_length]
	_length = _last_cargo select 2;

	if (((_length < _cargo_length - SPACE_BETWEEN_CARGO) || (_max_width < _cargo_width)) && ((_length < _cargo_width - SPACE_BETWEEN_CARGO) || (_max_width < _cargo_length))) exitWith {
		_attach_point = [];
	};

	_rotate = true;
	if ((_max_length >= _cargo_length - SPACE_BETWEEN_CARGO) && (_max_width >= _cargo_width)) then { _rotate = false; };
	// if ( && {(_max_length >= _cargo_width - SPACE_BETWEEN_CARGO) && (_max_width >= _cargo_length)}) then { _rotate = true; };

	if (_rotate) then {
		_attach_point = [_point select 0 + (_cargo_offset select 0), (_point select 1) - (_cargo_width / 2) - SPACE_BETWEEN_CARGO - _max_length + (_last_cargo select 2) + (_cargo_offset select 1), (_point select 2) + (_cargo_height / 2)  + (_cargo_offset select 2)];
		_logistic_stack pushBack [_cargo,[_cargo_width,_cargo_length,_cargo_height],(_last_cargo select 2) - SPACE_BETWEEN_CARGO - _cargo_width];
	} else {
		_attach_point = [_point select 0 + (_cargo_offset select 0), (_point select 1) - (_cargo_length / 2) - SPACE_BETWEEN_CARGO - _max_length + (_last_cargo select 2) + (_cargo_offset select 1), (_point select 2) + (_cargo_height / 2)  + (_cargo_offset select 2)];
		_logistic_stack pushBack [_cargo,[_cargo_width,_cargo_length,_cargo_height],(_last_cargo select 2) - SPACE_BETWEEN_CARGO - _cargo_length];
	};
} else {
	LOG(FORMAT_1("%1",_max_length < _cargo_length));
	LOG(FORMAT_1("%1",_max_width < _cargo_width));
	LOG(FORMAT_1("%1",_max_length < _cargo_width));
	LOG(FORMAT_1("%1",_max_width < _cargo_length));
	if (((_max_length < _cargo_length) || (_max_width < _cargo_width)) && ((_max_length < _cargo_width) || (_max_width < _cargo_length))) exitWith {
		LOG("INSIDE");
		_attach_point = [];
	};

	_rotate = true;
	if ((_max_length >= _cargo_length) && (_max_width >= _cargo_width)) then { _rotate = false; };
	// if (_rotate && {(_max_length >= _cargo_width) && (_max_width >= _cargo_length)}) then { _rotate = true; };

	if (_rotate) then {
		_attach_point = [_point select 0 + (_cargo_offset select 0), (_point select 1) - (_cargo_width / 2)  + (_cargo_offset select 1), (_point select 2) + (_cargo_height / 2) + (_cargo_offset select 2)];
		_logistic_stack pushBack [_cargo,[_cargo_width,_cargo_length,_cargo_height],_max_length - _cargo_width];
	} else {
		_attach_point = [_point select 0 + (_cargo_offset select 0), (_point select 1) - (_cargo_length / 2)  + (_cargo_offset select 1), (_point select 2) + (_cargo_height / 2) + (_cargo_offset select 2)];
		_logistic_stack pushBack [_cargo,[_cargo_width,_cargo_length,_cargo_height],_max_length - _cargo_length];
	};
};

if(_attach_point isEqualTo []) exitWith {
	["cargo doesn't fit",["cargo doesn't fit"],"",false] call FM(disp_info);
};

private ["_cargo_mass","_vehicle_mass"];

_cargo_mass = getMass _cargo;
_vehicle_mass = getMass _vehicle;

_cargo attachTo [_vehicle,_attach_point];
if(_rotate) then { _cargo setDir 90; };
_vehicle setVariable ["LOGISTIC_CARGO_STACK",_logistic_stack,true];
_vehicle setMass (_vehicle_mass + _cargo_mass);
