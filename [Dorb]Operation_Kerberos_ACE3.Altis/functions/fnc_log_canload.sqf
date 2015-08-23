/*
	Author: Dorbedo
	
	Description:
		Checks if Unit can load
		
	Parameter(s):
		0 : OBJECT - Target
		
	Returns:
		BOOL
*/
#include "script_component.hpp"
SCRIPT(log_canload);

#define SPACE_BETWEEN_CARGO 0.1

if (player getVariable ["DORB_ISLOADING",false]) exitWith { false };

PARAMS_1(_target);
private["_logistic_stack"];
private["_vehicle_class","_max_height","_max_length","_max_width","_load_point_offset","_load_point","_nearObjects","_object"];
_vehicle_class = typeOf _target;
_max_width = getNumber(missionConfigFile >> "logistics" >> "vehicles" >> _vehicle_class >> "max_width");
_max_length = getNumber(missionConfigFile >> "logistics" >> "vehicles" >> _vehicle_class >> "max_length");
_max_height = getNumber(missionConfigFile >> "logistics" >> "vehicles" >> _vehicle_class >> "max_height");
_load_point_offset = getArray(missionConfigFile >> "logistics" >> "vehicles" >> _vehicle_class >> "load_point");

If (!(_max_width>0)) exitWith {false};

_load_point = _target modelToWorld _load_point_offset;
_nearObjects = nearestObjects[_load_point, ["AllVehicles","ThingX"], 3];
private "_cargo_class";
_cargo_class = "";
{
	private "_temp";
	_temp = [typeOf _x] call FM(log_getCargoCfg); 
	If (!(_temp isEqualTo "")) exitWith {
		_cargo_class = _temp;
	};
}forEach _nearObjects;

CHECK(_cargo_class isEqualTo "")


private["_cargo_width","_cargo_length","_cargo_height","_left_length"];
if (_cargo_class isEqualTo "") exitWith {};

_cargo_width = getNumber(missionConfigFile >> "logistics" >> "cargos" >> _cargo_class >> "width");
_cargo_length = getNumber(missionConfigFile >> "logistics" >> "cargos" >> _cargo_class >> "length");
_cargo_height = getNumber(missionConfigFile >> "logistics" >> "cargos" >> _cargo_class >> "height");


_logistic_stack = _target getVariable ["LOGISTIC_CARGO_STACK",[]];

If (_logistic_stack isEqualTo []) exitWith {
	((_cargo_height < _max_height)&&(_cargo_width < _max_width)&&(_cargo_length<_max_length))
};
_left_length = ((_logistic_stack select ((count _logistic_stack)-1))select 2) - SPACE_BETWEEN_CARGO;

((_cargo_height < _max_height)&&(_cargo_width < _max_width)&&(_cargo_length<_left_length))