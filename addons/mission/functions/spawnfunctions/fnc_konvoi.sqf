/*
 *  Author: Dorbedo
 *
 *  Description:
 *      special spawn for the konvoi mission
 *
 *  Parameter(s):
 *      0 : ARRAY - the target position
 *
 *  Returns:
 *      ARRAY - Array with the convoi Vehicles
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"


_this params ["_centerpos"];

private _spawnpos = [_centerpos,8000,3000,15000] call EFUNC(headquarter,ressources_getsaveSpawnPos);

private _nearRoads = _spawnpos nearRoads 75;

private _konvoiUnits = ["konvoi"] call FUNC(spawn_getObjects);

private _group = createGroup GVARMAIN(side);
// ignore the group by the hq
_group setVariable [QEGVAR(headquarter,state),"mission"];

private _objects = [];

{
    private _curType = _x;
    private _curRoad = _nearRoads deleteAt (floor (random (count _nearRoads)));
    ([getPos _curRoad,_group,_curType,getDir _curRoad,true,true] call EFUNC(spawn,vehicle)) params ["_curgroup","_vehicle"];
    _objects pushBack _vehicle;
} forEach _konvoiUnits;

private _waypoints = [getPos (_objects select 0),_centerpos] call EFUNC(headquarter,waypoints_generate);
[_group, _waypoints, 25, "MOVE", "SAFE", "YELLOW", "NORMAL", "NO CHANGE", _statement, [1,3,5], 150] call FUNC(waypoints_add);


_objects
