/*
	Author: Dorbedo
	
	Description:
		Makes Group patrol nearest building
	
	
	Parameter(s):
		0 : GROUP	- Group
		1 : ARRAY	- Position
	
	Return
	BOOL - Patrol is called
*/
#include "script_component.hpp"

params[["_gruppe",grpNull,[grpNull]],["_position",[],[[]],[3]]];
if ((isNull _gruppe)||(_position isEqualTo [])) exitWith {false};

_nearestBuilding = nearestBuilding _position;
if ((isNil "_nearestBuilding")||{(isNull _nearestBuilding)}) exitWith {false};

_allBuildingPos = [_nearestBuilding] call BIS_fnc_buildingPositions;
If ((count _allBuildingPos)<2) exitWith {false};
_allBuildingPos = _allBuildingPos call BIS_fnc_arrayShuffle;

_wp_count = (floor(random(count _allBuildingPos))) max 2;

_positions_ids = [];
for "_i" from 0 to (_wp_count -1) do {
	_pos_id = 0;
	for "_j" from 0 to 10 do {
		_pos_id = (floor(random(count _allBuildingPos)));
		If (!(_pos_id in _positions_ids)) exitWith {};
	};
	_newPos = _allBuildingPos select _i;
	_wp = _gruppe addWaypoint [_newPos, _i];
	_wp setWaypointType "MOVE";
	_wp waypointAttachObject _nearestBuilding;
	_wp setWaypointHousePosition _pos_id;
	_wp setWaypointSpeed "LIMITED";
	_wp setWaypointTimeout [10,15,20];
};

private ["_wp"];
_wp = _gruppe addWaypoint [_position, 0];
_wp waypointAttachObject _nearestBuilding;
_wp setWaypointType "CYCLE";

true
