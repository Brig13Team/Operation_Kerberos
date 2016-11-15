/*
 *  Author: Dorbedo
 *
 *  Description:
 *      spawns the kill-targets
 *
 *  Parameter(s):
 *      0 : ARRAY - centerposition
 *
 *  Returns:
 *      ARRAY - targets
 *
 */
#include "script_component.hpp"

_this params [["_centerposition",[],[[]]],["_amount",1,[0]]];

private _targets = [];

for "_i" from 0 to _amount do {
    private _targetPositions = [_centerposition] call FUNC(createMissionHouse);
    private _targetPos = selectRandom _targetPositions;

    private _allobjects = getArray(missionConfigFile >> "missions_config" >> "main" >> "kill" >> "units");
    private _obj = selectRandom _allobjects;

    private _group = createGroup GVARMAIN(side);
    private _curTarget = _group createUnit [_obj, _targetPos, [], 0, "CAN_COLLIDE"];

    _curTarget allowFleeing 0;
    if (isnil (primaryWeapon _curTarget)) then {
        _curTarget addMagazine ["150Rnd_762x51_Box_Tracer",4];
        _curTarget addWeapon "LMG_Zafir_F";
        _curTarget selectWeapon "LMG_Zafir_F";
    };

    If !(isNil QEFUNC(headquarter,registerPOI)) then {
        [_curTarget] call EFUNC(headquarter,registerPOI);
    };
    _targets pushBack _curTarget;
};

_targets;
