/*
 *  Author: Dorbedo
 *
 *  Description:
 *      spawns the capture-targets
 *
 *  Parameter(s):
 *      0 : ARRAY - centerposition
 *
 *  Returns:
 *      ARRAY - targets
 *
 */
#include "script_component.hpp"

_this params [["_centerposition",[],[[]]],["_parameter",[]]];
_parameter params [["_amount",1,[0]]];
TRACEV_3(_centerposition,_parameter,_amount);
private _targets = [];

for "_i" from 1 to _amount do {
    private _targetPositions = ([_centerposition,"capture"] call FUNC(createMissionHouse));
    private _targetPos = selectRandom _targetPositions;
    TRACEV_2(_targetPositions,_targetPos);
    private _obj = ["capture"] call FUNC(getMissionObject);

    private _group = createGroup GVARMAIN(side);
    private _spawnPos =+ _targetPos;
    _spawnPos resize 3;
    private _curTarget = _group createUnit [_obj, _spawnPos, [], 0, "CAN_COLLIDE"];
    _curTarget setPosASL _targetPos;
    private _spawnDir = random (360);
    _curTarget setDir _spawnDir;


    _curTarget allowFleeing 0;

    If !(isNil QEFUNC(headquarter,registerPOI)) then {
        [_curTarget] call EFUNC(headquarter,registerPOI);
    };
    _targets pushBack _curTarget;
};

_targets;
