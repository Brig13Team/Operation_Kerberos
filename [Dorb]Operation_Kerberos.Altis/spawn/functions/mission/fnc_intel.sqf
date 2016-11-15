/*
 *  Author: Dorbedo
 *
 *  Description:
 *      spawns the intel
 *
 *  Parameter(s):
 *      0 : ARRAY - centerposition
 *
 *  Returns:
 *      ARRAY - intel-objects
 *
 */
#include "script_component.hpp"

_this params [["_centerposition",[],[[]]]];

/*
 *  Create the target
 */

private _targetPositions = [_centerposition] calll FUNC(mission__missionhouse);
private _targetPos = selectRandom _targetPositions;

private _allobjects = getArray(missionConfigFile >> "missions_config" >> "main" >> "intel" >> "objects");
private _obj = selectRandom _allobjects;

private _curTarget = createVehicle [_obj, _targetPos,[], 0, "CAN_COLLIDE"];

If !(isNil QEFUNC(headquarter,registerPOI)) then {
    [_targetPos] call EFUNC(headquarter,registerPOI);
};

_curTarget;
