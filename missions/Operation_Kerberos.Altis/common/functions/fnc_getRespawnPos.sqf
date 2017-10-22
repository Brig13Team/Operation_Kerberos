/**
 * Author: Dorbedo
 * returns the positions of the respawns
 *
 * Arguments:
 * 0: <SIDE> the side
 *
 * Return Value:
 * <ARRAY> array with positions
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params [["_side",sideUnknown,[sideUnknown]]];

if !(_side in [east, west, resistance, civilian]) exitWith {[]};

private _marker = format["respawn_%1",_side];

private _respawnMarker = allMapMarkers select compile format ["_x select [0, %1] == '%2'", count _marker, _marker];

_respawnMarker apply {getMarkerPos _x};

