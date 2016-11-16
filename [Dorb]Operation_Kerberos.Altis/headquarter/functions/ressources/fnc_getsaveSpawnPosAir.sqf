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
#include "script_component.hpp"

_this params ["_targetPos",["_mindistance",3000,[0]],["_mindistancePlayer",3000,[0]],["_maxdistance",5000,[0]]];
_maxdistance = _mindistance max _maxdistance;

private _max_run = 3000;
private _generate = true;

while {_generate && (_max_run>0)} do {
    _spawnPos = [_pos,_maxdistance,0] call EFUNC(common,pos_random);
    If (
            ((_spawnPos distance2D _targetPos)>_mindistance)&&
            (({(_x distance2D _targetPos)<_mindistancePlayer} count allPlayers)<1)
        ) then {
            _generate=false;
    };
    DEC(_max_run);
};

_spawnpos;
