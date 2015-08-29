/*
	Author: iJesuz, Dorbedo

	Description:
		logistic script

	Parameter(s):
		0: OBJECT - vehicle
*/
#include "script_component.hpp"
SCRIPT(unload);

#define SPACE_BETWEEN_CARGO 0.1

params ["_vehicle"];

private ["_vehicle_class","_logistic_stack"];

_vehicle_class = typeOf _vehicle;
_logistic_stack = _vehicle getVariable [QGVAR(stack),[]];

if (!isClass(missionConfigFile >> "logistics" >> "vehicles" >> _vehicle_class)) exitWith {
	["unsupported vehicle",["unsupported vehicle"],"",false] call EFUNC(interface,disp_info);
};
if (_logistic_stack isEqualTo []) exitWith {
	["vehicle is empty",["vehicle is empty"],"",false] call EFUNC(interface,disp_info);
};

private ["_last_row","_last_cargo","_cargo_mass","_vehicle_mass","_load_point","_detach_point","_cargo_width","_cargo_length","_detach_point","_position","_height"];

_last_row = _logistic_stack select ((count _logistic_stack) - 1);
_last_cargo = _last_row select ((count _last_row) - 1);
_last_row resize (count _last_row - 1);

if (_last_row isEqualTo []) then { _logistic_stack resize ((count _logistic_stack) - 1); } else { _logistic_stack set [(count _logistic_stack) - 1, _last_row]; };

if (!((_last_cargo select 0) in (attachedObjects _vehicle))) exitWith {
	_cargo_mass = getMass (_last_cargo select 0);
	_vehicle setVariable [QGVAR(stack),_logistic_stack];
	_vehicle setMass (_vehicle_mass - _cargo_mass);
};

_load_point = getArray(missionConfigFile >> "logistics" >> "vehicles" >> _vehicle_class >> "load_point");
_cargo_width = _last_cargo select 1 select 0;
_cargo_length = _last_cargo select 1 select 1;
_cargo_height = _last_cargo select 1 select 2;
_detach_point = [_load_point select 0, (_load_point select 1) - (_cargo_length / 2), _load_point select 2];

detach (_last_cargo select 0);
_cargo_mass = getMass (_last_cargo select 0);
_vehicle_mass = getMass _vehicle;
(_last_cargo select 0) setPos (_vehicle modelToWorld _detach_point);
(_last_cargo select 0) setDir (getDir _vehicle);

SETVAR(player,GVAR(isloading),false);
if ([_vehicle] call FUNC(candrop)) then {
	[(_last_cargo select 0),_vehicle] spawn {
		SCRIPTIN(unload,paradrop);
		params["_cargo","_vehicle"];
		private ["_time","_para","_velocity"];
		_time = diag_ticktime;
		waitUntil{(((getPos _cargo)select 2)<10)||((_cargo distance _vehicle)>35)||(diag_ticktime>(_time + 20))};
		CHECK((((getPos _cargo)select 2)<10)||(diag_ticktime>(_time + 20)))
		private "_para";
		_para = createVehicle ["B_Parachute_02_F",(getPos _cargo),[],0,"FLY"];
		_para setDir (getDir _cargo);
		_para setPos (getPos _cargo);
		_cargo attachTo [_para,[0,0,0]];
		_velocity = velocity _cargo;
		detach _para;
		_para setVelocity _velocity;
		_cargo attachTo [_para, [0,0,0]];
		_time = diag_ticktime;
		waitUntil{((((getPos _cargo)select 2)<2)||(diag_ticktime>(_time + 600)))};
		deleteVehicle _para;
	};
};

_vehicle setVariable [QGVAR(stack),_logistic_stack];
_vehicle setMass (_vehicle_mass - _cargo_mass);

private["_aceActions"];
_aceActions = (_last_cargo select 0) getVariable [QGVAR(aceactions),[]];
If(_aceActions isEqualTo []) exitWith {};
If (_aceActions select 0) then {
	(_last_cargo select 0) setVariable ["ACE_dragging_canDrag",true,true];
};
If (_aceActions select 1) then {
	(_last_cargo select 0) setVariable ["ACE_dragging_canCarry",true,true];
};