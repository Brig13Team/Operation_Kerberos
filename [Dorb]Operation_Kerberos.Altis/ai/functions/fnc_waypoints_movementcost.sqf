/*
	Author: Dorbedo
	
	Description:
		generates waypoints
	
	Parameter(s):
		none

	Returns:
		none
*/
#include "script_component.hpp"
SCRIPT(waypoints_generate);

#define ROADDECRESE 50
#define DISTANCE_BETWEEN 50

_this params[
	["_start",[],[[]]],
	["_target",[],[[]]]
	];
private ["_points","_distance","_value"];
_points = [];

_distance = _start distance2D _target;

_start = ATLtoASL [_start select 0,_start select 1,0];
_target = ATLtoASL [_target select 0,_target select 1,0];

_anzahl = floor((_start distance2D _target)/DISTANCE_BETWEEN) max 1;

for "_i" from 0 to (_anzahl - 1) do {
	_points pushBack ([_start,_target,DISTANCE_BETWEEN] call EFUNC(common,pointBetween));
};
_points pushBack _target;

_value = 0;
_lastHight = _start select 2;
{
	if (surfaceIsWater _x) then {
		_value = 50;
	}else{
		_value = abs(_lastHight - (_x select 2));
		_lastHight = (_x select 2);
	};
} forEach _points;

If ((isOnRoad _start)&&(isOnRoad _target)) exitWith {
	(floor(_distance/10) +  floor(_value/10) - ROADDECRESE)
};

(floor(_distance/10) + floor(_value/10))








