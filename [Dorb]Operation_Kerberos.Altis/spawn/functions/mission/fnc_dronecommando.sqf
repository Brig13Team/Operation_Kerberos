/*
 *  Author: Dorbedo
 *
 *  Description:
 *      spawns the dronecommando
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

private _targetPositions = [_centerposition,["dronecommando","isObjective"],1,_radius] call FUNC(createMissionComposition);
private _targetPos = selectRandom (_targetPositions select 0);

private _obj = ["dronecommando"] call FUNC(getMissionObject);

private _curTarget = createVehicle [_obj, _targetPos,[], 0, "CAN_COLLIDE"];

If !(isNil QEFUNC(headquarter,registerPOI)) then {
    [_curTarget] call EFUNC(headquarter,registerPOI);
};

_curTarget;
