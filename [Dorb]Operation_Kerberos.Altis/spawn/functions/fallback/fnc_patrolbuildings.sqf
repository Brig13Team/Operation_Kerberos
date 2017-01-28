/*
    Author: Dorbedo

    Description:
        Makes Group patrol nearest building


    Parameter(s):
        0 : GROUP    - Group
        1 : ARRAY    - Position

    Return
    BOOL - Patrol is called
*/
#include "script_component.hpp"
_this params[["_gruppe",grpNull,[grpNull]],["_position",[],[[]],[3]]];
if ((isNull _gruppe)||(_position isEqualTo [])) exitWith {false};

private _nearestBuilding = nearestBuilding _position;
if ((isNil "_nearestBuilding")||{(isNull _nearestBuilding)}) exitWith {false};

private _allBuildingPos = [_nearestBuilding] call BIS_fnc_buildingPositions;
If ((count _allBuildingPos)<2) exitWith {false};
private _allBuildingPos = _allBuildingPos call BIS_fnc_arrayShuffle;

private _wp_count = (floor(random(count _allBuildingPos))) max 2;

private _positions_ids = [];
for "_i" from 0 to (_wp_count -1) do {
    private _pos_id = 0;
    for "_j" from 0 to 10 do {
        _pos_id = (floor(random(count _allBuildingPos)));
        If (!(_pos_id in _positions_ids)) exitWith {};
    };
    private _newPos = _allBuildingPos select _i;
    private _wp = _gruppe addWaypoint [_newPos, _i];
    _wp setWaypointType "MOVE";
    _wp waypointAttachObject _nearestBuilding;
    _wp setWaypointHousePosition _pos_id;
    _wp setWaypointSpeed "LIMITED";
    _wp setWaypointTimeout [10,15,20];
    _wp setWaypointCombatMode "WHITE";
};

private _wp = _gruppe addWaypoint [_position, 0];
_wp waypointAttachObject _nearestBuilding;
_wp setWaypointType "CYCLE";

true
