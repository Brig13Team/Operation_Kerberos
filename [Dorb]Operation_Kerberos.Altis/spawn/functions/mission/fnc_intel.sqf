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

private _targetPositions = [_centerposition] call FUNC(createMissionHouse);
private _targetPos = selectRandom _targetPositions;
TRACEV_2(_targetPos,_targetPositions);

private _obj = ["intel"] call FUNC(getMissionObject);

TRACEV_2(_centerpos,_obj);
private _curTarget = createVehicle [_obj, _targetPos,[], 0, "CAN_COLLIDE"];

If !(isNil QEFUNC(headquarter,registerPOI)) then {
    [_curTarget] call EFUNC(headquarter,registerPOI);
};

#ifdef DEBUG_MODE_FULL
    [(getPos _curTarget),"Intel","ColorBlack","hd_destroy"] call EFUNC(common,debug_marker_create);
#endif

TRACEV_2(_targetPos,_curTarget);
[_curTarget];
