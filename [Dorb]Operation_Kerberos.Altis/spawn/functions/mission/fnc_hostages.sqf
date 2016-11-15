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

_this params [["_centerposition",[],[[]]],["_amount",1,[0]]];

private _targets = [];

for "_i" from 0 to _amount do {
    private _targetPositions = [_centerposition] call FUNC(createMissionHouse);
    private _targetPos = selectRandom _targetPositions;

    private _allobjects = getArray(missionConfigFile >> "missions_config" >> "main" >> "hostage" >> "hostages");
    private _obj = selectRandom _allobjects;

    private _group = createGroup civilian;
    private _curTarget = _group createUnit [_obj, _targetPos, [], 0, "CAN_COLLIDE"];

    _curTarget setVariable [QEGVAR(mission,ISTARGET),true];
    _curTarget setVariable [QEGVAR(mission,ISHOSTAGE),true];
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
