/*
 *  Author: Dorbedo
 *
 *  Description:
 *      returns a spawnposition with a distance big enaugh to players/playerunits
 *
 *  Parameter(s):
 *      0 : ARRAY - TargetPos
 *
 *  Returns:
 *      ARRAY - save spawnpos
 *
 */
#include "script_component.hpp"
#define MIN_DISTANCE 4000
#define MAX_DISTANCE 9000

_this params [["_targetPos",[],[[]]]];

private _positionBlacklist = [getMarkerPos GVARMAIN(respawnmarker),HASH_GET_DEF(GVAR(dangerzones),"centerpos",getMarkerPos GVARMAIN(respawnmarker))] + ((allUnits select {side _x == GVARMAIN(playerside)}) apply {getPos _x});
private _errorcounter = 1000; //
private _spawnpos = [];

while {(_errorcounter > 0)} do {
    private _tempPos = _targetPos getPos [(random(MAX_DISTANCE - MIN_DISTANCE)) + MIN_DISTANCE,random 360];
    private _roads = _tempPos nearRoads 200;
    If !(_roads isEqualTo []) then {
        _tempPos = getPos (selectRandom _roads);
        If (({(_x distance2D _tempPos)<MIN_DISTANCE} count _positionBlacklist)>0) then {
            DEC(_errorcounter);
        }else{
            _spawnpos = _tempPos;
            _errorcounter = -1;
        };
    };
};

if !(_spawnpos isEqualTo []) exitWith {_spawnpos};

// fallback
[_targetPos,MAX_DISTANCE,0] call EFUNC(common,pos_random);
