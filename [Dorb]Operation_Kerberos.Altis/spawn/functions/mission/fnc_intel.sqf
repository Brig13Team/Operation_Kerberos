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

_this params [["_centerposition",[],[[]]],["_parameter",[]]];
_parameter params [["_amount",3,[0]]];

private _intelObjects = [];
for "_i" from 0 to _amount do {

    private _targetPositions = [_centerposition,"intel"] call FUNC(createMissionHouse);
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
    _intelObjects pushBack _curTarget;
};
//[_curTarget];
_intelObjects;
