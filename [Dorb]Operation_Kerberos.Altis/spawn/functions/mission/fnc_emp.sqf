/*
 *  Author: Dorbedo
 *
 *  Description:
 *      spawns the emp
 *
 *  Parameter(s):
 *      0 : ARRAY - centerposition
 *
 *  Returns:
 *      ARRAY - intel-objects
 *
 */
#include "script_component.hpp"

_this params [["_centerposition",[],[[]]],["_parameter",[]]];
_parameter params [["_radius",300,[0]]];

private _targetPositions = [_centerposition,"emp",1,_radius] call FUNC(createMissionComposition);
private _targetPos = selectRandom _targetPositions;

private _obj = ["emp"] call FUNC(getMissionObj);

private _curTarget = createVehicle [_obj, _targetPos,[], 0, "CAN_COLLIDE"];

If !(isNil QEFUNC(headquarter,registerPOI)) then {
    [_curTarget] call EFUNC(headquarter,registerPOI);
};

_curTarget;
