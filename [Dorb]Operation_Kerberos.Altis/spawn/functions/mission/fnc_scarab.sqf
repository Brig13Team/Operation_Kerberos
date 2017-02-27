/*
 *  Author: Dorbedo
 *
 *  Description:
 *      spawns the scarabs
 *
 *  Parameter(s):
 *      0 : ARRAY - centerposition
 *
 *  Returns:
 *      ARRAY - objects
 *
 */
#include "script_component.hpp"

_this params [["_centerposition",[],[[]]],["_parameter",[]]];
_parameter params [["_amount",3,[0]],["_radius",100,[0]]];
TRACEV_4(_centerposition,_parameter,_radius,_amount);

private _targets = [];
for "_i" from 1 to _amount do {

    private _targetPositions = [_centerposition,["scarab","isObjective"],1,_radius] call FUNC(createMissionComposition);
    private _targetPos = selectRandom (_targetPositions select 0);
    TRACEV_2(_targetPos,_targetPositions);

    private _obj = ["scarab"] call FUNC(getMissionObject);

    TRACEV_2(_centerposition,_obj);
    private _curTarget = createVehicle [_obj, _targetPos,[], 0, "CAN_COLLIDE"];
    private _crew = [_curTarget, createGroup GVARMAIN(side), false] call FUNC(crew);
    TRACEV_1(_crew);

    _targetPos set [2,0];
    _curTarget setPosATL _targetPos;
    If !(isNil QEFUNC(headquarter,registerPOI)) then {
        [_curTarget] call EFUNC(headquarter,registerPOI);
    };

    #ifdef DEBUG_MODE_FULL
        [(getPos _curTarget),"scarab","ColorBlack","hd_destroy"] call EFUNC(common,debug_marker_create);
    #endif

    TRACEV_2(_targetPos,_curTarget);
    _targets pushBack _curTarget;
};

_targets
