/*
	Author: iJesuz
	
	Description:
	
	Parameter(s):
		0 : OBJECT - drone
		1 : STRING - waypoint type
		2 : ARRAY - position
	
*/
#include "script_component.hpp"
SCRIPT(createWaypoint);

private ["_class","_group","_waypoint"];
params [["_drone",objNull,[objNull]],"_type","_position"];

if (isNull _drone) exitWith {
	LOG("drone doesn't exists");
	false
};
_class = typeOf _drone;
_group = group _drone;
if (!isClass(missionConfigFile >> "drones" >> _class >> "waypoints" >> _type)) exitWith { 
	LOG("no config entry");
	false
};

while {(count (waypoints _group)) > 0} do {
	deleteWaypoint ((waypoints _group) select 0);
};

_height = getNumber (missionConfigFile >> "drones" >> _class >> "waypoints" >> _type >> "height");
_waypoint = _group addWaypoint [_position, 0];
_waypoint setWaypointType _type;
switch (_type) do {
	case "LOITER": {
		private ["_ltype","_radius","_height"];
		_ltype = getText (missionConfigFile >> "drones" >> _class >> "waypoints" >> _type >> "type");
		_radius = getNumber (missionConfigFile >> "drones" >> _class >> "waypoints" >> _type >> "radius");
		_waypoint setWaypointLoiterType _ltype;
		_waypoint setWaypointLoiterRadius _radius;
	};
	case "HOLD": {
		private ["_distance","_height","_random","_hposition"];
		_distance = getNumber (missionConfigFile >> "drones" >> _class >> "waypoints" >> _type >> "distance");
		_height = getNumber (missionConfigFile >> "drones" >> _class >> "waypoints" >> _type >> "height");
		_random = random 360;
		_hposition = [(_position select 0) + ((sin _random) * _distance), (_position select 1) + ((cos _random) * _distance),_height];
		_waypoint setWaypointPosition [_hposition,0];
	};
	case "MOVE": {
		private ["_height"];
		_height = getNumber (missionConfigFile >> "drones" >> _class >> "waypoints" >> _type >> "height");
	};
};
_drone flyInHeight _height;
_waypoint setWaypointCombatMode "BLUE";
_drone lockCameraTo [_position,[0]];

true
