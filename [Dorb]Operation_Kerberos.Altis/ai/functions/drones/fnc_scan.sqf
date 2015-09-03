/*
	Author: iJesuz
	
	Description:
	
	Parameter(s):
		0 : OBJECT - drone
		1 : ARRAY - position (optiomal)
	
*/
#include "script_component.hpp"
SCRIPT(scan);

params [["_drone",objNull,[objNull]],["_position",[],[[]]]];
private ["_radius","_objects","_ret"];

if (isNull _drone) exitWith { [] };
if (count waypoints _drone <= 0) exitWith { [] };
if (!isNumber (missionConfigFile >> "drones" >> typeOf _drone >> "scan_radius")) exitWith { [] };

if (_pos isEqualTo []) then {
	_position = waypointposition (waypoints _drone select 0);
};
_radius = getNumber (missionConfigFile >> "drones" >> typeOf _drone >> "scan_radius");

_ret = [];
_objects = nearestObjects [_position, ["Car","Tank","Man"], _radius];

{
	if ((side _x != EGVAR(main,playerside)) && (side _x != civilian) && !(_x in _ret)) then {
		_ret pushBack _x;
	};
} forEach _objects;

_ret
