/*
	Author: iJesuz

	Description:
		logistic script

*/
#include "script_component.hpp"

#define SPACE_BETWEEN_CARGO 0.1

params ["_mode"];

switch(_mode) do {
	case "load": {
		private ["_cargo","_cargo_class","_vehicle","_vehicle_class"];

		_cargo = _this select 1;
		_vehicle = _this select 2;
		_vehicle_class = typeOf _vehicle;
		_cargo_class = typeOf _cargo;

		if (!isClass(missionConfigFile >> "logistics" >> "vehicles" >> _vehicle_class)) exitWith {
			["unsupported vehicle",["unsupported vehicle"],"",false] call FM(disp_info_global);
		};
		if (!isClass(missionConfigFile >> "logistics" >> "cargos" >> _cargo_class)) exitWith {
			["unsupported cargo",["unsupported cargo"],"",false] call FM(disp_info_global);
		};

		private ["_cargo_width","_cargo_length","_cargo_height","_point","_max_width","_max_length","_max_height","_logistic_stack"];

		_cargo_width = getNumber(missionConfigFile >> "logistics" >> "cargos" >> _cargo_class >> "width");
		_cargo_length = getNumber(missionConfigFile >> "logistics" >> "cargos" >> _cargo_class >> "length");
		_cargo_height = getNumber(missionConfigFile >> "logistics" >> "cargos" >> _cargo_class >> "height");

		_point = getArray(missionConfigFile >> "logistics" >> "vehicles" >> _vehicle_class >> "point");
		_max_width = getNumber(missionConfigFile >> "logistics" >> "vehicles" >> _vehicle_class >> "max_width");
		_max_length = getNumber(missionConfigFile >> "logistics" >> "vehicles" >> _vehicle_class >> "max_length");
		_max_height = getNumber(missionConfigFile >> "logistics" >> "vehicles" >> _vehicle_class >> "max_height");
		_logistic_stack = _vehicle getVariable ["LOGISTIC_CARGO_STACK",[]];

		if ((_cargo_height > 0) && {_cargo_height > _max_height}) exitWith {
			["cargo to high",["cargo to high"],"",false] call FM(disp_info_global);
		};
		if (_cargo_width > _max_width) exitWith {
			["cargo to wide",["cargo to wide"],"",false] call FM(disp_info_global);
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
			["cargo to long",["cargo to long"],"",false] call FM(disp_info_global);
		};

		private ["_cargo_mass","_vehicle_mass"];

		_cargo_mass = getMass _cargo;
		_vehicle_mass = getMass _vehicle;

		_cargo attachTo [_vehicle,_attach_point];
		_vehicle setVariable ["LOGISTIC_CARGO_STACK",_logistic_stack];
		_vehicle setMass (_vehicle_mass + _cargo_mass);
	};
	case "unload": {
		private ["_vehicle","_vehicle_class","_logistic_stack"];

		_vehicle = _this select 1;
		_vehicle_class = typeOf _vehicle;
		_logistic_stack = _vehicle getVariable ["LOGISTIC_CARGO_STACK",[]];

		if (!isClass(missionConfigFile >> "logistics" >> "vehicles" >> _vehicle_class)) exitWith {
			["unsupported vehicle",["unsupported vehicle"],"",false] call FM(disp_info_global);
		};
		if (_logistic_stack isEqualTo []) exitWith {
			["vehicle is empty",["vehicle is empty"],"",false] call FM(disp_info_global);
		};

		private ["_last_cargo","_cargo_mass","_vehicle_mass"];

		_last_cargo = _logistic_stack select ((count _logistic_stack) - 1);
		
		detach (_last_cargo select 0);
		_cargo_mass = getMass (_last_cargo select 0);
		_vehicle_mass = getMass _vehicle;
		(_last_cargo select 0) setPos /*(getArray(missionConfigFile >> "logistics" >> "vehicles" >> _vehicle_class >> "lpoint"))*/(getPos _vehicle);
		
		_logistic_stack = _logistic_stack - _last_cargo;
		_vehicle setVariable ["LOGISTIC_CARGO_STACK",_logistic_stack];
		_vehicle setMass (_vehicle_mass - _cargo_mass);
	};
};
