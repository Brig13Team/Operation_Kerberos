/*
 *  Author: Dorbedo
 *
 *  Description:
 *      spawns the device
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

private _targetPositions = [_centerposition,"device"] call FUNC(createMissionComposition);
private _targetPos = selectRandom _targetPositions;

private _obj = getArray(missionConfigFile >> "missions_config" >> "main" >> "device" >> "object");

private _curTarget = createVehicle [_obj, _targetPos,[], 0, "CAN_COLLIDE"];

If !(isNil QEFUNC(headquarter,registerPOI)) then {
    [_curTarget] call EFUNC(headquarter,registerPOI);
};

_curTarget;
