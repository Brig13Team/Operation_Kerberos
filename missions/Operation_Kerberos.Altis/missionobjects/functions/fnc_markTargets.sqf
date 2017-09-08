/*
 *  Author: iJesuz
 *
 *  Description:
 *      create circle around mission targets
 *
 *  Parameter(s):
 *      0 : STRING  - mission name
 *
 *  Returns:
 *      -
 */
#include "script_component.hpp"

_this params [["_parent", "", [""]]];

private _targets = [_parent] call EFUNC(mission,taskmanager_getMissionTargets);

{
    private _pos = _x getPos [random 100, random 360];

    private _marker = createMarker[format["target_marker_%1_%2_%3",_parent,time,_forEachIndex], _pos];
    _marker setMarkerShape "ELLIPSE";
    _marker setMarkerBrush "Border";
    _marker setMarkerColor "ColorRed";
    _marker setMarkerSize [100,100];
    EGVAR(mission,markerDump) pushBack _marker;
} forEach _targets;
