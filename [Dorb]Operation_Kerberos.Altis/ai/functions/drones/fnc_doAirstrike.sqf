/*
	Author: iJesuz
	
	Description:
	
	Parameter(s):
		0 : ARRAY/OBJECT - position or target object
	
*/
#include "script_component.hpp"
SCRIPT(doAirstrike);

params [["_target",objNull,[objNull,[]]]];
private ["_adrones","_drone","_ret","_dir","_pos","_posBegin","_posEnd","_height","_pos","_onExit","_logic"];

_onExit = {
	private ["_adrones"];
	_adrones = GETVAR(missionNamespace,GVAR(availableAttackDrones),[]);
	_adrones pushback (typeOf _this);
	SETVAR(missionNamespace,GVAR(availableAttackDrones),_adrones);
	deleteVehicle _this;
};

_adrones = GETVAR(missionNamespace,GVAR(availableAttackDrones),[]);
if (count _adrones == 0) exitWith { false };
_drone = _adrones select (count _adrones - 1);
_adrones resize (count _adrones - 1);
SETVAR(missionNamespace,GVAR(availableAttackDrones),_adrones);

_drone = createVehicle [_drone,[0,0,2000],[],0,"FLY"];
createVehicleCrew _drone;

if (!isText(missionConfigFile >> "drones" >> typeOf _drone >> "muzzle")) exitWith { _drone call _onExit; false };
_wp_type = getText (missionConfigFile >> "drones" >> typeOf _drone >> "attack_waypoint");

_dir = random 360;

if (typeName _target == "OBJECT") then { _pos = getPos _target; } else { _pos = _target; };
if ((typeName _target == "ARRAY") || (_target isKindOf "Man")) then {
	_logic = "Logic" createVehicleLocal _pos;
	if (typeName _target == "ARRAY") then {
		_logic setPos _pos;
	} else {
		_logic attachTo [_target];
	};
	_target = _logic;
};

if (isNil "_pos") exitWith { _drone call _onExit; false };

_height = getNumber (missionConfigFile >> "drones" >> typeOf _drone >> "waypoints" >> _wp_type >> "height");
_posBegin = [(_pos select 0) - ((sin _dir) * 5000), (_pos select 1) - ((cos _dir) * 5000), _height];
_posEnd = [(_pos select 0) + ((sin _dir) * 5000), (_pos select 1) + ((cos _dir) * 5000), _height];

_drone setPos _posBegin;
_drone setDir _dir;
if (!([_drone,_wp_type,_pos] call FUNC(drones_createWaypoint))) exitWith { _drone call _onExit; false };

while { (_drone distance2D _pos) >= 500 } do { uiSleep 1; };

if (isNull _drone) exitWith { _drone call _onExit; false };

if ((_target distance2D _pos) < 500) then {
	_ret = [_drone,_target] call FUNC(drones_attack);
} else {
	_ret = false;
};
if (!([_drone,_wp_type,_posEnd] call FUNC(drones_createWaypoint))) exitWith { _drone call _onExit; false };

while { (_drone distance2D _posEnd) >= 500 } do { uiSleep 1; };

if (typeOf _target == "Logic") then { deleteVehicle _target; };
if (getDammage _drone != 1) then { _drone call _onExit; };

_ret
