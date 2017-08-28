/**
 * Author: Dorbedo
 * the air-superiority side mission
 *
 * Arguments:
 * 0: <ARRAY> the centerposition
 * 1: <LOCATION> the missionHash
 *
 * Return Value:
 * Nothing
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["_centerpos","_mission"];

private _amount = 2 + (floor (random 3));
private _objects = [];

for "_i" from 0 to _amount do {
    private _spawnPos = [_centerpos,10000,10000,15000] call EFUNC(headquarter,ressources_getsavespawnposair);
    _spawnPos set [2,3000];

    private _plane = ["plane_ai"] call EFUNC(spawn,getUnit);
    private _dir = [_spawnpos, _centerpos] call BIS_fnc_dirTo;
    ([_spawnpos,GVARMAIN(side),_plane,_dir,true,true,"FLY"] call EFUNC(spawn,vehicle)) params ["_attackGroup","_attackVeh"];
    {
        _x setSkill 1;
    } forEach (units _attackGroup);
    _attackGroup setVariable [QGVAR(state),"mission"];

    private _loiterpos = _centerpos getPos [500,random 360];
    _loiterpos set [2,1000 + (random 500)];

    [_attackGroup] call CBA_fnc_clearWaypoints;
    private _wp = _attackGroup addWaypoint [_loiterpos, 0];
    _wp setWaypointType "LOITER";
    _wp setWaypointLoiterType "CIRCLE";
    _wp setWaypointLoiterRadius 1500;
    _wp setWaypointBehaviour "SAD";
    _wp setWaypointCombatMode "RED";

    _objects pushBack _attackVeh;
};
_objects
