/*
 *  Author: Dorbedo
 *
 *  Description:
 *      spawns the weaponcaches
 *
 *  Parameter(s):
 *      0 : ARRAY - centerposition
 *
 *  Returns:
 *      ARRAY - intel-objects
 *
 */

#include "script_component.hpp"

_this params [["_centerposition",[],[[]]],["_amount",1,[0]]];

/*
 *  Create the target
 */
private _wpnCache = [];
for "_i" from 0 to _amount do {

    private _targetPositions = [_centerposition] call FUNC(createMissionHouse);
    private _targetPos = selectRandom _targetPositions;
    TRACEV_2(_targetPos,_targetPositions);

    private _obj = ["weaponcache"] call FUNC(getMissionObject);

    TRACEV_2(_centerpos,_obj);
    private _curTarget = createVehicle [_obj, _targetPos,[], 0, "CAN_COLLIDE"];

    If !(isNil QEFUNC(headquarter,registerPOI)) then {
        [_curTarget] call EFUNC(headquarter,registerPOI);
    };

    #ifdef DEBUG_MODE_FULL
        [(getPos _curTarget),"weaponcache","ColorBlack","hd_destroy"] call EFUNC(common,debug_marker_create);
    #endif

    TRACEV_2(_targetPos,_curTarget);
    _wpnCache pushBack _curTarget;
};
//[_curTarget];
_wpnCache;
