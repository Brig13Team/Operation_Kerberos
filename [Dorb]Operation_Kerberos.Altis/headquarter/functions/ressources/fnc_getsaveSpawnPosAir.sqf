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

_this params ["_targetPos",["_mindistance",3000,[0]],["_mindistancePlayer",3000,[0]],["_maxdistance",5000,[0]]];
TRACEV_4(_targetPos,_mindistance,_mindistancePlayer,_maxdistance);
_maxdistance = _mindistance max _maxdistance;

private _max_run = 3000;
private _generate = true;
private "_spawnPos";
while {_generate && (_max_run>0)} do {
    _spawnPos = [_targetPos,_maxdistance,0] call EFUNC(common,pos_random);
    If (
            ((_spawnPos distance2D _targetPos)>_mindistance)&&
            ((({(_x distance2D _targetPos)<_mindistancePlayer} count allPlayers)==0))&&
            ((({(_x distance2D _targetPos)<_mindistancePlayer} count (allUnitsUAV select {side _x == GVARMAIN(playerside)}))==0))&&
            ((({(_x distance2D _targetPos)<4000} count [getmarkerpos GVARMAIN(RESPAWNMARKER),getmarkerpos GVARMAIN(AIRFIELD)])==0))
        ) then {
            _generate=false;
    };
    DEC(_max_run);
};
TRACEV_2(_spawnpos,_max_run);
_spawnpos;
