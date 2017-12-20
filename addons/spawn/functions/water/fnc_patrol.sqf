/*
 *  Author: Dorbedo
 *
 *  Description:
 *      Patrols a water area
 *
 *  Parameter(s):
 *      0 : GROUP - group
 *      1 : ARRAY - startposition
 *      2 : SCALAR - maximum distance
 *      3 : SCALAR - depth
 *
 *  Returns:
 *      none
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

#define WP_BEHAVIOR "RED"
#define WP_COMPRAD 40
#define WP_FORMATION "STAG COLUMN"
#define WP_SPEED "LIMITED"
#define WP_TYPE "MOVE"

_this params["_grp","_pos","_maxDist",["_depth",0,[0]]];
_grp setBehaviour WP_BEHAVIOR;

private _prevPos = _pos;
for "_i" from 0 to (2 + (floor (random 3))) do
{
    private _newPos = [_prevPos,_maxDist,3] call EFUNC(common,random_pos);
    private _bestpos = (selectBestPlaces [_newPos, 15, "waterdepth", 2, 5]);
    _newPos = (_bestpos select 0) select 0;
    _newPos set [2,_depth];

    #ifdef DEBUG_MODE_FULL
        [_spawnpos,"","ColorBlue","hd_dot"] call EFUNC(common,debug_marker_create);
    #endif

    _prevPos = _newPos;
    private _wp = _grp addWaypoint [_newPos, 0];
    _wp setWaypointType WP_TYPE;
    _wp setWaypointCompletionRadius WP_COMPRAD;

    if (_i == 0) then {
        _wp setWaypointSpeed WP_SPEED;
        _wp setWaypointFormation WP_FORMATION;
    };
};

private _wp = _grp addWaypoint [_pos, 0];
private _wp setWaypointType "CYCLE";
private _wp setWaypointCompletionRadius 20;
