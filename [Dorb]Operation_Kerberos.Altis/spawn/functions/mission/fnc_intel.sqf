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
_parameter params [["_amount",3,[0]],["_radius",200,[0]]];
TRACEV_3(_centerposition,_parameter,_amount);
private _intelObjects = [];
private _targetPositions = [_centerposition,["hasmissiontarget","intel"],_amount,_radius] call FUNC(createMissionHouse);
//TRACEV_1(_targetPositions);

for "_i" from 1 to _amount do {
    private _targetPos = selectRandom _targetPositions;
    //TRACEV_1(_targetPos);

    private _obj = ["intel"] call FUNC(getMissionObject);

    //TRACEV_2(_centerposition,_obj);
    private _spawnPos =+ _targetPos;
    _spawnPos resize 3;

    private _curTarget = createVehicle [_obj, _spawnPos,[], 0, "CAN_COLLIDE"];
    _curTarget setPosASL _spawnPos;
    private _spawnDir = random (360);
    _curTarget setDir _spawnDir;

    If !(isNil QEFUNC(headquarter,registerPOI)) then {
        [_curTarget] call EFUNC(headquarter,registerPOI);
    };

    #ifdef DEBUG_MODE_FULL
        [(getPos _curTarget),"Intel","ColorBlack","hd_destroy"] call EFUNC(common,debug_marker_create);
    #endif

    //TRACEV_2(_targetPos,_curTarget);
    _intelObjects pushBack _curTarget;
};
//[_curTarget];
_intelObjects;
