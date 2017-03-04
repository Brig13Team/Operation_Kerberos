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
_parameter params [["_amount",3,[0]],["_radius",200,[0]]];
TRACEV_4(_centerposition,_parameter,_radius,_amount);
private _targets = [];

private _targetPositions = [_centerposition,"hostage",_amount] call FUNC(createMissionHouse);

for "_i" from 1 to _amount do {
    private _targetPos = selectRandom _targetPositions;

    private _obj = ["hostage"] call FUNC(getMissionObject);
    private _spawnPos =+ _targetPos;
    _spawnPos resize 3;
    private _group = createGroup civilian;
    private _curTarget = _group createUnit [_obj, _spawnPos, [], 0, "CAN_COLLIDE"];
    _curTarget setPosASL _spawnPos;
    private _spawnDir = random (360);
    _curTarget setDir _spawnDir;


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
