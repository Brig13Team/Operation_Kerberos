/*
	Author: iJesuz
	
	Description:
	
	Parameter(s):
		0 : OBJECT - drone
		1 : ARRAY/OBJECT - position or target object
	
*/
#include "script_component.hpp"
SCRIPT(doAirstrike);

params [["_drone",objNull,[objNull]],"_target"];
private ["_ret","_dir","_pos","_posBegin","_posEnd","_height","_pos"];

if (!isText(missionConfigFile >> "drones" >> typeOf _drone >> "muzzle")) exitWith { false };
_wp_type = getText (missionConfigFile >> "drones" >> typeOf _drone >> "attack_waypoint");

_dir = random 360;

if (typeName _target == "OBJECT") then { _pos = getPos _target; };
if ((typeName _target == "ARRAY") && {count _target == 3}) then {
	private ["_logic"];
	_logic = "Logic" createVehicleLocal _target;
	_pos = getPos _logic;
	_target = _logic;
};
if (isNil "_pos") exitWith { false };

_height = getNumber (missionConfigFile >> "drones" >> typeOf _drone >> "waypoints" >> "MOVE" >> "height");
_posBegin = [(_pos select 0) - ((sin _dir) * 5000), (_pos select 1) - ((cos _dir) * 5000), _height];
_posEnd = [(_pos select 0) + ((sin _dir) * 5000), (_pos select 1) + ((cos _dir) * 5000), _height];

_drone setPos _posBegin;
_drone setDir (_dir + 180);
if (!([_drone,"MOVE",_posEnd] call FUNC(drones_createWaypoint))) exitWith { false };
_drone lockCameraTo [_target,[0]];

// waitUntil { (_drone distance _target <= 500) || (_drone distance _posEnd <= 100) };

while { ((_drone distance2D _pos) >= 500) || ((_drone distance2D _pos) <= 100) } do { uiSleep 1; };

if (_drone distance2D _posEnd <= 100) exitWith { false };
if (_pos distance2D _target <= 300) then {
	_ret = [_drone,_target] call FUNC(drones_attack);
} else {
	_ret = false;
};

if (typeOf _target == "Logic") then { deleteVehicle _target; };

_ret
