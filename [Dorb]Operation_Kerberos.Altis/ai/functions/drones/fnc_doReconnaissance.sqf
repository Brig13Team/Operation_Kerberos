/*
	Author: iJesuz
	
	Description:
	
	Parameter(s):
		0 : OBJECT - drone
		1 : ARRAY/OBJECT - position or target object

	Retruns:
		FALSE - on fail
		ARRAY - if scan is done
	
*/
#include "script_component.hpp"
SCRIPT(doReconnaissance);

params [["_drone",objNull,[objNull]],"_target"];
private ["_scan_radius","_pos","_wp_type","_dir","_height","_posBegin","_radius"];

if (isNull _drone) exitWith { false };
if (!isNumber(missionConfigFile >> "drones" >> typeOf _drone >> "scan_radius")) exitWith { false };
_scan_radius = getNumber(missionConfigFile >> "drones" >> typeOf _drone >> "scan_radius");
_wp_type = getText (missionConfigFile >> "drones" >> typeOf _drone >> "scan_waypoint");
if (_wp_type == "LOITER") then {
	_radius = getNumber (missionConfigFile >> "drones" >> typeOf _drone >> "waypoints" >> _wp_type >> _radius);
} else {
	_radius = 0;
};

if (typeName _target == "OBJECT") then { _pos = getPos _target; };
if ((typeName _target == "ARRAY") && {count _target == 3}) then { _pos = _target; };

_dir = random 360;
_height = getNumber (missionConfigFile >> "drones" >> typeOf _drone >> "waypoints" >> _wp_type >> "height");
_posBegin = [(_pos select 0) - ((sin _dir) * 1000), (_pos select 1) - ((cos _dir) * 5000), _height];

_drone setPos _posBegin;
_drone setDir (_dir + 180);
if (!([_drone,_wp_type,_pos] call FUNC(drones_createWaypoint))) exitWith { false };

while { ((_drone distance2D _pos) >= (_radius + 50)) } do { uiSleep 1; };

if (isNull _drone) exitWith { false };
uiSleep 30;
if (isNull _drone) exitWith { false };
_ret = [_drone,_pos] call FUNC(drones_scan);

_ret
