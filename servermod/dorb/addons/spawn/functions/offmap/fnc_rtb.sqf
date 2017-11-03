/**
 * Author: Dorbedo
 * return aircraft out of sight
 *
 * Arguments:
 * 0: <OBJECT> the vehicle to be returned offmap
 *
 * Return Value:
 * Nothing
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params [["_vehicle",objNull,[objNull]]];

If (isNull _vehicle) exitWith {};

private _position = selectRandom [[0, random worldSize, 0], [random worldSize, 0, 0], [worldSize, random worldSize, 0], [random worldSize, worldSize, 0]];

private _group = [_vehicle] call CBA_fnc_getGroup;

If (isNull _group) exitWith {};

If !(isGroupDeletedWhenEmpty _group) then {_group deleteGroupWhenEmpty true;};

[_group] call CBA_fnc_clearWaypoints;
_transportVehicle doMove _position;
[
    _group,
    _position,
    200,
    "MOVE",
    "CARELESS",
    "WHITE",
    "FULL"
] call CBA_fnc_addWaypoint;

//_vehicle flyInHeight 600;

[
    {((_this select 0) distance2D (_this select 1))<500},
    {[_this select 1,_this select 2] call EFUNC(common,delete);},
    [_position, _vehicle, group (driver _vehicle)],
    (10*60),
    {[_this select 1,_this select 2] call EFUNC(common,delete);}
] call CBA_fnc_waitUntilAndExecute;
