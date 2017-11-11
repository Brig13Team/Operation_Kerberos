/**
 * Author: Dorbedo
 * returns a save spawn position
 *
 * Arguments:
 * 0: <ARRAY> the target position
 * 1: <SCALAR> min distance
 * 2: <SCALAR> mix distance to player
 * 3: <SCALAR> max distance
 *
 * Return Value:
 * <ARRAY> the position
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

params ["_targetPos", ["_mindistance", 8000, [0]], ["_mindistancePlayer", 5000, [0]], ["_maxdistance", 15000, [0]]];

private _posBlacklist = ([GVARMAIN(side)] call BIS_fnc_getRespawnMarkers) apply {getMarkerPos _x};
_posBlacklist = _posBlacklist select {((_x distance2D [0,0,0])>10)};

private _errorcounter = 1000; //
private _spawnpos = [];

while {(_errorcounter > 0)} do {
    private _tempPos = _targetPos getPos [(random(_maxdistance - _mindistance)) + _mindistance,random 360];
    If ((
            ({(_x distance2D _tempPos)<_mindistance} count _posBlacklist)
            + ({(_x distance2D _tempPos)<_mindistancePlayer} count (([] call CBA_fnc_players) + (allUnitsUAV select {side _x == GVARMAIN(playerside)})))
        )>0) then {
        DEC(_errorcounter);
    }else{
        _spawnpos = _tempPos;
        _errorcounter = -1;
    };
};

if !(_spawnpos isEqualTo []) exitWith {_spawnpos};

_targetPos getPos [_maxdistance, random 360];
