/*
 *  Author: Dorbedo
 *
 *  Description:
 *      spawns the hostages
 *
 *  Parameter(s):
 *      0 : ARRAY - centerposition
 *
 *  Returns:
 *      ARRAY - hostages
 *
 */
#include "script_component.hpp"

_this params [["_centerposition",[],[[]]],["_parameter",[]]];
_parameter params [["_amount",3,[0]],["_radius",150,[0]]];

private _targets = [];

for "_i" from 1 to _amount do {
    private _targetPositions = [_centerposition,"hostage"] call FUNC(createMissionHouse);
    private _targetPos = selectRandom _targetPositions;

    private _obj = ["hostage"] call FUNC(getMissionObject);

    private _group = createGroup civilian;
    private _curTarget = _group createUnit [_obj, _targetPos, [], 0, "CAN_COLLIDE"];

    _curTarget setVariable [QEGVAR(mission,ISTARGET),true];
    removeAllAssignedItems _curTarget;
    removeAllWeapons _curTarget;
    removeBackpack _curTarget;
    [_curTarget,true] call ace_captives_fnc_setHandcuffed;

    If !(isNil QEFUNC(headquarter,registerPOI)) then {
        [_curTarget] call EFUNC(headquarter,registerPOI);
    };
    _targets pushBack _curTarget;
};

_targets;
