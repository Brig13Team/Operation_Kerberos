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

private _targets = [];

for "_i" from 0 to _amount do {
    private _targetPositions = [_centerposition] call FUNC(createMissionHouse);
    private _targetPos = selectRandom _targetPositions;

    private _obj = ["capture"] call FUNC(getMissionObject);

    private _group = createGroup GVARMAIN(side);
    private _curTarget = _group createUnit [_obj, _targetPos, [], 0, "CAN_COLLIDE"];

    _curTarget allowFleeing 0;

    If !(isNil QEFUNC(headquarter,registerPOI)) then {
        [_curTarget] call EFUNC(headquarter,registerPOI);
    };
    _targets pushBack _curTarget;
};

_targets;
