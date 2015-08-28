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
SCRIPT(canload);

#define SPACE_BETWEEN_CARGO 0.1

if (player getVariable [QGVAR(isloading),false]) exitWith { false };

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
	_temp = [_x] call FUNC(getCargoCfg); 
	If (!(_temp isEqualTo "") && {isNull attachedTo _x}) exitWith {
		_cargo_class = _temp;
	};
}forEach _nearObjects;

If (_cargo_class isEqualTo "") exitWith {false};


private["_cargo_width","_cargo_length","_cargo_height","_left_length","_ret","_row_width"];
if (_cargo_class isEqualTo "") exitWith {};

_cargo_width = getNumber(missionConfigFile >> "logistics" >> "cargos" >> _cargo_class >> "width");
_cargo_length = getNumber(missionConfigFile >> "logistics" >> "cargos" >> _cargo_class >> "length");
_cargo_height = getNumber(missionConfigFile >> "logistics" >> "cargos" >> _cargo_class >> "height");

_logistic_stack = _target getVariable [QGVAR(stack),[]];

_ret = if (_logistic_stack isEqualTo []) then {
	if (!(((_max_length < _cargo_length) || (_max_width < _cargo_width)) && ((_max_length < _cargo_width) || (_max_width < _cargo_length)))) exitWith { true };
	false
} else {
	private ["_row_length","_left_length"];

	_last_row = _logistic_stack select ((count _logistic_stack) - 1);
	_last_cargo = _last_row select ((count _last_row) - 1);
	_row_width = 0;
	_row_length = _last_row select 0 select 2;
	_left_length = _row_length + (if ((getDir (_last_cargo select 0)) == (getDir _vehicle)) then { _last_row select 0 select 1 select 1 } else { _last_row select 0 select 1 select 0 });

	{
		_row_width = _row_width + (if ((getDir (_x select 0)) == (getDir _vehicle)) then { _x select 1 select 0 } else { _x select 1 select 1 });
		_row_length = if ((_x select 2) < _row_length) then { _x select 2 } else { _row_length };
	} forEach _last_row;
	_row_width = _row_width + (count _last_row - 1) * SPACE_BETWEEN_CARGO;

	if (((_max_width - _row_width >= _cargo_width + SPACE_BETWEEN_CARGO) && (_left_length >= _cargo_length + SPACE_BETWEEN_CARGO)) || ((_max_width - _row_width >= _cargo_length + SPACE_BETWEEN_CARGO) && (_left_length >= _cargo_width + SPACE_BETWEEN_CARGO))) exitWith { true };
	if (!(((_row_length < _cargo_length + SPACE_BETWEEN_CARGO) || (_max_width < _cargo_width)) && ((_row_length < _cargo_width + SPACE_BETWEEN_CARGO) || (_max_width < _cargo_length)))) exitWith { true };
	false
};

_ret
