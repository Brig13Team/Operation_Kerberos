/*
 *  Author: Dorbedo
 *
 *  Description:
 *      returns a good airspawn position
 *
 *  Parameter(s):
 *      0 : ARRAY - TargetPos
 *
 *  Returns:
 *      ARRAY - save spawnpos
 *
 */
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

_this params ["_targetPos",["_mindistance",5000,[0]],["_mindistancePlayer",5000,[0]],["_maxdistance",12000,[0]]];

private _positionBlacklist = [getMarkerPos GVARMAIN(respawnmarker),HASH_GET_DEF(GVAR(dangerzones),"centerpos",getMarkerPos GVARMAIN(respawnmarker)),getMarkerPos "respawn_west_land"] + ((allUnits select {side _x == GVARMAIN(playerside)}) apply {getPos _x});
private _errorcounter = 1000; //
private _spawnpos = [];

while {(_errorcounter > 0)} do {
    private _tempPos = _targetPos getPos [(random(_maxdistance - _mindistance)) + _mindistance,random 360];
    If ((
            ({(_x distance2D _tempPos)<_mindistance} count [getMarkerPos GVARMAIN(respawnmarker),HASH_GET_DEF(GVAR(dangerzones),"centerpos",getMarkerPos GVARMAIN(respawnmarker))])
            + ({(_x distance2D _tempPos)<_mindistancePlayer} count (([] call CBA_fnc_players) + (allUnitsUAV select {side _x == GVARMAIN(playerside)})))
        )>0) then {
        DEC(_errorcounter);
    }else{
        _spawnpos = _tempPos;
        _errorcounter = -1;
    };
};

if !(_spawnpos isEqualTo []) exitWith {_spawnpos};

[_targetPos,_maxdistance,0] call EFUNC(common,pos_random);
